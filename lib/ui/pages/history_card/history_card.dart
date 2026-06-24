import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/models/enum/measure_type.dart';
import 'package:mobile/models/temperature.dart';
import 'package:mobile/ui/pages/history_card/bird_migration_details.dart';
import 'package:mobile/ui/pages/history_card/eggs_laying_details.dart';
import 'package:mobile/ui/pages/history_card/snow_height_details.dart';
import 'package:mobile/ui/pages/history_card/temperature_details.dart';

import '../../../app_theme.dart';
import '../../../models/measure.dart';
import '../../widgets/measure_action_button.dart';

class HistoryCard extends StatelessWidget {

  final Measure item;

  const HistoryCard({
    super.key,
    required this.item,
  });
  /*
  getCorrectCard() {
    switch (item.type) {
      case MeasureType.temperature : return TemperatureDetails(itemId: item.id);
      case MeasureType.snowHeight : return SnowHeightDetails(itemId: item.id);
      case MeasureType.birdMigration : return BirdMigrationDetails(itemId: item.id);
      case MeasureType.eggsLaying : return EggsLayingDetails(itemId: item.id);
    }
  }
   */

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('dd.MM.yyyy').format(item.date),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  item.type.label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          MeasureActionButton(
            title: "Détails",
            onTap: () {
              showDialog(
                context: context,
                barrierColor: Colors.black.withOpacity(0.5),
                builder: (_) => TemperatureDetails(item: item as Temperature), ///TODO modify
              );
            },
          ),
        ],
      ),
    );
  }
}



abstract class MeasureDetails extends StatelessWidget {
  const MeasureDetails({
    super.key,
  });
}