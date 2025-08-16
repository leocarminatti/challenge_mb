import 'package:equatable/equatable.dart';

import '../../domain/entities/exchange.dart';
import '../../domain/entities/exchange_asset.dart';

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

class AppendAssets extends ExchangeDetailsEvent {
  final List<ExchangeAsset> assets;

  const AppendAssets(this.assets);
}

class AppendFailure extends ExchangeDetailsEvent {
  final String message;

  const AppendFailure(this.message);

  @override
  List<Object?> get props => [message];
}
