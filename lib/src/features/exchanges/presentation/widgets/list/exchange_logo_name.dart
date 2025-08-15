import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../../../domain/domain.dart';

class ExchangeLogoName extends StatelessWidget {
  const ExchangeLogoName({
    super.key,
    required this.exchange,
    required this.theme,
  });

  final Exchange exchange;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (exchange.logo != null)
          DSIcon(url: exchange.logo!)
        else
          const Icon(Icons.business, size: 24),

        const SizedBox(width: 12),

        Expanded(
          child: Text(
            exchange.name,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
