import 'package:flutter/material.dart';
import 'package:mobile/widgets/profile_action_button.dart';

import '../app_theme.dart';
import '../widgets/nav_bar.dart';
import '../widgets/measure_action_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: const NavBar(current: NavItem.profile),
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo-vert.png',
                    height: 70,
                  ),
                  const SizedBox(height: 40),
                  const ProfileCard(),
                  const SizedBox(height: 40),
                  const SettingsCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileSection(
      title: "Profil",
      child: Column(
        children: [
          Text(
            "David Berger",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "david.berger@heig-vd.ch",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 6),
          Text(
            "Compte validé",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          ProfileActionButton(
            title: "Modifier",
            onTap: () {
              //
            },
          ),
          const SizedBox(height: 8),
          ProfileActionButton(
            title: "Déconnexion",
            onTap: () {
              //
            },
          ),
        ],
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileSection(
      title: "Paramètres",
      child: Column(
        children: [
          ProfileActionButton(title: "Notifications", onTap: () {}),
          const SizedBox(height: 10),
          ProfileActionButton(title: "Confidentialité", onTap: () {}),
          const SizedBox(height: 10),
          ProfileActionButton(title: "À propos de", onTap: () {}),
          const SizedBox(height: 10),
          ProfileActionButton(title: "Aide", onTap: () {}),
        ],
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  final String title;
  final Widget child;

  const ProfileSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            title,
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
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }
}