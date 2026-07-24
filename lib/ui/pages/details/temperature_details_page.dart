import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile/bloc/measure_bloc.dart';
import 'package:mobile/bloc/measure_event.dart';
import 'package:mobile/models/temperature.dart';
import 'package:mobile/ui/widgets/measure_input/measure_date_field.dart';
import 'package:mobile/ui/widgets/measure_picture.dart';

import '../../../app_theme.dart';
import '../../../utils/date_picker_helper.dart';
import '../../widgets/measure_action_button.dart';
import '../../widgets/measure_input/measure_text_field.dart';

/// Display the temperature measure details page.
///
/// It contains all the value of a temperature measure and the possibility to update or delete it.
class TemperatureDetailsPage extends StatefulWidget {
  final Temperature measure;
  const TemperatureDetailsPage({
    super.key,
    required this.measure
  });

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
  void initState() {
    super.initState();
    _selectedDate = widget.measure.date;
    _dateController.text = DateFormat('dd.MM.yyyy').format(widget.measure.date);
    _locationController.text = widget.measure.location;
    _degreeController.text = widget.measure.degree.toString();
  }

  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    final picked = await DatePickerHelper.pickDate(context, initialDate: _selectedDate);
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
                    MeasureTextField(label: "Degré", controller: _degreeController, keyboardType: TextInputType.number,),

                    const SizedBox(height: 24),

                    MeasurePicture(measureId: widget.measure.id),

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
                              UpdateTemperatureRequest(
                                  measureId: widget.measure.id,
                                  date: _selectedDate!,
                                  location: _locationController.text,
                                  degree: int.parse(_degreeController.text))
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        MeasureActionButton(
                          title: "Supprimer",
                          borderColor: Colors.red,
                          onTap: () {
                            context.read<MeasureBloc>().add(
                                DeleteMeasureRequest(measureId: widget.measure.id)
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
}