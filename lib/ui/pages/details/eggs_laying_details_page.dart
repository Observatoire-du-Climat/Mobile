import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile/bloc/measure_bloc.dart';
import 'package:mobile/bloc/measure_event.dart';
import 'package:mobile/models/eggs_laying.dart';
import 'package:mobile/ui/widgets/measure_input/measure_date_field.dart';
import 'package:mobile/ui/widgets/measure_input/measure_text_field.dart';

import '../../../app_theme.dart';
import '../../../utils/date_picker_helper.dart';
import '../../widgets/measure_action_button.dart';
import '../../widgets/measure_picture.dart';

/// Display the eggs laying measure details page.
///
/// It contains all the value of a eggs laying measure and the possibility to update or delete it.
class EggsLayingDetailsPage extends StatefulWidget {
  final EggsLaying measure;

  const EggsLayingDetailsPage({
    super.key,
    required this.measure
  });

  @override
  State<EggsLayingDetailsPage> createState() => _EggsLayingPageDetailsState();

}

class _EggsLayingPageDetailsState extends State<EggsLayingDetailsPage> {

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

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.measure.date;
    _dateController.text = DateFormat('dd.MM.yyyy').format(widget.measure.date);
    _locationController.text = widget.measure.location;
    _numberController.text = widget.measure.number.toString();
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
                    MeasureTextField(label: "Nombre de pontes", controller: _numberController, keyboardType: TextInputType.number, titleWidth: 130,),

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
                                UpdateEggsLayingRequest(
                                    measureId: widget.measure.id,
                                    date: _selectedDate!,
                                    location: _locationController.text.trim(),
                                    number: int.parse(_numberController.text)
                                )
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
                )
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}