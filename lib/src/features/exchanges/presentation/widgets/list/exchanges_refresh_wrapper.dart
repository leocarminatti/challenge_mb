import 'package:flutter/material.dart';

import '../../bloc/exchanges_bloc.dart';
import '../../bloc/exchanges_event.dart';
import 'exchanges_list.dart';
import 'exchanges_table_header.dart';

class ExchangesRefreshWrapper extends StatelessWidget {
  final ExchangesBloc exchangesBloc;
  final ScrollController scrollController;

  const ExchangesRefreshWrapper({
    super.key,
    required this.exchangesBloc,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        exchangesBloc.add(const RefreshExchanges());
      },
      child: Column(
        children: [
          const ExchangesTableHeader(),

          Expanded(
            child: ExchangesList(
              exchangesBloc: exchangesBloc,
              scrollController: scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
