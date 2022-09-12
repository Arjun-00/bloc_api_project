import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_api_project/repocitory/repository.dart';
import 'package:equatable/equatable.dart';

import '../model/user_model.dart';

part 'userscreen_event.dart';
part 'userscreen_state.dart';

class UserscreenBloc extends Bloc<UserscreenEvent, UserscreenState> {
  final UserRepository _userRepository;
  UserscreenBloc(this._userRepository) : super(DataLoagingState()) {
    on<UserscreenEvent>((event, emit) async{
      // TODO: implement event handler
      emit(DataLoagingState());

      try{
        final users = await _userRepository.getUser();
        print(users);
        emit(DataLoadedState(users));

      }
      catch(e){
        print(e.toString());
        emit(DataLoagingError(e.toString()));
      }

    });
  }
}
