import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../../../domain/domain.dart';

class ExchangeHeader extends StatelessWidget {
  final Exchange exchange;

  const ExchangeHeader({super.key, required this.exchange});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        if (exchange.logo != null) DSIcon(url: exchange.logo!),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            exchange.name,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
