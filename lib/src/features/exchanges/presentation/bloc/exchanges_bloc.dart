import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_exchanges_by_ids_usecase.dart';
import 'exchanges_event.dart';
import 'exchanges_state.dart';

class ExchangesBloc extends Bloc<ExchangesEvent, ExchangesState> {
  final GetExchangesByIdsUseCase _getExchangesWithDetailsUseCase;

  static const int _itemsPerPage = 15;

  bool _isLoadingMore = false;

  ExchangesBloc(this._getExchangesWithDetailsUseCase)
    : super(ExchangesInitial()) {
    on<LoadExchanges>(_onLoadExchanges);
    on<LoadMoreExchanges>(_onLoadMoreExchanges);
    on<RefreshExchanges>(_onRefreshExchanges);
  }

  Future<void> _onLoadExchanges(
    LoadExchanges event,
    Emitter<ExchangesState> emit,
  ) async {
    emit(ExchangesLoading());

    final result = await _getExchangesWithDetailsUseCase(
      start: 1,
      limit: _itemsPerPage,
    );

    result.fold((failure) => emit(ExchangesError(failure.message)), (
      exchanges,
    ) {
      final hasReachedMax = exchanges.length < _itemsPerPage;
      emit(
        ExchangesLoaded(
          exchanges: exchanges,
          hasReachedMax: hasReachedMax,
          currentPage: 1,
        ),
      );
    });
  }

  Future<void> _onLoadMoreExchanges(
    LoadMoreExchanges event,
    Emitter<ExchangesState> emit,
  ) async {
    if (state is ExchangesLoaded && !_isLoadingMore) {
      final currentState = state as ExchangesLoaded;

      if (currentState.hasReachedMax) return;

      _isLoadingMore = true;

      emit(
        ExchangesLoadingMore(
          exchanges: currentState.exchanges,
          currentPage: currentState.currentPage,
        ),
      );

      final nextPage = currentState.currentPage + 1;
      final start = (nextPage - 1) * _itemsPerPage + 1;

      final result = await _getExchangesWithDetailsUseCase(
        start: start,
        limit: _itemsPerPage,
      );

      result.fold((failure) => emit(ExchangesError(failure.message)), (
        newExchanges,
      ) {
        if (newExchanges.isEmpty) {
          emit(currentState.copyWith(hasReachedMax: true));
        } else {
          final allExchanges = [...currentState.exchanges, ...newExchanges];
          final hasReachedMax = newExchanges.length < _itemsPerPage;

          emit(
            ExchangesLoaded(
              exchanges: allExchanges,
              hasReachedMax: hasReachedMax,
              currentPage: nextPage,
            ),
          );
        }
      });

      _isLoadingMore = false;
    }
  }

  Future<void> _onRefreshExchanges(
    RefreshExchanges event,
    Emitter<ExchangesState> emit,
  ) async {
    final result = await _getExchangesWithDetailsUseCase(
      start: 1,
      limit: _itemsPerPage,
    );

    result.fold((failure) => emit(ExchangesError(failure.message)), (
      exchanges,
    ) {
      final hasReachedMax = exchanges.length < _itemsPerPage;
      emit(
        ExchangesLoaded(
          exchanges: exchanges,
          hasReachedMax: hasReachedMax,
          currentPage: 1,
        ),
      );
    });
  }
}
