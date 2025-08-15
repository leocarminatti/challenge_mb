import 'package:equatable/equatable.dart';

import '../../domain/entities/exchange.dart';

abstract class ExchangeDetailsEvent extends Equatable {
  const ExchangeDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadExchangeDetails extends ExchangeDetailsEvent {
  final Exchange exchange;

  const LoadExchangeDetails(this.exchange);

  @override
  List<Object?> get props => [exchange];
}

class LoadMoreAssets extends ExchangeDetailsEvent {
  final String exchangeId;

  const LoadMoreAssets(this.exchangeId);

  @override
  List<Object?> get props => [exchangeId];
}
