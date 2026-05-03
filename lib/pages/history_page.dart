import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../widgets/nav_bar.dart';
import '../widgets/measure_action_button.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  static final List<MeasureHistoryItem> testMeasures = [
    MeasureHistoryItem(date: "07.04.2026", type: "Température", value: "39 °C", location: "Yverdon-les-Bains",),
    MeasureHistoryItem(date: "06.04.2026", type: "Hauteur des Neiges"),
    MeasureHistoryItem(date: "06.04.2026", type: "Température"),
    MeasureHistoryItem(date: "05.04.2026", type: "Température"),
    MeasureHistoryItem(date: "05.04.2026", type: "Hauteur des Neiges"),
    MeasureHistoryItem(date: "04.04.2026", type: "Température"),
    MeasureHistoryItem(date: "03.04.2026", type: "Migrations des Oiseaux"),
    MeasureHistoryItem(date: "02.04.2026", type: "Relevé des Pontes"),
    MeasureHistoryItem(date: "01.04.2026", type: "Température"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: const NavBar(current: NavItem.history),
      body: Stack(
        children: [
          Positioned.fill(
            top: 150,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/images/fond_version_clean.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/logo-vert.png',
                  height: 70,
                ),
                const SizedBox(height: 28),
                Text(
                  "Historique des mesures",
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
                const SizedBox(height: 28),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: testMeasures.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 15),
                    itemBuilder: (context, index) {
                      return HistoryCard(item: testMeasures[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MeasureHistoryItem {
  final String date;
  final String type;
  final String? value;
  final String? location;

  const MeasureHistoryItem({
    required this.date,
    required this.type,
    this.value,
    this.location,
  });
}

class HistoryCard extends StatelessWidget {
  final MeasureHistoryItem item;

  const HistoryCard({
    super.key,
    required this.item,
  });

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
                  item.date,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  item.type,
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
                builder: (_) => MeasureDetailsDialog(item: item),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MeasureDetailsDialog extends StatelessWidget {
  final MeasureHistoryItem item;

  const MeasureDetailsDialog({
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
              item.type,
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

            DetailRow(label: "Date", value: item.date),
            DetailRow(label: "Degré", value: "39 °C"),
            const DetailRow(label: "Lieu", value: "Yverdon-les-Bains"),

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

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              "$label :",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}