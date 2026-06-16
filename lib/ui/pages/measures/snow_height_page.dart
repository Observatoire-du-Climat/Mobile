import 'package:flutter/material.dart';

import '../../../app_theme.dart';
import '../../widgets/nav_bar.dart';
import '../../widgets/measure_action_button.dart';
import '../../widgets/info_text_section.dart';

enum WeatherCondition {
  soleil,
  pluie,
  neige,
}

class SnowHeightPage extends StatefulWidget {
  const SnowHeightPage({super.key});

  @override
  State<SnowHeightPage> createState() => _SnowHeightPageState();
}

class _SnowHeightPageState extends State<SnowHeightPage> {
  WeatherCondition _weatherCondition = WeatherCondition.soleil;

  static const String indicatorInfo =
      "Le manteau neigeux correspond à la couche de neige qui recouvre le sol durant l’hiver. "
      "Il joue un rôle essentiel dans les écosystèmes montagnards, en régulant la température du sol, "
      "en protégeant certaines espèces végétales et animales, et en constituant une réserve d’eau précieuse.\n\n"
      "La mesure du manteau neigeux, réalisée à l’aide de mâts gradués installés à des emplacements fixes, permet de :\n\n"
      "• Suivre la durée de l’enneigement ;\n"
      "• Identifier la période de fonte.\n\n"
      "Le relevé de ces données complète les informations fournies par les stations météorologiques existantes.";

  static const String tutorial =
      "Se rendre une fois par jour à 8h, d’octobre à mi-mai, sur le site choisi, en cas de présence de neige.\n\n"
      "Relevez la hauteur de neige en cm à l’aide du mât gradué.\n\n"
      "Indiquez les conditions météo lors du relevé : soleil, pluie ou neige.\n\n"
      "Indiquez si des précipitations neigeuses ont eu lieu le jour de votre passage.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: const NavBar(current: NavItem.measure),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo-vert.png',
                height: 70,
              ),

              const SizedBox(height: 40),

              _SnowHeightForm(
                weatherCondition: _weatherCondition,
                onWeatherChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    _weatherCondition = value;
                  });
                },
              ),

              const SizedBox(height: 32),

              const InfoTextSection(
                title: "Informations sur l'indicateur",
                paragraph: indicatorInfo,
              ),

              const SizedBox(height: 32),

              const InfoTextSection(
                title: "Tutoriel",
                paragraph: tutorial,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SnowHeightForm extends StatelessWidget {
  final WeatherCondition weatherCondition;
  final ValueChanged<WeatherCondition?> onWeatherChanged;

  const _SnowHeightForm({
    required this.weatherCondition,
    required this.onWeatherChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.forestGreen),
      ),
      child: Column(
        children: [
          Text(
            "Hauteur des Neiges",
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

          const _SnowField(label: "Date"),
          const _SnowField(label: "Hauteur"),
          _WeatherRadioGroup(
            selected: weatherCondition,
            onChanged: onWeatherChanged,
          ),
          const _SnowField(label: "Précipitations neigeuses"),
          const _SnowField(label: "Lieu"),

          const SizedBox(height: 24),

          Column(
            children: [
              MeasureActionButton(
                title: "Photo",
                onTap: () {
                  //
                },
              ),
              const SizedBox(height: 12),
              MeasureActionButton(
                title: "Valider",
                onTap: () {
                  //
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SnowField extends StatelessWidget {
  final String label;

  const _SnowField({
    required this.label,
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
              "$label :",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 34,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
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

class _WeatherRadioGroup extends StatelessWidget {
  final WeatherCondition selected;
  final ValueChanged<WeatherCondition?> onChanged;

  const _WeatherRadioGroup({
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 145,
            child: Text(
              "Conditions météo :",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                _WeatherRadioOption(
                  label: "Soleil",
                  value: WeatherCondition.soleil,
                  selected: selected,
                  onChanged: onChanged,
                ),
                _WeatherRadioOption(
                  label: "Pluie",
                  value: WeatherCondition.pluie,
                  selected: selected,
                  onChanged: onChanged,
                ),
                _WeatherRadioOption(
                  label: "Neige",
                  value: WeatherCondition.neige,
                  selected: selected,
                  onChanged: onChanged,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WeatherRadioOption extends StatelessWidget {
  final String label;
  final WeatherCondition value;
  final WeatherCondition selected;
  final ValueChanged<WeatherCondition?> onChanged;

  const _WeatherRadioOption({
    required this.label,
    required this.value,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: RadioListTile<WeatherCondition>(
        value: value,
        groupValue: selected,
        onChanged: onChanged,
        dense: true,
        contentPadding: EdgeInsets.zero,
        activeColor: AppColors.forestGreen,
        title: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}