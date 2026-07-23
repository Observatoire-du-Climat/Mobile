import 'package:flutter/material.dart';
import '../../../app_theme.dart';

/// Display a text input for a measure creation or update.
class MeasureTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final VoidCallback? onTap;
  final bool readOnly;
  final double titleWidth;

  const MeasureTextField({
    super.key,
    required this.label,
    required this.controller,
    this.readOnly = false,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.titleWidth = 70
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: titleWidth,
            child: Text(
              "$label :",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 34,
              child: TextFormField(
                controller: controller,
                readOnly: readOnly,
                onTap: onTap,
                keyboardType: keyboardType,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Champ Obligatoire';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}