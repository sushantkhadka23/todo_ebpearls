import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_ebpearls/core/status/app_status.dart';
import 'package:todo_ebpearls/domain/repositories/theme_repository.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeRepository repository;

  ThemeBloc({required this.repository}) : super(const ThemeState()) {
    on<LoadTheme>(_onLoadTheme);
    on<UpdateTheme>(_onUpdateTheme);
    on<UpdateSeedColor>(_onUpdateSeedColor);
  }
  _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(status: const InProgress()));
    final themeMode = await repository.getTheme();
    final seedColor = await repository.getSeedColor();
    emit(state.copyWith(mode: themeMode, seedColor: seedColor, status: const Success()));
  }

  _onUpdateTheme(UpdateTheme event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(status: const InProgress()));
    await repository.setTheme(event.mode);
    emit(state.copyWith(mode: event.mode, status: const Success()));
  }

  _onUpdateSeedColor(UpdateSeedColor event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(status: const InProgress()));
    await repository.setSeedColor(event.seedColor);
    emit(state.copyWith(seedColor: event.seedColor, status: const Success()));
  }
}
