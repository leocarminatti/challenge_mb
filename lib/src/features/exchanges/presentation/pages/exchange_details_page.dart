import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/core.dart';
import '../../domain/entities/exchange.dart';
import '../bloc/exchange_details_bloc.dart';
import '../bloc/exchange_details_event.dart';
import '../widgets/widgets.dart';

class ExchangeDetailsPage extends StatefulWidget {
  final Exchange exchange;

  const ExchangeDetailsPage({super.key, required this.exchange});

  @override
  State<ExchangeDetailsPage> createState() => _ExchangeDetailsPageState();
}

class _ExchangeDetailsPageState extends State<ExchangeDetailsPage> {
  late final ExchangeDetailsBloc _exchangeDetailsBloc;
  Exchange get exchange => widget.exchange;

  @override
  void initState() {
    super.initState();
    _exchangeDetailsBloc = GetIt.instance<ExchangeDetailsBloc>();
    _exchangeDetailsBloc.add(LoadExchangeDetails(widget.exchange));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const DSAppBar(title: 'Exchange Details'),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: RepaintBoundary(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ExchangeHeader(exchange: exchange),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
          SliverToBoxAdapter(
            child: RepaintBoundary(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ExchangeFinancialMetrics(exchange: exchange),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
          SliverToBoxAdapter(
            child: RepaintBoundary(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ExchangeLinksAndActions(exchange: exchange),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
          SliverToBoxAdapter(
            child: RepaintBoundary(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ExchangeAboutSection(exchange: exchange),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ExchangeAssetsList(bloc: _exchangeDetailsBloc),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}
