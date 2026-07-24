import 'package:flutter/material.dart';
import '../../app_theme.dart';
import '../widgets/nav_bar.dart';

import 'package:url_launcher/url_launcher.dart';

/// Display the "main" measure page of the application.
///
/// It contains a button to redirect to each available measure type creation form.
class MeasurePage extends StatelessWidget {
  const MeasurePage({super.key});

  Future<void> _openPhaenonetWebsite() async {
    final Uri url = Uri.parse(
      'https://app.phaenonet.ch/map',
    );
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      body: Stack(
        children: [
          Positioned.fill(
            top: 120,
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

                const SizedBox(height: 30),

                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      MeasureItem(
                        label: "Température",
                        imagePath: "assets/images/FB_picto-Temperature.png",
                        onPressed: (){
                          Navigator.pushNamed(context, '/temperature');
                          },
                      ),
                      MeasureItem(
                        label: "Hauteur des Neiges",
                        imagePath: "assets/images/FB_picto-Neige.png",
                        onPressed: (){
                          Navigator.pushNamed(context, '/snow_height');
                        },
                      ),
                      MeasureItem(
                        label: "Migrations des Oiseaux",
                        imagePath: "assets/images/FB_picto-Hirondelle.png",
                        onPressed: (){
                          Navigator.pushNamed(context, '/bird_migration');
                        },
                      ),
                      MeasureItem(
                        label: "Relevé des Pontes",
                        imagePath: "assets/images/FB_picto-Amphibiens.png",
                        onPressed: (){
                          Navigator.pushNamed(context, '/eggs_laying');
                        },
                      ),
                      MeasureItem(
                        label: "Phénologie végétale",
                        imagePath: "assets/images/FB_picto-Phenologie.png",
                        onPressed: (){
                          _openPhaenonetWebsite();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: const NavBar(
        current: NavItem.measure,
      ),
    );
  }
}

class MeasureItem extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback onPressed;

  const MeasureItem({
    super.key,
    required this.label,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightGrey,
          foregroundColor: AppColors.forestGreen,
          elevation: 0,
          side: const BorderSide(color: AppColors.forestGreen),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}