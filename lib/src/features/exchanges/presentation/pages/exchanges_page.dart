import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/core.dart';
import '../bloc/exchanges_bloc.dart';
import '../bloc/exchanges_event.dart';
import '../bloc/exchanges_state.dart';
import '../widgets/widgets.dart';

class ExchangesPage extends StatefulWidget {
  final ExchangesBloc? exchangesBloc;

  const ExchangesPage({super.key, this.exchangesBloc});

  @override
  State<ExchangesPage> createState() => _ExchangesPageState();
}

class _ExchangesPageState extends State<ExchangesPage> {
  final ScrollController _scrollController = ScrollController();
  late final ExchangesBloc _exchangesBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    _exchangesBloc = widget.exchangesBloc ?? GetIt.instance<ExchangesBloc>();
    _exchangesBloc.add(const LoadExchanges());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final state = _exchangesBloc.state;
      if (state is ExchangesLoaded && !state.hasReachedMax) {
        if (state is! ExchangesLoadingMore) {
          _exchangesBloc.add(const LoadMoreExchanges());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: DSAppBar(
        title: 'Exchanges',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: const DsLogo(width: 30, height: 30),
          ),
        ],
      ),
      body: BlocBuilder<ExchangesBloc, ExchangesState>(
        bloc: _exchangesBloc,
        builder: (context, state) {
          return switch (state) {
            ExchangesInitial() => const DsLoading(),
            ExchangesLoading() => const DsLoading(),
            ExchangesError() => ExchangesShowError(
              message: state.message,
              onRetry: () {
                _exchangesBloc.add(const LoadExchanges());
              },
            ),
            ExchangesLoaded() ||
            ExchangesLoadingMore() => ExchangesRefreshWrapper(
              exchangesBloc: _exchangesBloc,
              scrollController: _scrollController,
            ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
