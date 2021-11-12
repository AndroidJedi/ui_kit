import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/data_delegate/repository.dart';

class UserCubit extends Cubit<UserState> {
  final Repository<UserRequest, User> repository;
  StreamSubscription? _subscription;

  UserCubit(this.repository, UserState initialState) : super(initialState);

  void getUser({required UserRequest request, required bool force}) {
    _subscription = repository.get(request, force).listen((result) {
      if (result.isLoading()) {
        emit(Loading());
      } else if (result.isSuccess()) {
        emit(UserFetched(result.data!));
      } else {
        emit(Error(result.error));
      }
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

abstract class UserState {}

class Initial extends UserState {}

class Loading extends UserState {
  @override
  String toString() => 'Loading';
}

class Error extends UserState {
  final dynamic error;

  Error(this.error);

  @override
  String toString() => 'Error: $error';
}

class UserFetched extends UserState {
  final User user;

  UserFetched(this.user);

  @override
  String toString() => 'UserFetched: ${user.email}';
}
