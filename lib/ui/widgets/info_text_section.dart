import 'package:flutter/material.dart';
import '../../app_theme.dart';

class InfoTextSection extends StatelessWidget {
  final String title;
  final String paragraph;

  const InfoTextSection({
    super.key,
    required this.title,
    required this.paragraph,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 170,
          height: 2,
          color: AppColors.forestGreen,
        ),
        const SizedBox(height: 12),
        Text(
          paragraph,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}