import 'package:equatable/equatable.dart';

import '../../domain/domain.dart';

abstract class ExchangeDetailsState extends Equatable {
  const ExchangeDetailsState();

  @override
  List<Object?> get props => [];
}

class ExchangeDetailsInitial extends ExchangeDetailsState {}

class ExchangeDetailsLoading extends ExchangeDetailsState {}

class ExchangeDetailsLoaded extends ExchangeDetailsState {
  final ExchangeDetailsWithAssets exchangeDetails;
  final List<ExchangeAsset> allAssets;
  final bool hasMoreAssets;
  final int currentPage;
  final int assetsPerPage;

  const ExchangeDetailsLoaded(
    this.exchangeDetails, {
    required this.allAssets,
    required this.hasMoreAssets,
    required this.currentPage,
    required this.assetsPerPage,
  });

  @override
  List<Object?> get props => [
    exchangeDetails,
    allAssets,
    hasMoreAssets,
    currentPage,
    assetsPerPage,
  ];
}

class ExchangeDetailsLoadedWithLoadingAssets extends ExchangeDetailsState {
  final ExchangeDetailsWithAssets exchangeDetails;
  final bool isLoadingAssets;

  const ExchangeDetailsLoadedWithLoadingAssets(
    this.exchangeDetails, {
    this.isLoadingAssets = true,
  });

  @override
  List<Object?> get props => [exchangeDetails, isLoadingAssets];
}

class ExchangeDetailsError extends ExchangeDetailsState {
  final String message;

  const ExchangeDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
