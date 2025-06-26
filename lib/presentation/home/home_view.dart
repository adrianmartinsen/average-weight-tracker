import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/weighin_repo.dart';
import '../average-weight/average_weight_page.dart';
import '../settings/settings_view.dart';
import 'add_weighin_modal.dart';
import '../weighin/weighin_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeView> {
  int index = 0;
  Color selectedColor = Colors.purple.shade400;
  Color unselectedColor = Colors.grey;
  double selectedSize = 35;
  double unselectedSize = 30;

  Future _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => AddWeighinModal(
        weighinRepo: context.read<WeighinRepo>(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Average Weight Tracker"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsView(),
                )),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          backgroundColor: Colors.grey[900],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 3,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: index == 0 ? selectedSize : unselectedSize,
                  color: index == 0 ? selectedColor : unselectedColor,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu,
                  size: index == 1 ? selectedSize : unselectedSize,
                  color: index == 1 ? selectedColor : unselectedColor,
                ),
                label: 'History')
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayBottomSheet(context);
        },
        shape: const CircleBorder(),
        elevation: 3,
        child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.purple[400],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add)),
      ),
      body: index == 0 ? const AverageWeightPage() : const WeighinPage(),
    );
  }
}
