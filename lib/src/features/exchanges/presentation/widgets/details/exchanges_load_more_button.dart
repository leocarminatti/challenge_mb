import 'package:flutter/material.dart';

import '../../bloc/bloc.dart';

class ExchangeLoadMoreButton extends StatelessWidget {
  final ExchangeDetailsBloc bloc;
  final bool hasMoreAssets;

  const ExchangeLoadMoreButton({
    super.key,
    required this.bloc,
    required this.hasMoreAssets,
  });

  @override
  Widget build(BuildContext context) {
    if (!hasMoreAssets) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: () {
          final currentState = bloc.state;
          if (currentState is ExchangeDetailsLoaded) {
            bloc.add(LoadMoreAssets(currentState.exchangeDetails.exchange.id));
          }
        },
        style: FilledButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          'Carregar Mais Assets',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
