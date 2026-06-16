import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../widgets/large_action_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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

                  const SizedBox(height: 40),

                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.forestGreen),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Connexion",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 1,
                          color: AppColors.forestGreen,
                        ),

                        const SizedBox(height: 30),

                        _buildInput(
                          label: "Adresse email",
                          obscure: false,
                        ),

                        const SizedBox(height: 20),

                        _buildInput(
                          label: "Mot de passe",
                          obscure: true,
                        ),

                        const SizedBox(height: 30),

                        LargeActionButton(
                          title: "Se connecter",
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, '/measure');
                          },
                        ),

                        const SizedBox(height: 12),

                        LargeActionButton(
                          title: "Annuler",
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput({
    required String label,
    required bool obscure,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        SizedBox(
          height: 36,
          child: TextField(
            obscureText: obscure,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}