import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../../widgets/nav_bar.dart';
import '../../widgets/measure_action_button.dart';
import '../../widgets/info_text_section.dart';

class TemperaturePage extends StatelessWidget {
  const TemperaturePage({super.key});

  static const String indicatorInfo =
      "Le suivi régulier de la température permet d’observer l’évolution des conditions environnementales locales. "
      "En réalisant chaque jour et à la même heure une mesure au même endroit, il est possible d’obtenir des données qui permettent :\n\n"
      "• De suivre les variations saisonnières ;\n"
      "• D’identifier d’éventuelles anomalies et leur fréquence ;\n"
      "• D’observer l’évolution de la température sur le moyen/long terme ;\n"
      "• D’observer l’influence de l’environnement sur la température.\n\n"
      "Le relevé de ces données complète les informations fournies par les stations météorologiques existantes, "
      "offrant ainsi une vision plus précise et localisée des conditions réelles sur le terrain.";

  static const String tutorial =
      "Rendez-vous sur votre site et prenez la mesure de température.\n\n"
      "Relevez la température à la même heure chaque jour pour éviter les biais liés aux variations naturelles au cours de la journée.\n\n"
      "Le relevé doit être réalisé à 8h en hiver et 7h en été pour cadrer avec la température minimale journalière.\n\n"
      "Reportez la mesure en degrés Celsius (°C).";

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

              const TemperatureForm(),

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

class TemperatureForm extends StatelessWidget {
  const TemperatureForm({super.key});

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
            "Température",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Container(
            width: 170,
            height: 1,
            color: AppColors.forestGreen,
          ),

          const SizedBox(height: 32),

          const TemperatureField(label: "Date"),
          const TemperatureField(label: "Degré"),
          const TemperatureField(label: "Lieu"),

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

class TemperatureField extends StatelessWidget {
  final String label;

  const TemperatureField({
    super.key,
    required this.label,
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
              child: TextField(
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