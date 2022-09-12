part of 'userscreen_bloc.dart';

abstract class UserscreenState extends Equatable {
  const UserscreenState();
}

class DataLoagingState extends UserscreenState {
  @override
  List<Object?> get props => [];
}

class DataLoadedState extends UserscreenState {
  final List<UserModel> useres;
  DataLoadedState(this.useres);

  @override
  List<Object?> get props => [useres];
}

class DataLoagingError extends UserscreenState {
  final String error;
  DataLoagingError(this.error);

  @override
  List<Object?> get props => [error];
}