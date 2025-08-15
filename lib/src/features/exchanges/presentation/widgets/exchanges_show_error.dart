import 'package:flutter/material.dart';

class ExchangesShowError extends StatelessWidget {
  const ExchangesShowError({super.key, required this.message, this.onRetry});

  final String message;
  final Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Erro: $message',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8),
          if (message.contains('rate limit') || message.contains('429'))
            const Text(
              'Limite de requisições excedido. Aguarde um momento.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.orange, fontSize: 14),
            ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Tentar Novamente'),
          ),
        ],
      ),
    );
  }
}
