import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/user_bloc.dart';
import 'package:mobile/bloc/user_event.dart';
import 'package:mobile/bloc/user_state.dart';

import '../../app_theme.dart';
import '../widgets/large_action_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserConnected) {
            print("Utilisateur connecté");
            Navigator.pushReplacementNamed(context, '/measure');
          }
          if (state is UserError) {
            print("Erreur de connexion");
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: BlocBuilder(
              builder: (context, state) {
                final isLoading = state is UserLoading;

                return Stack(
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
                                    controller: _emailController
                                  ),

                                  const SizedBox(height: 20),

                                  _buildInput(
                                    label: "Mot de passe",
                                    obscure: true,
                                    controller: _passwordController
                                  ),

                                  const SizedBox(height: 30),

                                  LargeActionButton(title: isLoading ? "Chargement..." : "Créer un compte",
                                    onTap: isLoading ? null : () {
                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      }
                                      context.read<UserBloc>().add(
                                          LoginRequest(
                                              email: _emailController.text,
                                              password: _passwordController.text
                                          )
                                      );
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
                );
              },
          )
        )
    );


  }

  Widget _buildInput({
    required String label,
    required bool obscure,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        SizedBox(
          height: 36,
          child: TextFormField(
            controller: controller,
            obscureText: obscure,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Champ obligatoire';
              }
              return null;
            },
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