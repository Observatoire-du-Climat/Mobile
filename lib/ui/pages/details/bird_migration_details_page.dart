import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile/bloc/measure_bloc.dart';
import 'package:mobile/bloc/measure_event.dart';
import 'package:mobile/models/bird_migration.dart';
import 'package:mobile/models/enum/bird_event_type.dart';
import 'package:mobile/models/enum/bird_specie.dart';
import 'package:mobile/ui/widgets/measure_input/event_dropdown.dart';
import 'package:mobile/ui/widgets/measure_input/measure_date_field.dart';
import 'package:mobile/ui/widgets/measure_input/measure_text_field.dart';
import 'package:mobile/ui/widgets/measure_input/specie_dropdown.dart';

import '../../../app_theme.dart';
import '../../widgets/measure_action_button.dart';

class BirdMigrationDetailsPage extends StatefulWidget {
  final BirdMigration measure;
  const BirdMigrationDetailsPage({
    super.key,
    required this.measure
  });

  @override
  State<BirdMigrationDetailsPage> createState() => _BirdMigrationDetailsPageState();
}

class _BirdMigrationDetailsPageState extends State<BirdMigrationDetailsPage> {
  BirdSpecie _specie = BirdSpecie.swallow;
  BirdEventType _eventType = BirdEventType.arrival;

  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.measure.date;
    _dateController.text = DateFormat('dd.MM.yyyy').format(widget.measure.date);
    _locationController.text = widget.measure.location;
    _specie = widget.measure.specie;
    _eventType = widget.measure.event;
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
                    Column(
                      children: [
                        MeasureActionButton(
                          title: "Modifier",
                          onTap: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            context.read<MeasureBloc>().add(
                                UpdateBirdMigrationRequest(
                                    measureId: widget.measure.id,
                                    date: _selectedDate!,
                                    location: _locationController.text.trim(),
                                    specie: _specie,
                                    event: _eventType)
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        MeasureActionButton(
                          title: "Supprimer",
                          onTap: () {
                            context.read<MeasureBloc>().add(
                                DeleteMeasureRequest(measureId: widget.measure.id)
                            );
                          },
                        ),
                      ]
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
}