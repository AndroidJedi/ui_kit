import 'dart:math';
import 'data_delegate.dart';

class UserRepositoryImpl extends Repository<UserRequest, User> {
  final RemoteUserDataSource remoteSource;
  final LocalUserDataSource localSource;
  late DataDelegate<User> _dataDelegate;

  UserRepositoryImpl({required this.remoteSource, required this.localSource}) {
    _dataDelegate = DataDelegate(
      putToCache: (user) => localSource.putData(user),
      getFromCache: (email) => localSource.getData(email),
      getFromRemote: (email) => remoteSource.getData(email),
    );
  }

  @override
  Stream<Result<User>> get(UserRequest request, bool force) {
    return _dataDelegate.observe(request, force);
  }
}

abstract class Repository<R, T> {
  Stream<Result<T>> get(R request, bool force);
}

class User {
  final String email;
  final String name;

  User({required this.email, required this.name});

  @override
  String toString() => "User. email: $email";

  @override
  int get hashCode => email.hashCode;

  @override
  bool operator ==(other) {
    if (other is! User) {
      return false;
    }
    return email == other.email;
  }
}

class UserRequest {
  final String email;

  UserRequest({required this.email});
}

class RemoteUserDataSource extends DataSource<UserRequest, User> {
  final Random _random = Random();

  @override
  Future<User> getData(UserRequest request) {
    return Future.value(remoteUsers[_random.nextInt(remoteUsers.length - 1)]);
  }
}

class LocalUserDataSource extends DataStorage<UserRequest, User> {
  final List<User> _cache = [];

  @override
  Future<User?> getData(UserRequest request) {
    User? user;
    try {
      user = _cache.firstWhere((element) => element.email == request.email);
    } catch (e) {
      user = null;
    }

    return Future.value(user);
  }

  @override
  Future putData(User data) {
    return Future(() {
      _cache.add(data);
    });
  }
}

abstract class DataSource<R, T> {
  Future<T?> getData(R request);
}

abstract class DataStorage<R, T> implements DataSource<R, T> {
  Future putData(T data);
}

final List<User> remoteUsers = [
  User(email: "a1@r.com", name: "user1"),
  User(email: "a2@r.com", name: "user2"),
  User(email: "a3@r.com", name: "user3"),
  User(email: "a4@r.com", name: "user4"),
  User(email: "a5@r.com", name: "user5"),
];
