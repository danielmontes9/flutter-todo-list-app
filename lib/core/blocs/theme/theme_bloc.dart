import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/theme/theme_event.dart';
import 'package:flutter_todo_list_app/core/blocs/theme/theme_state.dart';
import 'package:flutter_todo_list_app/core/helpers/database_config_helper.dart';
import 'package:flutter_todo_list_app/core/theme/theme.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: AppTheme.lightTheme)) {
    on<ToggleThemeEvent>((event, emit) async {
      final newTheme =
          state.themeData == AppTheme.lightTheme
              ? AppTheme.darkTheme
              : AppTheme.lightTheme;

      final Map<String, dynamic>? config =
          await DatabaseConfigHelper().getConfig();

      if (config == null) {
        await DatabaseConfigHelper().insertConfig(
          newTheme == AppTheme.lightTheme ? 'light' : 'dark',
          'en',
        );
      } else {
        await DatabaseConfigHelper().updateConfig(
          newTheme == AppTheme.lightTheme ? 'light' : 'dark',
          'en',
        );
      }

      emit(ThemeState(themeData: newTheme));
    });
  }
}
