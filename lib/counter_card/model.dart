import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class InnerCardModel extends Equatable {

  final String title;
  final int counter;

  const InnerCardModel({required this.title, required this.counter});

  InnerCardModel copyWith({
    String? title,
    int? counter,
  }) {
    return InnerCardModel(
      title: title ?? this.title,
      counter: counter ?? this.counter,
    );
  }

  @override
  List<Object> get props => [title, counter];
}
