import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/exchange_asset.dart';
import '../../domain/usecases/usecases.dart';
import 'exchange_details_event.dart';
import 'exchange_details_state.dart';

class ExchangeDetailsBloc
    extends Bloc<ExchangeDetailsEvent, ExchangeDetailsState> {
  final GetExchangeAssetsUseCase _getExchangeAssetsUseCase;

  ExchangeDetailsBloc(this._getExchangeAssetsUseCase)
    : super(ExchangeDetailsInitial()) {
    on<LoadExchangeDetails>(_onLoadExchangeDetails);
    on<_AppendAssets>(_onAppendAssets);
    on<LoadMoreAssets>(_onLoadMoreAssets);
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

    unawaited(_loadAndChunkAssets(event.exchange.id));
  }

  Future<void> _loadAndChunkAssets(String exchangeId) async {
    final assetsResult = await _getExchangeAssetsUseCase(exchangeId);

    assetsResult.fold(
      (failure) => add(const _AppendAssets([], isError: true)),
      (allAssets) async {
        if (allAssets.isEmpty) {
          add(const _AppendAssets([], total: 0));
          return;
        }

        const chunkSize = 200;
        for (var i = 0; i < allAssets.length; i += chunkSize) {
          final end = (i + chunkSize < allAssets.length)
              ? i + chunkSize
              : allAssets.length;
          final slice = allAssets.sublist(i, end);
          add(_AppendAssets(slice, total: allAssets.length));
          await Future.delayed(Duration.zero);
        }
      },
    );
  }

  Future<void> _onAppendAssets(
    _AppendAssets event,
    Emitter<ExchangeDetailsState> emit,
  ) async {
    final current = state;

    if (event.isError) {
      emit(ExchangeDetailsError('Erro ao carregar os assets'));
      return;
    }

    if (current is ExchangeDetailsLoadedWithLoadingAssets) {
      final combined = [...current.exchangeDetails.assets, ...event.assets];
      final updated = current.exchangeDetails.copyWith(assets: combined);

      final show = combined.take(20).toList();
      emit(
        ExchangeDetailsLoaded(
          updated.copyWith(assets: show),
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

class _AppendAssets extends ExchangeDetailsEvent {
  final List<ExchangeAsset> assets;
  final int? total;
  final bool isError;

  const _AppendAssets(this.assets, {this.total, this.isError = false});
}
