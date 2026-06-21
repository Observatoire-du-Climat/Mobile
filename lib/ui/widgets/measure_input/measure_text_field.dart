import 'package:flutter/material.dart';
import '../../../app_theme.dart';


class MeasureTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final VoidCallback? onTap;
  final bool readOnly;

  const MeasureTextField({
    super.key,
    required this.label,
    required this.controller,
    this.readOnly = false,
    this.onTap,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 70,
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