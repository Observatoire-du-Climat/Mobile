import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile/bloc/measure_bloc.dart';
import 'package:mobile/bloc/measure_event.dart';
import 'package:mobile/bloc/measure_state.dart';
import 'package:mobile/ui/widgets/measure_input/measure_date_field.dart';
import 'package:mobile/ui/widgets/measure_input/measure_text_field.dart';

import '../../../app_theme.dart';
import '../../../utils/date_picker_helper.dart';
import '../../../utils/image_picker_helper.dart';
import '../../widgets/nav_bar.dart';
import '../../widgets/measure_action_button.dart';
import '../../widgets/info_text_section.dart';

class EggsLayingPage extends StatefulWidget {
  const EggsLayingPage({super.key});

  @override
  State<EggsLayingPage> createState() => _EggsLayingPageState();

}

class _EggsLayingPageState extends State<EggsLayingPage> {

  static const String indicatorInfo =
      "Les amphibiens, tels que le crapaud commun ou la grenouille rousse, sont sensibles aux variations climatiques, "
      "car leur migration pour la reproduction dépend des températures, de l’humidité et du cycle des saisons.\n\n"
      "En suivant les dates de migration de ces espèces, à des altitudes différentes, il est possible de détecter les signes "
      "du changement climatique, notamment :\n\n"
      "• Le réchauffement des températures ;\n"
      "• La modification du régime des précipitations.";

  static const String tutorial =
      "Rendez-vous une fois par semaine à partir de mi-février, jusqu’au plan d’eau choisi.\n\n"
      "Vous êtes libre de décider du jour de relevé, mais celui-ci doit rester identique chaque semaine. "
      "En cas d’empêchement ponctuel, le relevé peut être exceptionnellement décalé au jour précédent ou au jour suivant.\n\n"
      "Comptez, à chaque passage, le nombre de pontes des espèces présentes dans l’ensemble du plan d’eau et reportez les résultats.\n\n"
      "Il est normal de compter plusieurs fois les mêmes pontes d’une semaine à l’autre, jusqu’à leur éclosion.";

  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();
  final _numberController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _locationController.dispose();
    _numberController.dispose();
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
                                  "Relevé des Pontes",
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
                                MeasureDateField(label: "Date", controller: _dateController, onTap: _pickDate,),
                                MeasureTextField(label: "Lieu", controller: _locationController,),
                                MeasureTextField(label: "Nombre de pontes", controller: _numberController, keyboardType: TextInputType.number,),
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
                                          CreateEggsLayingRequest(
                                            date: _selectedDate!,
                                            location: _locationController.text.trim(),
                                            number: int.parse(_numberController.text.trim()),
                                            picture: _selectedPicture
                                          )
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            )
                        ),
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