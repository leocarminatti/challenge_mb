import 'package:flutter/material.dart';

import '../../../domain/domain.dart';
import '../widgets.dart';

class ExchangeLinksAndActions extends StatelessWidget {
  final Exchange exchange;

  const ExchangeLinksAndActions({super.key, required this.exchange});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (exchange.url != null) ...[
          ExchangeLinkItem(
            icon: Icons.link,
            url: exchange.url!,
            label: exchange.url!,
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}
