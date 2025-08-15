import 'package:equatable/equatable.dart';

abstract class ExchangesEvent extends Equatable {
  const ExchangesEvent();

  @override
  List<Object?> get props => [];
}

class LoadExchanges extends ExchangesEvent {
  const LoadExchanges();
}

class LoadMoreExchanges extends ExchangesEvent {
  const LoadMoreExchanges();
}

class RefreshExchanges extends ExchangesEvent {
  const RefreshExchanges();
}
