import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/theme/theme_event.dart';
import 'package:flutter_todo_list_app/core/blocs/theme/theme_state.dart';
import 'package:flutter_todo_list_app/core/theme/theme.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: AppTheme.lightTheme)) {
    on<ToggleThemeEvent>((event, emit) {
      final newTheme =
          state.themeData == AppTheme.lightTheme
              ? AppTheme.darkTheme
              : AppTheme.lightTheme;
      emit(ThemeState(themeData: newTheme));
    });
  }
}
