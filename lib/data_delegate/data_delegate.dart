import 'dart:async';
import 'package:async/async.dart';

class DataDelegate<T> {
  final Future<T?> Function() getFromCache;
  final Future<T?> Function() getFromRemote;
  final Future<T?> Function(T?) putToCache;
  final _subscriptions = <StreamSubscription<Result<T?>>>[];
  late StreamController<Result<T?>> _delegateController;
  CancelableOperation<dynamic>? _cancelableOperation;

  DataDelegate({
    required this.getFromCache,
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

  Stream<Result<T?>> observe(bool force) {
    final forwardController = StreamController<Result<T?>>.broadcast();

    forwardController.onListen = () {
      forwardController.add(Result.loading());

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

      if (force) {
        _cancelableOperation =
            CancelableOperation.fromFuture(Future.wait([getFromCache(), getFromRemote()]).then((resultArray) {
          T? cached = resultArray[0];
          T? remote = resultArray[1];

          if (cached != remote) {
            return Future.wait([putToCache(remote), Future.value(true)]);
          } else {
            return Future.wait([Future.value(cached), Future.value(false)]);
          }
        }).then((resultArray) {
          T? cached = resultArray[0] as T?;
          bool updated = resultArray[1] as bool;
          if (updated) {
            _delegateController.add(Result.success(cached));
          } else {
            forwardController.add(Result.success(cached));
          }
        }).catchError(onError));
      } else {
        _cancelableOperation = CancelableOperation.fromFuture(
            getFromCache().then((data) => forwardController.add(Result.success(data))).catchError(onError));
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
  factory Result.success(T? data) => Result._(data: data);

  factory Result.error(Object error) => Result._(error: error);

  factory Result.loading() => Result._();

  bool isSuccess() => data != null;

  bool isError() => error != null;

  bool isLoading() => data == null && error == null;

  final T? data;
  final Object? error;

  Result._({this.data, this.error});

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
