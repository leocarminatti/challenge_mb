import 'package:flutter/material.dart';

import '../../../domain/domain.dart';

class ExchangeAboutSection extends StatefulWidget {
  final Exchange exchange;

  const ExchangeAboutSection({super.key, required this.exchange});

  @override
  State<ExchangeAboutSection> createState() => _ExchangeAboutSectionState();
}

class _ExchangeAboutSectionState extends State<ExchangeAboutSection> {
  bool _isExpanded = false;
  static const int _maxLines = 3;
  static const int _maxCharacters = 150;

  bool get _shouldShowExpandButton {
    final description = widget.exchange.description ?? '';
    return description.length > _maxCharacters ||
        description.split('\n').length > _maxLines;
  }

  String get _displayText {
    final description =
        widget.exchange.description ?? 'No description available.';

    if (_isExpanded) {
      return description;
    }

    if (description.length > _maxCharacters) {
      return '${description.substring(0, _maxCharacters)}...';
    }

    final lines = description.split('\n');
    if (lines.length > _maxLines) {
      return '${lines.take(_maxLines).join('\n')}...';
    }

    return description;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final description = widget.exchange.description ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About ${widget.exchange.name}',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'What Is ${widget.exchange.name}?',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: Text(
            _displayText,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.9),
              height: 1.5,
            ),
          ),
          secondChild: Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.9),
              height: 1.5,
            ),
          ),
        ),
        if (_shouldShowExpandButton) ...[
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              icon: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
                size: 20,
                color: theme.colorScheme.primary,
              ),
              label: Text(
                _isExpanded ? 'Mostrar Menos' : 'Mostrar Mais',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
