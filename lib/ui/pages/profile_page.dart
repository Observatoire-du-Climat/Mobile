import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/user_bloc.dart';
import 'package:mobile/bloc/user_event.dart';
import 'package:mobile/bloc/user_state.dart';
import 'package:mobile/ui/widgets/large_action_button.dart';

import '../../app_theme.dart';
import '../widgets/nav_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserDisconnected) {
          Navigator.pushReplacementNamed(context, '/home');
        }

        if (state is UserError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
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

                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is UserConnected) {
                          return ProfileCard(
                            name: state.name,
                            email: state.email,
                          );
                        }

                        return const ProfileSection(
                          title: "Profil",
                          child: Text("Aucun utilisateur connecté"),
                        );

                      },
                    ),

                    const SizedBox(height: 40),
                    const SettingsCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String name;
  final String email;

  const ProfileCard({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileSection(
      title: "Profil",
      child: Column(
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            email,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 6),
          Text(
            "Compte validé",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          LargeActionButton(
            title: "Modifier",
            onTap: () {
              Navigator.pushNamed(context, '/profile-update');
            },
          ),
          const SizedBox(height: 8),
          LargeActionButton(
            title: "Déconnexion",
            onTap: () {
              context.read<UserBloc>().add(LogoutRequest());
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
          LargeActionButton(title: "Notifications", onTap: () {}),
          const SizedBox(height: 10),
          LargeActionButton(title: "Confidentialité", onTap: () {}),
          const SizedBox(height: 10),
          LargeActionButton(title: "À propos de", onTap: () {}),
          const SizedBox(height: 10),
          LargeActionButton(title: "Aide", onTap: () {}),
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