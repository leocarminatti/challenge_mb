import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../../../domain/domain.dart';

class ExchangeDateLaunched extends StatelessWidget {
  const ExchangeDateLaunched({
    super.key,
    required this.exchange,
    required this.theme,
  });

  final Exchange exchange;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (exchange.dateLaunched != null) ...[
            Text(
              FormatUtils.formatYear(exchange.dateLaunched!),
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.end,
            ),
            const SizedBox(height: 2),
            Text(
              FormatUtils.formatMonth(exchange.dateLaunched!),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.end,
            ),
          ] else ...[
            Text(
              'N/A',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.end,
            ),
          ],
        ],
      ),
    );
  }
}
