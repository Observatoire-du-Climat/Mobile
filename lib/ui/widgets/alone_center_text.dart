import 'package:flutter/material.dart';

import '../../app_theme.dart';

/// Display a information text in the middle of the screen when something is loading or an error occurred.
class AloneCenterText extends StatelessWidget {

  final String label;

  const AloneCenterText({
    super.key,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.forestGreen),
      ),
      child: Text(label,
        style:Theme.of(context).textTheme.bodyLarge,),
    );
  }
}