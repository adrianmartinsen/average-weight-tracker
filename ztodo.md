Trying to implement SharedPreferences for AverageWeightCard to store user selection, or show a default choice.

- What does the AverageCard need to know? It only needs to know the period for what weight to show. The other parameters are given by other datasources.

Made a model to with a toJson method as suggested by CoPilot. Guess I need a repository, service and an implementation of the repository?

CoPilot has created all the necessary files. Review them and if they make sense implement them.

- Do you really need a stream to load the cards?
  - No, but I'm leaving it in for now. The Future getCardConfig should be sufficient to load on app start and presumably when creating or deleting a card.
- Why is the selection of cards stored as JSON and not just a List<String> (or create an enum?).

Review all Cubits

- make all cubits require their repositories

```
AverageWeightViewCubit({required CardConfigRepo cardConfigRepo})
    : _cardConfigRepo = cardConfigRepo, super([]);
```

- make all repo fields private for each cubit

```
final CardConfigRepo _cardConfigRepo;
```

The \_addCard function in Average Weight View needs a StatefulBuilder to make the radiobuttons work properly, but when I add the builder it looses the context of the cubit.

- I just had to give it the right context. Since the DialogContext worked without the StatefulBuilder I just gave the DialogContext to the builder and it worked like before...

I added a check to the cubit to stop duplicating periods in the config, but I can't the error to emit to the view properly.

I have successfully changed my settings to use a settings object. The weight unit still works as intended so I should now be able to build on this going forward. Next I need to get reminders in the settings, but first I think I just want to get notifications working. I've made a few steps:

- Added Notification Service with init function that is called from main
- Enabled desugaring in the gradle.build

Next I should verify if I need to adjust permissions for iOS and Android. Then I need to figure out where to put the logic for the notification itself. Oh, and clean up some of that mess made by Gemini while refactoring the settings code....

- Added necessary permissions for Android and iOS. The Android emulator did not prompt to allow notifications, however, but I turned them on in the Permission Manager and now it work. I made a test 'showNotification' function and called it from a button in the settings menu.

Now I need to configure the whole reminder and scheduled notification stuff. Not to mention how to implement logic from the notification service, via the settings repo into the settings cubit...

- Even after wiping user data and rebuilding the app it does not ask for permission to send notification.

I asked Gemini to implement my showNotification function from NotificationService using the Bloc structure, and it actually did a good job. It didin't mess with the logic I had already made, it just modified the necessary files to implement the logic using the Bloc architechture as I asked it to.

- Still need to figure out this whole permission-on-startup thing...

Gemini did a half decent job of implementing the reminder function without screweing with any existing functionality. Now I just need some more testing to see if this actually works. Time for another upload to the Play Console and this time get some testers to use the new feature...

- Timezone for scheduled notifications doesn't seem to be right
  - local_notification package defaults to UTC for timezone
- Device is not prompting for access to notifcation permissions. However, works once permissions are set manually

Okay, we are gettings somewhere. After like 3 different methods Gemini came in clutch with the system timezone package. Had to ammend the method it was trying to use and adjust the String configuration (SystemTimezone can be null, but the setLocation can't except a null value so I just forced with a !). And with a print statement it gave me the correct location at startup! Now I need to ensure that the code I got to check permissions work. It did work on my first attempt, but since I declined it seems to be stuck. I did get some error about "a permission request in progress" so it might be the emulator. Will have to try and build the app on my phone later to see if the emulator is the issue here.

- Seems like if you deny notification access once it will not prompt again. This is by design. Gemini propesed the following solution:
  1. Add the permission_handler package.
  2. Update notification_service.dart to open app settings if permission
     is denied.
  3. Update settings_cubit.dart to show a dialog explaining the need for
     the permission.

For now I don't want to add the permission_handler package, but it would be something to consider as it appearantly handles permissions better on iOS than local_notifications package. In general it seems like a more robust option to handle permissions, and possible the code can be split so that notifications is handled in one service and permissions in another. Right now the NotificationService is getting quite out of hand with handling everything.

- To show the weighin modal when tapping a notification Gemini made the MainApp stateful. Let's see if we can change the implementation somehow.

Okay, Gemini came through again. I'm starting to really like how this AI does things. It made a NavigationService to handle showing the modal when a notification is tapped. I'm not quite sure how this works, but it needs some sort of GlobalKey of type NavigatorState. Seems like these things are built into Flutter as no extra library was needed. Anyway, it also made NotificationService cleaner as there was no need for the streams to listen to changes in the MainApp.

- Next thing to consider: add permission_handler package and refactor all permission code to a separate PermissionService. The benefits seems numerous:
  1. permission_handler is more robust and handles iOS better
  2. separation of concerns: permissions has its own service
  3. better code clarity and maintainability
  4. possibilty to add more functionality incase user denies notification permissions (see above)

Here's the refactoring plan:

1.  Add permission_handler to pubspec.yaml.
2.  Create permission_service.dart to encapsulate all permission logic.
3.  Remove permission logic from notification_service.dart.
4.  Update settings_cubit.dart and app_settings_repo.dart to use the new
    PermissionService.

This would be a good idea to do if I get production access. Rework the permissions and remove the test notification button.

- Also before release, add a delete all function

---

A last feature to consider is Health Connect. In my mind I just want the app to query Health Connect for weighins from the last 30 days every time the app starts. That way you don't get a massive query load and for my own use last 30 days is all I need. Maybe I can make a manual process where you can request all records from Health Connect to populate the database (like if you are a new user).

- This will be a massive feature and will only really consider this once the app is live and I have a clear path to monetization.

---

- Prepare a release for open testing

1. Remove the test notification option - just comment out the code?
2. Change the namespace from bloc_weighin to something more approprate
3. Add the delete all function to the settings page? - leave this for actual production release

---

Upgrade to 16KB page size

- the package system_timezone is not compatible with 16KB memory page size
- last update to the package was 14 months ago - doesn't look like it's in development

Try to replace system_timezone with flutter_timezone and timezone (already have the last one).
