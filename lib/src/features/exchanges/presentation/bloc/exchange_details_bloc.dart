import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../domain/entities/exchange_asset.dart';
import '../../domain/usecases/usecases.dart';
import 'exchange_details_event.dart';
import 'exchange_details_state.dart';

class ExchangeDetailsBloc
    extends Bloc<ExchangeDetailsEvent, ExchangeDetailsState> {
  final GetExchangeAssetsStreamUseCase _getExchangeAssetsStreamUseCase;

  ExchangeDetailsBloc(this._getExchangeAssetsStreamUseCase)
    : super(ExchangeDetailsInitial()) {
    on<LoadExchangeDetails>(_onLoadExchangeDetails, transformer: restartable());
    on<LoadMoreAssets>(_onLoadMoreAssets, transformer: droppable());
    on<AppendAssets>(_onAppendAssets);
    on<AppendFailure>((e, emit) => emit(ExchangeDetailsError(e.message)));
  }

  Future<void> _onLoadExchangeDetails(
    LoadExchangeDetails event,
    Emitter<ExchangeDetailsState> emit,
  ) async {
    final base = ExchangeDetailsWithAssets(
      exchange: event.exchange,
      assets: [],
    );
    emit(ExchangeDetailsLoadedWithLoadingAssets(base));

    final stream = _getExchangeAssetsStreamUseCase(
      event.exchange.id,
      chunkSize: 200,
    );

    await emit.forEach<Either<Failure, List<ExchangeAsset>>>(
      stream,
      onData: (either) {
        either.fold(
          (failure) => add(AppendFailure(failure.message)),
          (chunk) => add(AppendAssets(chunk)),
        );
        return state;
      },
      onError: (_, __) {
        add(const AppendFailure('Erro desconhecido ao carregar assets'));
        return state;
      },
    );
  }

  Future<void> _onAppendAssets(
    AppendAssets event,
    Emitter<ExchangeDetailsState> emit,
  ) async {
    final current = state;

    if (current is ExchangeDetailsLoadedWithLoadingAssets) {
      final combined = [...current.exchangeDetails.assets, ...event.assets];
      final visible = combined.take(20).toList();

      emit(
        ExchangeDetailsLoaded(
          current.exchangeDetails.copyWith(assets: visible),
          allAssets: combined,
          hasMoreAssets: combined.length > 20,
          currentPage: 1,
          assetsPerPage: 20,
        ),
      );
      return;
    }

    if (current is ExchangeDetailsLoaded) {
      final combinedAll = [...current.allAssets, ...event.assets];
      final hasMore =
          combinedAll.length > current.currentPage * current.assetsPerPage;
      emit(
        ExchangeDetailsLoaded(
          current.exchangeDetails,
          allAssets: combinedAll,
          hasMoreAssets: hasMore,
          currentPage: current.currentPage,
          assetsPerPage: current.assetsPerPage,
        ),
      );
    }
  }

  Future<void> _onLoadMoreAssets(
    LoadMoreAssets event,
    Emitter<ExchangeDetailsState> emit,
  ) async {
    final current = state;
    if (current is! ExchangeDetailsLoaded) return;

    final nextPage = current.currentPage + 1;
    final start = (nextPage - 1) * current.assetsPerPage;

    if (start >= current.allAssets.length) {
      emit(
        ExchangeDetailsLoaded(
          current.exchangeDetails,
          allAssets: current.allAssets,
          hasMoreAssets: false,
          currentPage: current.currentPage,
          assetsPerPage: current.assetsPerPage,
        ),
      );
      return;
    }

    final endExclusive = (start + current.assetsPerPage).clamp(
      0,
      current.allAssets.length,
    );
    final newSlice = current.allAssets.sublist(start, endExclusive);

    final combinedVisible = [...current.exchangeDetails.assets, ...newSlice];
    final hasMore = combinedVisible.length < current.allAssets.length;

    emit(
      ExchangeDetailsLoaded(
        current.exchangeDetails.copyWith(assets: combinedVisible),
        allAssets: current.allAssets,
        hasMoreAssets: hasMore,
        currentPage: nextPage,
        assetsPerPage: current.assetsPerPage,
      ),
    );
  }
}
