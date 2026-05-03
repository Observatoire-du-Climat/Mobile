import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../../widgets/nav_bar.dart';
import '../../widgets/measure_action_button.dart';
import '../../widgets/info_text_section.dart';

class EggsLayingPage extends StatelessWidget {
  const EggsLayingPage({super.key});

  static const String indicatorInfo =
      "Les amphibiens, tels que le crapaud commun ou la grenouille rousse, sont sensibles aux variations climatiques, "
      "car leur migration pour la reproduction dépend des températures, de l’humidité et du cycle des saisons.\n\n"
      "En suivant les dates de migration de ces espèces, à des altitudes différentes, il est possible de détecter les signes "
      "du changement climatique, notamment :\n\n"
      "• Le réchauffement des températures ;\n"
      "• La modification du régime des précipitations.";

  static const String tutorial =
      "Rendez-vous une fois par semaine à partir de mi-février, jusqu’au plan d’eau choisi.\n\n"
      "Vous êtes libre de décider du jour de relevé, mais celui-ci doit rester identique chaque semaine. "
      "En cas d’empêchement ponctuel, le relevé peut être exceptionnellement décalé au jour précédent ou au jour suivant.\n\n"
      "Comptez, à chaque passage, le nombre de pontes des espèces présentes dans l’ensemble du plan d’eau et reportez les résultats.\n\n"
      "Il est normal de compter plusieurs fois les mêmes pontes d’une semaine à l’autre, jusqu’à leur éclosion.";

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
              const _EggLayingForm(),
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

class _EggLayingForm extends StatelessWidget {
  const _EggLayingForm();

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
            "Relevé des Pontes",
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
          const _EggField(label: "Date"),
          const _EggField(label: "Nombre de pontes"),
          const _EggField(label: "Lieu"),
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

class _EggField extends StatelessWidget {
  final String label;

  const _EggField({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              "$label :",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 34,
              child: TextField(
                keyboardType: label == "Nombre de pontes"
                    ? TextInputType.number
                    : TextInputType.text,
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