import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/core.dart';
import '../../../domain/entities/exchange.dart';
import '../widgets.dart';

class ExchangeListItem extends StatelessWidget {
  final Exchange exchange;
  final int rank;

  const ExchangeListItem({
    super.key,
    required this.exchange,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.3),
            width: 0.5,
          ),
        ),
      ),
      child: InkWell(
        onTap: () {
          context.push('/exchange', extra: exchange);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              DSRanking(
                text: rank.getRankText(),
                color: rank.getRankColor(theme),
              ),
              Expanded(
                child: ExchangeLogoName(exchange: exchange, theme: theme),
              ),
              ExchangeVolumeTrading(exchange: exchange, theme: theme),
              ExchangeDateLaunched(exchange: exchange, theme: theme),
            ],
          ),
        ),
      ),
    );
  }
}
