import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';
import '../../../domain/entities/exchange.dart';
import '../../bloc/exchanges_bloc.dart';
import '../../bloc/exchanges_state.dart';
import '../widgets.dart';

class ExchangesList extends StatelessWidget {
  final ExchangesBloc exchangesBloc;
  final ScrollController scrollController;

  const ExchangesList({
    super.key,
    required this.exchangesBloc,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ExchangesBloc, ExchangesState>(
      bloc: exchangesBloc,
      builder: (context, state) {
        if (state is ExchangesLoaded || state is ExchangesLoadingMore) {
          final List<Exchange> exchanges = state is ExchangesLoaded
              ? state.exchanges
              : (state as ExchangesLoadingMore).exchanges;

          final sortedExchanges = _sortExchangesByVolume(exchanges);

          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
            ),
            controller: scrollController,
            padding: EdgeInsets.zero,
            itemCount:
                sortedExchanges.length +
                (state is ExchangesLoaded && state.hasReachedMax ? 0 : 1),
            itemBuilder: (context, index) {
              if (index == sortedExchanges.length) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: const DsLoading(),
                );
              }

              final exchange = sortedExchanges[index];
              final rank = index + 1;

              return ExchangeListItem(exchange: exchange, rank: rank);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  List<Exchange> _sortExchangesByVolume(List<Exchange> exchanges) {
    final sortedExchanges = List<Exchange>.from(exchanges);
    sortedExchanges.sort((a, b) {
      final volumeA = a.spotVolumeUsd ?? 0;
      final volumeB = b.spotVolumeUsd ?? 0;
      return volumeB.compareTo(volumeA);
    });
    return sortedExchanges;
  }
}
