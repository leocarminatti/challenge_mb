import 'package:equatable/equatable.dart';

class ExchangeMap extends Equatable {
  final String id;

  const ExchangeMap({required this.id});

  @override
  List<Object?> get props => [id];
}
