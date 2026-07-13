import 'package:flutter/material.dart';
import 'package:mobile/ui/widgets/measure_input/measure_text_field.dart';

class MeasureDateField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback onTap;

  const MeasureDateField({
    super.key,
    required this.label,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MeasureTextField(label: label, controller: controller, readOnly: true, onTap: onTap,);
  }
}