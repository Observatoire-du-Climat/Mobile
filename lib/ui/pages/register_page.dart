import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../widgets/large_action_button.dart';


class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
            child: SingleChildScrollView(
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
                  const SizedBox(height: 38),
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
                          "Créer un compte",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: 170,
                          height: 1,
                          color: AppColors.forestGreen,
                        ),
                        const SizedBox(height: 30),
                        const AuthInput(label: "Nom Prénom"),
                        const SizedBox(height: 20),
                        const AuthInput(
                          label: "Adresse email",
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),
                        const AuthInput(
                          label: "Mot de passe",
                          obscureText: true,
                        ),
                        const SizedBox(height: 30),
                        LargeActionButton(
                          title: "Créer un compte",
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/measure');
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
}

class AuthInput extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextInputType keyboardType;

  const AuthInput({
    super.key,
    required this.label,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 36,
          child: TextField(
            obscureText: obscureText,
            keyboardType: keyboardType,
            decoration: const InputDecoration(
              filled: true,
              fillColor: AppColors.white,
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