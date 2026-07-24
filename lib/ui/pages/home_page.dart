import 'package:flutter/material.dart';

import '../../app_theme.dart';

/// Display the home page of the application.
///
/// It contains a path to register or log in.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 31),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  Image.asset(
                    'assets/images/logo-vert.png',
                    height: 78,
                  ),

                  const SizedBox(height: 28),

                  Text(
                    "Observatoire du Climat",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 300,
                    height: 2,
                    color: AppColors.forestGreen,
                  ),

                  const Spacer(),

                  HomeButton(
                    title: "Se connecter",
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),

                  const SizedBox(height: 16),

                  HomeButton(
                    title: "Créer un compte",
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const HomeButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightGrey,
          foregroundColor: AppColors.forestGreen,
          elevation: 0,
          side: const BorderSide(color: AppColors.forestGreen),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}