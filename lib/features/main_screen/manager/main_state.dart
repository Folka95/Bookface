part of 'main_cubit.dart';

@immutable
sealed class MainState {
  final int index;
  final AppPage page;

  MainState({required this.index, required this.page});
}

final class MainInitial extends MainState {
  MainInitial({required super.index, required super.page});
}

final class MainLoaded extends MainState {
  MainLoaded({required super.index, required super.page});
}
