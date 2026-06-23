import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile/bloc/measure_bloc.dart';
import 'package:mobile/bloc/measure_event.dart';
import 'package:mobile/bloc/measure_state.dart';
import 'package:mobile/models/enum/weather_type.dart';
import 'package:mobile/ui/widgets/measure_input/measure_date_field.dart';
import 'package:mobile/ui/widgets/measure_input/measure_text_field.dart';

import '../../../app_theme.dart';
import '../../widgets/nav_bar.dart';
import '../../widgets/measure_action_button.dart';
import '../../widgets/info_text_section.dart';


class SnowHeightPage extends StatefulWidget {
  const SnowHeightPage({super.key});

  @override
  State<SnowHeightPage> createState() => _SnowHeightPageState();
}

class _SnowHeightPageState extends State<SnowHeightPage> {
  WeatherType _weatherCondition = WeatherType.sunny;

  static const String indicatorInfo =
      "Le manteau neigeux correspond à la couche de neige qui recouvre le sol durant l’hiver. "
      "Il joue un rôle essentiel dans les écosystèmes montagnards, en régulant la température du sol, "
      "en protégeant certaines espèces végétales et animales, et en constituant une réserve d’eau précieuse.\n\n"
      "La mesure du manteau neigeux, réalisée à l’aide de mâts gradués installés à des emplacements fixes, permet de :\n\n"
      "• Suivre la durée de l’enneigement ;\n"
      "• Identifier la période de fonte.\n\n"
      "Le relevé de ces données complète les informations fournies par les stations météorologiques existantes.";

  static const String tutorial =
      "Se rendre une fois par jour à 8h, d’octobre à mi-mai, sur le site choisi, en cas de présence de neige.\n\n"
      "Relevez la hauteur de neige en cm à l’aide du mât gradué.\n\n"
      "Indiquez les conditions météo lors du relevé : soleil, pluie ou neige.\n\n"
      "Indiquez si des précipitations neigeuses ont eu lieu le jour de votre passage.";

  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();
  final _heightController = TextEditingController();
  final _precipitationController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _locationController.dispose();
    _heightController.dispose();
    _precipitationController.dispose();
    super.dispose();
  }

  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.forestGreen,
              onPrimary: AppColors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.forestGreen,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd.MM.yyyy').format(picked);
      });
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
                                  "Hauteur des Neiges",
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
                                MeasureTextField(label: "Hauteur", controller: _heightController,),
                                _WeatherDropdown(
                                  selected: _weatherCondition,
                                  onChanged: (value) {
                                    if (value == null) return;

                                    setState(() {
                                      _weatherCondition = value;
                                    });
                                  },
                                ),
                                MeasureTextField(label: "Précipitations neigeuses", controller: _precipitationController,),


                                const SizedBox(height: 24),

                                Column(
                                  children: [
                                    MeasureActionButton(
                                      title: "Photo",
                                      onTap: () {
                                        //
                                      },
                                    ),
                                    const SizedBox(height: 12),
                                    MeasureActionButton(
                                      title: isLoading ? "Chargement..." : "Valider",
                                      onTap: isLoading ? null : () {
                                        if (!_formKey.currentState!.validate()) {
                                          return;
                                        }
                                        context.read<MeasureBloc>().add(
                                            CreateSnowHeightRequest(
                                                date: _selectedDate!,
                                                location: _locationController.text.trim(),
                                                height: int.parse(_heightController.text.trim()),
                                                weather: _weatherCondition,
                                                precipitation: int.parse(_precipitationController.text.trim())
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

class _WeatherDropdown extends StatelessWidget {
  final WeatherType selected;
  final ValueChanged<WeatherType?> onChanged;

  const _WeatherDropdown({
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 145,
            child: Text(
              "Conditions météo :",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 40,
              child: DropdownButtonFormField<WeatherType>(
                value: selected,
                isExpanded: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: WeatherType.sunny,
                    child: Text("Soleil"),
                  ),
                  DropdownMenuItem(
                    value: WeatherType.cloudy,
                    child: Text("Nuageux"),
                  ),
                  DropdownMenuItem(
                    value: WeatherType.rainy,
                    child: Text("Pluie"),
                  ),
                  DropdownMenuItem(
                    value: WeatherType.snowy,
                    child: Text("Neige"),
                  ),
                  DropdownMenuItem(
                    value: WeatherType.windy,
                    child: Text("Venteux"),
                  )
                ],
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}