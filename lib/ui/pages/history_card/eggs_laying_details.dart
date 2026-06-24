import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/models/eggs_laying.dart';
import 'package:mobile/ui/pages/history_card/history_card.dart';

import '../../../app_theme.dart';
import '../../widgets/measure_action_button.dart';
import 'detail_row.dart';

class EggsLayingDetails extends MeasureDetails{
  final EggsLaying item;

  const EggsLayingDetails({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.lightGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.forestGreen),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.type.label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Container(
              width: 170,
              height: 1,
              color: AppColors.forestGreen,
            ),

            const SizedBox(height: 32),

            DetailRow(label: "Date", value: DateFormat('dd.MM.yyyy').format(item.date)),
            DetailRow(label: "Lieu", value: item.location),
            DetailRow(label: "Nombre de pontes", value: item.number.toString()),

            const SizedBox(height: 32),

            MeasureActionButton(
              title: "Modifier",
              onTap: () {
                Navigator.pop(context);
                //
              },
            ),
            const SizedBox(height: 12),
            MeasureActionButton(
              title: "Supprimer",
              onTap: () {
                Navigator.pop(context);
                //
              },
            ),
          ],
        ),
      ),
    );
  }
}