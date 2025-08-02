part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final ThemeMode mode;
  final Color seedColor;
  final AppStatus status;

  const ThemeState({this.mode = ThemeMode.system, this.seedColor = Colors.deepPurple, this.status = const Initial()});

  @override
  List<Object?> get props => [mode, status, seedColor];

  ThemeState copyWith({ThemeMode? mode, AppStatus? status, Color? seedColor}) {
    return ThemeState(mode: mode ?? this.mode, status: status ?? this.status, seedColor: seedColor ?? this.seedColor);
  }
}
