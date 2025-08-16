import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
import '../widgets.dart';

class ExchangeAssetsList extends StatelessWidget {
  final ExchangeDetailsBloc bloc;

  const ExchangeAssetsList({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExchangeDetailsBloc, ExchangeDetailsState>(
      bloc: bloc,
      buildWhen: (prev, curr) =>
          prev.runtimeType != curr.runtimeType ||
          (prev is ExchangeDetailsLoaded &&
              curr is ExchangeDetailsLoaded &&
              (prev.exchangeDetails.assets.length !=
                      curr.exchangeDetails.assets.length ||
                  prev.hasMoreAssets != curr.hasMoreAssets)),
      builder: (context, state) {
        if (state is ExchangeDetailsInitial ||
            state is ExchangeDetailsLoading) {
          return const SliverToBoxAdapter(
            child: SizedBox(
              height: 56,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (state is ExchangeDetailsError) {
          return SliverToBoxAdapter(
            child: ExchangesShowError(
              message: 'Erro ao carregar os assets',
              onRetry: () {},
            ),
          );
        }

        if (state is ExchangeDetailsLoadedWithLoadingAssets) {
          return const SliverToBoxAdapter(
            child: SizedBox(
              height: 56,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (state is ExchangeDetailsLoaded) {
          final assets = state.exchangeDetails.assets;

          return SliverList(
            delegate: SliverChildBuilderDelegate((ctx, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Text(
                    'Assets da Exchange (${state.allAssets.length})',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                );
              } else if (index <= assets.length) {
                final asset = assets[index - 1];
                return ExchangeAssetRow(asset: asset, index: index - 1);
              } else {
                return Visibility(
                  visible: state.hasMoreAssets,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: ExchangeLoadMoreButton(
                      bloc: bloc,
                      hasMoreAssets: state.hasMoreAssets,
                    ),
                  ),
                );
              }
            }, childCount: assets.length + (state.hasMoreAssets ? 2 : 1)),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
