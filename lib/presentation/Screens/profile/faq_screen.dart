import 'package:amira_app/blocs/profile/expansionPanelExpand/expansion_panel_expand_bloc.dart';
import 'package:amira_app/blocs/profile/faq/faq_bloc.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/presentation/CustomWidgets/animations.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExpansionPanelExpandBloc(),
        ),
        BlocProvider(
          create: (context) => FaqBloc()..add(GetList()),
        ),
      ],
      child: Scaffold(
        appBar: const CustomAppBar(topTitle: 'FAQ'),
        body: BlocBuilder<FaqBloc, FaqState>(
          builder: (context, state) {
            if (state is FaqInitial) {
              return Animations.loading;
            }
            return Container(
              color: AppColors.grey1Color,
              margin: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<FaqBloc, FaqState>(
                    builder: (context, state) {
                      if (state is FaqLoaded) {
                        return ExpansionPanelList.radio(
                          elevation: 0,
                          materialGapSize: 5,
                          expandedHeaderPadding: EdgeInsets.zero,
                          dividerColor: AppColors.grey1Color,
                          expansionCallback: (panelIndex, isExpanded) => context
                              .read<ExpansionPanelExpandBloc>()
                              .add(PressEvent(panelIndex: panelIndex)),
                          children: state.faqList.map(
                            (entry) {
                              return ExpansionPanelRadio(
                                backgroundColor: AppColors.whiteColor,
                                value: entry.question!,
                                headerBuilder: (context, isExpanded) =>
                                    ListTile(
                                  title: Text(
                                    entry.question!,
                                    style: TextStyle(
                                      color: AppColors.purple2Color,
                                      fontWeight: FontWeight.w400,
                                      fontSize: AppFonts.fontSize14,
                                    ),
                                  ),
                                ),
                                body: Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(bottom: 13),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: Text(
                                    entry.answer!,
                                  ),
                                ),
                                canTapOnHeader: true,
                              );
                            },
                          ).toList(),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
