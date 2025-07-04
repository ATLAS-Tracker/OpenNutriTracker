import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opennutritracker/core/utils/locator.dart';
import 'package:opennutritracker/features/diary/presentation/bloc/calendar_day_bloc.dart';
import 'package:opennutritracker/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:opennutritracker/features/home/presentation/bloc/home_bloc.dart';
import 'package:opennutritracker/features/settings/presentation/bloc/export_import_bloc.dart';
import 'package:opennutritracker/generated/l10n.dart';

class ExportSupabaseDialog extends StatelessWidget {
  final exportImportBloc = locator<ExportImportBloc>();

  final _homeBloc = locator<HomeBloc>();
  final _diaryBloc = locator<DiaryBloc>();
  final _calendarDayBloc = locator<CalendarDayBloc>();

  ExportSupabaseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExportImportBloc, ExportImportState>(
      bloc: exportImportBloc,
      listener: (context, state) {
        if (state is ExportImportSuccess) {
          refreshScreens();
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: Text(
            S.of(context).exportSupabaseLabel,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          content: _buildContent(context, state),
          actions: _buildActions(context, state),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, ExportImportState state) {
    if (state is ExportImportInitial) {
      return Text(
        S.of(context).exportSupabaseDescription,
        overflow: TextOverflow.ellipsis,
        maxLines: 15,
      );
    } else if (state is ExportImportLoadingState) {
      return const LinearProgressIndicator();
    } else if (state is ExportImportError) {
      return Row(
        children: [
          Icon(Icons.error, color: Theme.of(context).colorScheme.error),
          const SizedBox(width: 8),
          Text(S.of(context).exportImportErrorLabel),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  List<Widget> _buildActions(BuildContext context, ExportImportState state) {
    return [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(S.of(context).dialogCancelLabel),
      ),
      TextButton(
        onPressed: state is ExportImportLoadingState
            ? null
            : () {
                exportImportBloc.add(ExportDataSupabaseEvent());
              },
        child: Text(S.of(context).exportAction),
      ),
    ];
  }

  void refreshScreens() {
    _homeBloc.add(const LoadItemsEvent());
    _diaryBloc.add(const LoadDiaryYearEvent());
    _calendarDayBloc.add(RefreshCalendarDayEvent());
  }
}
