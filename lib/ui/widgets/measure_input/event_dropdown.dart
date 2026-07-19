import 'package:flutter/material.dart';
import '../../../app_theme.dart';
import '../../../models/enum/bird_event_type.dart';

/// Display the dropdown selection for the event value for a bird migration measure creation or update.
class EventDropdown extends StatelessWidget {
  final BirdEventType selected;
  final ValueChanged<BirdEventType?> onChanged;

  const EventDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 145,
            child: Text(
              "Arrivée/Départ :",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 40,
              child: DropdownButtonFormField<BirdEventType>(
                value: selected,
                isExpanded: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: BirdEventType.arrival,
                    child: Text("Arrivée"),
                  ),
                  DropdownMenuItem(
                    value: BirdEventType.departure,
                    child: Text("Départ"),
                  ),
                ],
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

}