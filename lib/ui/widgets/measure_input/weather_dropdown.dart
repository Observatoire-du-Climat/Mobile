import 'package:flutter/material.dart';

import '../../../app_theme.dart';
import '../../../models/enum/weather_type.dart';

/// Display the dropdown selection for the weather value for a snow height measure creation or update.
class WeatherDropdown extends StatelessWidget {
  final WeatherType selected;
  final ValueChanged<WeatherType?> onChanged;

  const WeatherDropdown({
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
              "Conditions météo :",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 40,
              child: DropdownButtonFormField<WeatherType>(
                initialValue: selected,
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
                    value: WeatherType.sunny,
                    child: Text("Soleil"),
                  ),
                  DropdownMenuItem(
                    value: WeatherType.cloudy,
                    child: Text("Nuageux"),
                  ),
                  DropdownMenuItem(
                    value: WeatherType.rainy,
                    child: Text("Pluie"),
                  ),
                  DropdownMenuItem(
                    value: WeatherType.snowy,
                    child: Text("Neige"),
                  ),
                  DropdownMenuItem(
                    value: WeatherType.windy,
                    child: Text("Venteux"),
                  )
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