import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile/bloc/measure_bloc.dart';
import 'package:mobile/bloc/measure_event.dart';
import 'package:mobile/bloc/measure_state.dart';
import 'package:mobile/ui/widgets/measure_input/measure_date_field.dart';

import '../../../app_theme.dart';
import '../../widgets/nav_bar.dart';
import '../../widgets/measure_action_button.dart';
import '../../widgets/measure_input/measure_text_field.dart';

class TemperatureDetailsPage extends StatefulWidget {
  const TemperatureDetailsPage({super.key});

  @override
  State<TemperatureDetailsPage> createState() => _TemperatureDetailsPageState();

}

class _TemperatureDetailsPageState extends State<TemperatureDetailsPage> {

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final id = ModalRoute.of(context)!.settings.arguments as int;

    context.read<MeasureBloc>().add(MeasureDetailsRequest(measureId: id));
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
        if (state is TemperatureDetailsFetched) {
          final measure = state.measure;
          _selectedDate = measure.date;
          _dateController.text = DateFormat('dd.MM.yyyy').format(measure.date);
          _locationController.text = measure.location;
          _degreeController.text = measure.degree.toString();
        }

        if (state is MeasureUpdateError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is MeasureDeleteError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is MeasureUpdated || state is MeasureDeleted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
          backgroundColor: AppColors.white,
          bottomNavigationBar: const NavBar(current: NavItem.history),
          body: BlocBuilder<MeasureBloc, MeasureState>(
              builder: (context, state) {
                final isLoading = state is MeasureUpdateLoading || state is MeasureDeleteLoading;

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

                        if (state is MeasureDetailsError) Text(state.message),

                        if (state is TemperatureDetailsFetched)
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

                                  MeasureDateField(label: "Date", controller: _dateController, onTap: _pickDate,),
                                  MeasureTextField(label: "Lieu", controller: _locationController,),
                                  MeasureTextField(label: "Degré", controller: _degreeController,),

                                  const SizedBox(height: 24),

                                  Column(
                                    children: [
                                      MeasureActionButton(
                                        title: "Modifier",
                                        onTap: isLoading ? null : () {
                                          if (!_formKey.currentState!.validate()) {
                                            return;
                                          }
                                          context.read<MeasureBloc>().add(
                                            UpdateTemperatureRequest(
                                                measureId: state.measure.id,
                                                date: _selectedDate!,
                                                location: _locationController.text,
                                                degree: int.parse(_degreeController.text))
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 12),
                                      MeasureActionButton(
                                        title: "Supprimer",
                                        onTap: isLoading ? null : () {
                                          context.read<MeasureBloc>().add(
                                              DeleteMeasureRequest(measureId: state.measure.id)
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