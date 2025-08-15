import 'package:challenge_mb/core/widgets/ds_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
import '../widgets.dart';

class ExchangeAssetsList extends StatelessWidget {
  final ExchangeDetailsBloc bloc;

  const ExchangeAssetsList({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ExchangeDetailsBloc, ExchangeDetailsState>(
      bloc: bloc,
      builder: (context, state) {
        return switch (state) {
          ExchangeDetailsInitial() => const DsLoading(),
          ExchangeDetailsLoading() => const DsLoading(),
          ExchangeDetailsError() => ExchangesShowError(
            message: 'Erro ao carregar os assets',
            onRetry: () {},
          ),
          ExchangeDetailsLoadedWithLoadingAssets() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assets da Exchange',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              const DsLoading(),
              const SizedBox(height: 16),
            ],
          ),
          ExchangeDetailsLoaded() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assets da Exchange (${state.allAssets.length})',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              ExchangeAssetsTable(assets: state.exchangeDetails.assets),
              const SizedBox(height: 16),
              ExchangeLoadMoreButton(
                bloc: bloc,
                hasMoreAssets: state.hasMoreAssets,
              ),
            ],
          ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
