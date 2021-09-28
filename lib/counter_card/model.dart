import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class CounterCardModel extends Equatable {

  final String title;
  final int counter;

  const CounterCardModel({required this.title, required this.counter});

  CounterCardModel copyWith({
    String? title,
    int? counter,
  }) {
    return CounterCardModel(
      title: title ?? this.title,
      counter: counter ?? this.counter,
    );
  }

  @override
  List<Object> get props => [title, counter];
}
