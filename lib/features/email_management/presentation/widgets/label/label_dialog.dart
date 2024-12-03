import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/label/label_button_text.dart';

class LabelDialog extends HookWidget {
  LabelDialog({super.key});

  final Map<String, Color> _supportedColors = {
    "Red": Colors.red,
    "Blue": Colors.blue,
    "Green": Colors.green,
    "Orange": Colors.orange,
    "Purple": Colors.purple,
    "Yellow": Colors.yellow,
    "Pink": Colors.pink,
    "Teal": Colors.teal,
  };

  @override
  Widget build(BuildContext context) {
    final selectedColor = useState<Color>(Colors.red);

    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      title: const Text(
        "CREATE LABEL",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextField(
            decoration: InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField(
            value: selectedColor.value,
            decoration: const InputDecoration(
              labelText: "Color",
              border: OutlineInputBorder(),
            ),
            items: _supportedColors.entries.map((entry) {
              return DropdownMenuItem<Color>(
                value: entry.value,
                child: Row(
                  children: [
                    Icon(
                      Icons.label_outline_rounded,
                      color: entry.value,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(entry.key),
                  ],
                ),
              );
            }).toList(),
            onChanged: (Color? newColor) {
              if (newColor != null) {
                selectedColor.value = newColor;
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey,
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const LabelButtonText(text: "Cancel"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.green[300],
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const LabelButtonText(text: "Create"),
        ),
      ],
    );
  }
}
