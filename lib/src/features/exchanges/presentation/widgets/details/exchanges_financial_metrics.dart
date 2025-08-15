import 'package:flutter/material.dart';

import '../../../../../../core/utils/utils.dart';
import '../../../domain/domain.dart';

class ExchangeFinancialMetrics extends StatelessWidget {
  final Exchange exchange;

  const ExchangeFinancialMetrics({super.key, required this.exchange});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Spot Trading Volume (24h)',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '\$${FormatUtils.formatNumber(exchange.spotVolumeUsd ?? 0)}',
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${CalculationUtils.calculateBTCEquivalent(exchange.spotVolumeUsd ?? 0)} BTC',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'Total assets',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '\$${FormatUtils.formatNumber(CalculationUtils.calculateTotalAssets(exchange.spotVolumeUsd ?? 0))}',
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
