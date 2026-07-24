import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/app_theme.dart';
import 'package:mobile/bloc/measure_bloc.dart';
import 'package:mobile/bloc/measure_event.dart';
import 'package:mobile/bloc/measure_state.dart';
import 'package:mobile/ui/pages/details/bird_migration_details_page.dart';
import 'package:mobile/ui/pages/details/eggs_laying_details_page.dart';
import 'package:mobile/ui/pages/details/snow_height_details_page.dart';
import 'package:mobile/ui/pages/details/temperature_details_page.dart';
import 'package:mobile/ui/widgets/nav_bar.dart';

/// Display a "base" page for all type of measure to display their details.
///
/// It handles the retrieval and the error of those details.
/// If successful, it is redirected to the correct measure type details page.
class MeasureDetailsPage extends StatefulWidget {
  const MeasureDetailsPage({
    super.key,
  });

  @override
  State<MeasureDetailsPage> createState() => _MeasureDetailsPageState();
}

class _MeasureDetailsPageState extends State<MeasureDetailsPage> {
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_loaded) return;
    _loaded = true;

    final id = ModalRoute.of(context)!.settings.arguments as int;

    context.read<MeasureBloc>().add(
      MeasureDetailsRequest(measureId: id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MeasureBloc, MeasureState>(
        listener: (context, state) {
          if (state is MeasureUpdated || state is MeasureDeleted) {
            Navigator.pop(context, true);
          }
          if (state is MeasureUpdateError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is MeasureDeleteError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          bottomNavigationBar: const NavBar(current: NavItem.history),
          body: BlocBuilder<MeasureBloc, MeasureState>(
                    builder: (context, state) {

                      if (state is MeasureDetailsError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Erreur de récupération de la mesure')),
                        );
                      }

                      if (state is TemperatureDetailsFetched) {
                        return TemperatureDetailsPage(measure: state.measure);
                      }

                      if (state is SnowHeightDetailsFetched) {
                        return SnowHeightDetailsPage(measure: state.measure);
                      }

                      if (state is BirdMigrationDetailsFetched) {
                        return BirdMigrationDetailsPage(measure: state.measure);
                      }

                      if (state is EggsLayingDetailsFetched) {
                        return EggsLayingDetailsPage(measure: state.measure);
                      }

                      return const Text('Chargement...');
                    },
                  ),
              )
          );
  }
}