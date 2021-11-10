import 'dart:async';
import 'package:async/async.dart';

class DataDelegate<T> {
  final Future<T> Function(dynamic request) getFromRemote;
  final Future Function(T) putToCache;
  final _subscriptions = <StreamSubscription<Result<T>>>[];
  late StreamController<Result<T>> _delegateController;
  CancelableOperation<dynamic>? _cancelableOperation;
  T? _cache;

  DataDelegate({
    required this.putToCache,
    required this.getFromRemote,
  }) {
    _delegateController = StreamController.broadcast();
    _delegateController.onCancel = () {
      if (_subscriptions.isEmpty) return null;
      final cancels = [for (final s in _subscriptions) s.cancel()];
      return Future.wait(cancels).then((_) {});
    };
  }

  Stream<Result<T>> observe(String request, bool force) {
    final forwardController = StreamController<Result<T>>();

    forwardController.onListen = () {
      forwardController.add(Result.loading(_cache));

      final subscription = _delegateController.stream.listen(
        (result) {
          forwardController.add(result);
        },
      );

      subscription.onDone(() {
        _subscriptions.remove(subscription);
        forwardController.close();
      });

      _subscriptions.add(subscription);

      onError(Object error) {
        forwardController.add(Result.error(error));
      }

      if (force || _cache == null) {
        _cancelableOperation = CancelableOperation.fromFuture(getFromRemote(request).then((remote) {
          if (_cache != remote) {
            return putToCache(remote).then((_) {
              _cache = remote;
              _delegateController.add(Result.loaded(_cache));
            });
          } else {
            forwardController.add(Result.loaded(_cache));
          }
        }).catchError(onError));
      } else {
        forwardController.add(Result.loaded(_cache));
      }
    };

    return forwardController.stream;
  }

  void close() async {
    _cancelableOperation?.cancel();
    _delegateController.close();
    await Future.wait<void>(_subscriptions.map((s) => s.cancel()));
    _subscriptions.clear();
  }
}

class Result<T> {
  factory Result.loaded(T? data) => Result._(data: data, loading: false);

  factory Result.loading(T? data) => Result._(data: data, loading: true);

  factory Result.error(Object error) => Result._(error: error);

  bool isSuccess() => data != null;

  bool isError() => error != null;

  bool isLoading() => loading;

  final T? data;
  final Object? error;
  final bool loading;

  Result._({this.data, this.error, this.loading = false});

  @override
  String toString() {
    if (isSuccess()) {
      return 'Success: $data';
    } else if (isError()) {
      return 'Error: $error';
    } else {
      return 'Loading';
    }
  }
}

class UserRepositoryImpl extends Repository<String, User> {
  final RemoteUserDataSource remote;
  final LocalUserDataSource local;
  late DataDelegate<User> _dataDelegate;

  UserRepositoryImpl({required this.remote, required this.local}) {
    _dataDelegate = DataDelegate(
      putToCache: (user) => _dataDelegate.putToCache(user),
      getFromRemote: (email) => _dataDelegate.getFromRemote(email),
    );
  }

  @override
  Stream<Result<User>> get(String request, bool force) {
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
}

class UserRequest {
  final String email;

  UserRequest({required this.email});
}

class RemoteUserDataSource extends DataSource<UserRequest, User> {
  final List<User> _remoteUsers = [
    User(email: "a1@r.com", name: "user1"),
    User(email: "a2@r.com", name: "user2"),
    User(email: "a3@r.com", name: "user3"),
    User(email: "a4@r.com", name: "user4"),
    User(email: "a5@r.com", name: "user5"),
  ];

  @override
  Future<User> getData(UserRequest request) {
    return Future.value(_remoteUsers.firstWhere((element) => element.email == request.email));
  }
}

class LocalUserDataSource extends DataStorage<UserRequest, User> {
  final List<User> _cache = [];

  @override
  Future<User> getData(UserRequest request) {
    return Future.value(_cache.firstWhere((element) => element.email == request.email));
  }

  @override
  Future putData(User data) {
    return Future(() {
      _cache.add(data);
    });
  }
}

abstract class DataSource<R, T> {
  Future<T> getData(R request);
}

abstract class DataStorage<R, T> implements DataSource<R, T> {
  Future putData(T data);
}
