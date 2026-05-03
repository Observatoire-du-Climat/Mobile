import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../../widgets/nav_bar.dart';
import '../../widgets/measure_action_button.dart';
import '../../widgets/info_text_section.dart';

enum MigrationType {
  arrival,
  departure,
}

class BirdMigrationPage extends StatefulWidget {
  const BirdMigrationPage({super.key});

  @override
  State<BirdMigrationPage> createState() => _BirdMigrationPageState();
}

class _BirdMigrationPageState extends State<BirdMigrationPage> {
  MigrationType _migrationType = MigrationType.arrival;

  static const String indicatorInfo =
      "Les hirondelles et les martinets sont des oiseaux migrateurs parcourant chaque année plusieurs milliers de kilomètres "
      "entre leurs lieux d’hivernage et leurs sites de reproduction.\n\n"
      "Leur cycle migratoire dépend fortement des conditions climatiques, notamment de la température et de la disponibilité "
      "en insectes, leur principale source de nourriture.\n\n"
      "L’observation de leur arrivée au printemps et de leur départ en automne permet de recueillir des informations sur les "
      "changements saisonniers et leurs effets sur la biodiversité.\n\n"
      "Hirondelle de fenêtre : arrivée de mi-avril à fin mai / départ de mi-août à fin octobre.\n"
      "Hirondelle rustique : arrivée de mi-mars à fin mai / départ de mi-août à fin octobre.\n"
      "Martinet : arrivée de mi-avril à fin mai / départ de fin juin à fin septembre.";

  static const String tutorial =
      "Relevez, dans les périodes précédemment citées, l’arrivée du premier individu et le départ du dernier individu, "
      "pour chaque espèce, depuis votre lieu d’habitation.\n\n"
      "Il n’est pas nécessaire que ces individus soient associés à un site en particulier : il suffit simplement de noter "
      "les premiers oiseaux observés dans le ciel et les derniers à repartir.";

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
              _BirdMigrationForm(
                migrationType: _migrationType,
                onMigrationChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    _migrationType = value;
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

class _BirdMigrationForm extends StatelessWidget {
  final MigrationType migrationType;
  final ValueChanged<MigrationType?> onMigrationChanged;

  const _BirdMigrationForm({
    required this.migrationType,
    required this.onMigrationChanged,
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
            "Migrations des Oiseaux",
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
          const _BirdField(label: "Date"),
          const _BirdField(label: "Oiseaux"),
          _MigrationRadioGroup(
            selected: migrationType,
            onChanged: onMigrationChanged,
          ),
          const _BirdField(label: "Lieu"),
          const SizedBox(height: 24),
          MeasureActionButton(
            title: "Valider",
            onTap: () {
              //
            },
          ),
        ],
      ),
    );
  }
}

class _BirdField extends StatelessWidget {
  final String label;

  const _BirdField({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 120,
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

class _MigrationRadioGroup extends StatelessWidget {
  final MigrationType selected;
  final ValueChanged<MigrationType?> onChanged;

  const _MigrationRadioGroup({
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
            width: 120,
            child: Text(
              "Arrivée / Départ :",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                _MigrationRadioOption(
                  label: "Arrivée",
                  value: MigrationType.arrival,
                  selected: selected,
                  onChanged: onChanged,
                ),
                _MigrationRadioOption(
                  label: "Départ",
                  value: MigrationType.departure,
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

class _MigrationRadioOption extends StatelessWidget {
  final String label;
  final MigrationType value;
  final MigrationType selected;
  final ValueChanged<MigrationType?> onChanged;

  const _MigrationRadioOption({
    required this.label,
    required this.value,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: RadioListTile<MigrationType>(
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