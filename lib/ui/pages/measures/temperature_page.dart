import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile/bloc/measure_bloc.dart';
import 'package:mobile/bloc/measure_event.dart';
import 'package:mobile/bloc/measure_state.dart';
import 'package:mobile/ui/widgets/measure_input/measure_date_field.dart';
import 'package:mobile/utils/date_picker_helper.dart';
import 'package:mobile/utils/image_picker_helper.dart';

import '../../../app_theme.dart';
import '../../widgets/nav_bar.dart';
import '../../widgets/measure_action_button.dart';
import '../../widgets/info_text_section.dart';
import '../../widgets/measure_input/measure_text_field.dart';

class TemperaturePage extends StatefulWidget {
  const TemperaturePage({super.key});

  @override
  State<TemperaturePage> createState() => _TemperaturePageState();

}

class _TemperaturePageState extends State<TemperaturePage> {

  static const String indicatorInfo =
      "Le suivi régulier de la température permet d’observer l’évolution des conditions environnementales locales. "
      "En réalisant chaque jour et à la même heure une mesure au même endroit, il est possible d’obtenir des données qui permettent :\n\n"
      "• De suivre les variations saisonnières ;\n"
      "• D’identifier d’éventuelles anomalies et leur fréquence ;\n"
      "• D’observer l’évolution de la température sur le moyen/long terme ;\n"
      "• D’observer l’influence de l’environnement sur la température.\n\n"
      "Le relevé de ces données complète les informations fournies par les stations météorologiques existantes, "
      "offrant ainsi une vision plus précise et localisée des conditions réelles sur le terrain.";

  static const String tutorial =
      "Rendez-vous sur votre site et prenez la mesure de température.\n\n"
      "Relevez la température à la même heure chaque jour pour éviter les biais liés aux variations naturelles au cours de la journée.\n\n"
      "Le relevé doit être réalisé à 8h en hiver et 7h en été pour cadrer avec la température minimale journalière.\n\n"
      "Reportez la mesure en degrés Celsius (°C).";

  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();
  final _degreeController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _locationController.dispose();
    _degreeController.dispose();
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
                                  "Température",
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
                                MeasureTextField(label: "Degré", controller: _degreeController, keyboardType: TextInputType.number,),

                                const SizedBox(height: 24),

                                if (_selectedPicture != null) Text(' ${_selectedPicture!.path} ajoutée !'),

                                if (_selectedPicture != null) const SizedBox(height: 24),


                                Column(
                                  children: [
                                    MeasureActionButton(
                                      title: _selectedPicture == null ? "Ajout photo" : "Changer Photo",
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
                                            CreateTemperatureRequest(
                                                date: _selectedDate!,
                                                location: _locationController.text.trim(),
                                                degree: int.parse(_degreeController.text.trim()),
                                                picture: _selectedPicture
                                            )
                                        );
                                      },
                                    ),
                                  ],
                                ),
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
        ),
    );
  }
}