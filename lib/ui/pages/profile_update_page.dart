import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/user_bloc.dart';
import 'package:mobile/bloc/user_event.dart';
import 'package:mobile/bloc/user_state.dart';
import 'package:mobile/ui/widgets/measure_action_button.dart';

import '../../app_theme.dart';
import '../widgets/nav_bar.dart';
import '../widgets/user_input.dart';

/// Display a form page to update the current connected user data.
class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {

  final _formKey = GlobalKey();
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
        if (state is UserUpdated) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
          backgroundColor: AppColors.white,
          bottomNavigationBar: const NavBar(current: NavItem.measure),
          body: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return SafeArea(
                    child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                          Image.asset(
                          'assets/images/logo-vert.png',
                          height: 70,
                        ),

                        const SizedBox(height: 40),
                        Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.forestGreen),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                                children: [
                                  Text(
                                    "Modification du profil",
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
                                  MeasureActionButton(
                                      title: "Modifier",
                                      onTap: () {
                                        context.read<UserBloc>().add(
                                          UserUpdateRequest(
                                              name: _nameController.text,
                                              email: _emailController.text,
                                              password: _passwordController.text)
                                        );
                                      }
                                  ),
                                  const SizedBox(height: 20),
                                  MeasureActionButton(
                                      title: "Annuler",
                                      onTap: () {
                                        Navigator.pop(context);
                                      }
                                  )
                                ]),
                          )
                      )
                    ])
                  )
                );
              }
            )
      )
    );
  }
}