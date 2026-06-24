import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/measure_bloc.dart';
import 'package:mobile/bloc/measure_event.dart';
import 'package:mobile/bloc/measure_state.dart';
import 'package:mobile/ui/pages/history_card/history_card.dart';

import '../../app_theme.dart';
import '../widgets/nav_bar.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  @override
  void initState() {
    super.initState();
    //load the measures
    context.read<MeasureBloc>().add(UserMeasureRequest());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MeasureBloc, MeasureState>(
      listener: (context, state) {},
      child: Scaffold(
        backgroundColor: AppColors.white,
        bottomNavigationBar: const NavBar(current: NavItem.history),
        body: BlocBuilder<MeasureBloc, MeasureState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Positioned.fill(
                    top: 150,
                    child: Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        'assets/images/fond_version_clean.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Image.asset(
                          'assets/images/logo-vert.png',
                          height: 70,
                        ),
                        const SizedBox(height: 28),
                        Text(
                          "Historique des mesures",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: 170,
                          height: 2,
                          color: AppColors.forestGreen,
                        ),
                        const SizedBox(height: 28),
                        if (state is MeasuresLoading) const Text("Chargement..."),
                        if (state is MeasuresFetchedEmpty) const Text("Aucune mesure"),
                        if (state is MeasuresFetched)
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            itemCount: state.measures.length,
                            separatorBuilder: (_, _) => const SizedBox(height: 15),
                            itemBuilder: (context, index) {
                              return HistoryCard(item: state.measures[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
        )
      ),
    );
  }
}