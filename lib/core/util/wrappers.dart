import 'package:equatable/equatable.dart';

class NullableWrapped<T> extends Equatable {
  final T value;
  const NullableWrapped.value(this.value);

  @override
  List<Object?> get props => [value];
}
