import 'package:equatable/equatable.dart';

import '../../domain/entities/exchange.dart';

abstract class ExchangesState extends Equatable {
  const ExchangesState();

  @override
  List<Object?> get props => [];
}

class ExchangesInitial extends ExchangesState {}

class ExchangesLoading extends ExchangesState {}

class ExchangesLoadingMore extends ExchangesLoaded {
  const ExchangesLoadingMore({
    required super.exchanges,
    required super.currentPage,
  }) : super(hasReachedMax: false);

  @override
  List<Object?> get props => [exchanges, currentPage];
}

class ExchangesLoaded extends ExchangesState {
  final List<Exchange> exchanges;
  final bool hasReachedMax;
  final int currentPage;

  const ExchangesLoaded({
    required this.exchanges,
    this.hasReachedMax = false,
    this.currentPage = 1,
  });

  ExchangesLoaded copyWith({
    List<Exchange>? exchanges,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return ExchangesLoaded(
      exchanges: exchanges ?? this.exchanges,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [exchanges, hasReachedMax, currentPage];
}

class ExchangesError extends ExchangesState {
  final String message;

  const ExchangesError(this.message);

  @override
  List<Object?> get props => [message];
}
