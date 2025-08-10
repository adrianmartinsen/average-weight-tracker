import 'package:flutter/material.dart';
import '../../domain/weighin_repo.dart';

class AddWeighinModal extends StatefulWidget {
  final WeighinRepo weighinRepo;

  const AddWeighinModal({super.key, required this.weighinRepo});

  @override
  State<AddWeighinModal> createState() => _AddWeighinModalState();
}

class _AddWeighinModalState extends State<AddWeighinModal> {
  final _weightController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = DateTime.now().toString().split(" ")[0];
  }

  @override
  void dispose() {
    _weightController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 30,
          right: 30,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Add Weigh-in",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            // INPUT FIELD FOR WEIGHT
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: const InputDecoration(
                filled: true,
                contentPadding: EdgeInsets.all(20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                hintText: "Weight",
              ),
            ),
            const SizedBox(height: 20),
            // INPUT FIELD FOR DATE
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                filled: true,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Icon(Icons.calendar_today),
                ),
                contentPadding: EdgeInsets.all(20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
              ),
              readOnly: true,
              onTap: _selectDate,
            ),
            const SizedBox(height: 20),
            // ACTION BUTTONS: CANCEL AND SUBMIT
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 20,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('CANCEL'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _weightController,
                      builder: (context, value, child) {
                        final isEnabled = value.text.trim().isNotEmpty;
                        return FilledButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isEnabled ? Colors.purple[400] : Colors.grey,
                            foregroundColor: Colors.white,
                            elevation: 20,
                          ),
                          onPressed: isEnabled
                              ? () async {
                                  final weight = double.tryParse(
                                      _weightController.text.trim());
                                  final date =
                                      DateTime.tryParse(_dateController.text);
                                  if (weight != null) {
                                    await widget.weighinRepo
                                        .addWeighin(weight, date!);
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                  }
                                }
                              : null,
                          child: const Text('SUBMIT'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
