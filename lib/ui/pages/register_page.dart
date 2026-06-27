import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/user_bloc.dart';
import 'package:mobile/bloc/user_event.dart';
import 'package:mobile/bloc/user_state.dart';
import 'package:mobile/ui/widgets/user_input.dart';

import '../../app_theme.dart';
import '../widgets/large_action_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
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
          print("Erreur de creation");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }

      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: BlocBuilder<UserBloc, UserState>(
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
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 31),
                      child: Form(
                        key: _formKey,
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
                                  UserInput(
                                      label: "Nom Prénom",
                                      controller: _nameController),
                                  const SizedBox(height: 20),
                                  UserInput(
                                    label: "Adresse email",
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _emailController,
                                  ),
                                  const SizedBox(height: 20),
                                  UserInput(
                                    label: "Mot de passe",
                                    obscure: true,
                                    controller: _passwordController,
                                  ),
                                  const SizedBox(height: 30),
                                  LargeActionButton(
                                    title: isLoading ? "Chargement..." : "Créer un compte",
                                    onTap: isLoading ? null : () {
                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      }
                                      context.read<UserBloc>().add(
                                          RegisterRequest(
                                              name: _nameController.text,
                                              email: _emailController.text,
                                              password: _passwordController.text)
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
                      )
                    ),
                  ),
                ],
              );
            }
        )
      ),
    );
  }
}
