import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile/bloc/measure_bloc.dart';
import 'package:mobile/bloc/measure_event.dart';
import 'package:mobile/bloc/measure_state.dart';
import 'package:mobile/models/enum/bird_event_type.dart';
import 'package:mobile/models/enum/bird_specie.dart';
import 'package:mobile/ui/widgets/measure_input/event_dropdown.dart';
import 'package:mobile/ui/widgets/measure_input/measure_date_field.dart';
import 'package:mobile/ui/widgets/measure_input/measure_text_field.dart';
import 'package:mobile/ui/widgets/measure_input/specie_dropdown.dart';

import '../../../app_theme.dart';
import '../../../utils/date_picker_helper.dart';
import '../../../utils/image_picker_helper.dart';
import '../../widgets/nav_bar.dart';
import '../../widgets/measure_action_button.dart';
import '../../widgets/info_text_section.dart';

class BirdMigrationPage extends StatefulWidget {
  const BirdMigrationPage({super.key});

  @override
  State<BirdMigrationPage> createState() => _BirdMigrationPageState();
}

class _BirdMigrationPageState extends State<BirdMigrationPage> {
  BirdSpecie _specie = BirdSpecie.swallow;
  BirdEventType _eventType = BirdEventType.arrival;

  static const String indicatorInfo =
      "Les hirondelles et les martinets sont des oiseaux migrateurs parcourant chaque année plusieurs milliers de kilomètres "
      "entre leurs lieux d’hivernage et leurs sites de reproduction.\n\n"
      "Leur cycle migratoire dépend fortement des conditions climatiques, notamment de la température et de la disponibilité "
      "en insectes, leur principale source de nourriture.\n\n"
      "L’observation de leur arrivée au printemps et de leur départ en automne permet de recueillir des informations sur les "
      "changements saisonniers et leurs effets sur la biodiversité.\n\n"
      "Hirondelle de fenêtre : arrivée de mi-avril à fin mai / départ de mi-août à fin octobre.\n"
      "Hirondelle rustique : arrivée de mi-mars à fin mai / départ de mi-août à fin octobre.\n"
      "Martinet : arrivée de mi-avril à fin mai / départ de fin juin à fin septembre.";

  static const String tutorial =
      "Relevez, dans les périodes précédemment citées, l’arrivée du premier individu et le départ du dernier individu, "
      "pour chaque espèce, depuis votre lieu d’habitation.\n\n"
      "Il n’est pas nécessaire que ces individus soient associés à un site en particulier : il suffit simplement de noter "
      "les premiers oiseaux observés dans le ciel et les derniers à repartir.";

  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    final picked = await DatePickerHelper.pickDate(context);
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd.MM.yyyy').format(picked);
      });
    }
  }

  File? _selectedPicture;

  Future<void> _pickPicture() async {
    try {
      final picture = await ImagePickerHelper.showPicker(context);
      if (picture != null) {
        setState(() {
          _selectedPicture = picture;
        });
      }
    } catch (e) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Impossible d'accéder à la caméra ou à la galerie.",
        ),
      ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MeasureBloc, MeasureState>(
        listener: (context, state) {
          if (state is MeasureCreationError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is MeasureCreated) {
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          bottomNavigationBar: const NavBar(current: NavItem.measure),
          body: BlocBuilder<MeasureBloc, MeasureState>(
              builder: (context, state) {
                final isLoading = state is MeasureCreationLoading;
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
                          padding: const EdgeInsets.all(24),
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
                                    "Migrations des Oiseaux",
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
                                  MeasureDateField(label: "Date", controller: _dateController, onTap: _pickDate),
                                  MeasureTextField(label: "Lieu", controller: _locationController,),
                                  SpecieDropdown(
                                      selected: _specie,
                                      onChanged: (value) {
                                        if (value == null) return;

                                        setState(() {
                                          _specie = value;
                                        });
                                      }),
                                  EventDropdown(
                                      selected: _eventType,
                                      onChanged: (value) {
                                        if (value == null) return;

                                        setState(() {
                                          _eventType = value;
                                        });
                                      }),
                                  const SizedBox(height: 24),

                                  if (_selectedPicture != null) Text(' Image ajoutée !'),

                                  if (_selectedPicture != null) const SizedBox(height: 24),

                                  Column(
                                    children: [
                                      MeasureActionButton(
                                        title: _selectedPicture == null ? "Ajout Photo" : "Changer Photo",
                                        onTap: _pickPicture,
                                      ),
                                      const SizedBox(height: 12),
                                      MeasureActionButton(
                                        title: isLoading ? "Chargement..." : "Valider",
                                        onTap: isLoading ? null : () {
                                          if (!_formKey.currentState!.validate()) {
                                            return;
                                          }
                                          context.read<MeasureBloc>().add(
                                              CreateBirdMigrationRequest(
                                                  date: _selectedDate!,
                                                  location: _locationController.text.trim(),
                                                  specie: _specie,
                                                  event: _eventType,
                                                  picture: _selectedPicture
                                              )
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                          )
                        ),
                        const SizedBox(height: 32),
                        const InfoTextSection(
                          title: "Informations sur l'indicateur",
                          paragraph: indicatorInfo,
                        ),
                        const SizedBox(height: 32),
                        const InfoTextSection(
                          title: "Tutoriel",
                          paragraph: tutorial,
                        ),
                      ],
                    ),
                  ),
                );
              }
          )
        )
    );
  }
}