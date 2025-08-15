class JsonMocks {
  static const Map<String, dynamic> exchangeMapResponse = {
    'data': [
      {'id': 1, 'name': 'Binance', 'slug': 'binance', 'is_active': true},
      {'id': 2, 'name': 'Coinbase', 'slug': 'coinbase', 'is_active': true},
      {'id': 3, 'name': 'Kraken', 'slug': 'kraken', 'is_active': true},
    ],
    'status': {
      'timestamp': '2024-01-01T00:00:00.000Z',
      'error_code': 0,
      'error_message': null,
    },
  };

  static const Map<String, dynamic> exchangeDetailsResponse = {
    'data': {
      '1': {
        'id': '1',
        'name': 'Binance',
        'logo': 'https://example.com/binance.png',
        'description': 'Leading cryptocurrency exchange',
        'date_launched': '2017-07-14T20:00:00.000Z',
        'spot_volume_usd': 1000000000.0,
        'urls': {
          'website': ['https://binance.com'],
          'twitter': ['https://twitter.com/binance'],
          'reddit': ['https://reddit.com/r/binance'],
        },
      },
      '2': {
        'id': '2',
        'name': 'Coinbase',
        'logo': 'https://example.com/coinbase.png',
        'description': 'Digital currency exchange',
        'date_launched': '2017-01-01T00:00:00.000Z',
        'spot_volume_usd': 500000000.0,
        'urls': {
          'website': ['https://coinbase.com'],
          'twitter': ['https://twitter.com/coinbase'],
          'reddit': ['https://reddit.com/r/coinbase'],
        },
      },
    },
    'status': {
      'timestamp': '2024-01-01T00:00:00.000Z',
      'error_code': 0,
      'error_message': null,
    },
  };

  static const Map<String, dynamic> exchangeAssetsResponse = {
    'data': [
      {
        'wallet_address': '0x1234567890abcdef',
        'balance': 1000.5,
        'platform': {'crypto_id': 1, 'symbol': 'BTC', 'name': 'Bitcoin'},
        'currency': {
          'crypto_id': 1,
          'price_usd': 45000.0,
          'symbol': 'BTC',
          'name': 'Bitcoin',
        },
      },
      {
        'wallet_address': '0xabcdef1234567890',
        'balance': 5000.0,
        'platform': null,
        'currency': {
          'crypto_id': 1027,
          'price_usd': 3000.0,
          'symbol': 'ETH',
          'name': 'Ethereum',
        },
      },
      {
        'wallet_address': '0x9876543210fedcba',
        'balance': 25000.0,
        'platform': {'crypto_id': 52, 'symbol': 'XRP', 'name': 'XRP'},
        'currency': {
          'crypto_id': 52,
          'price_usd': 0.5,
          'symbol': 'XRP',
          'name': 'XRP',
        },
      },
    ],
    'status': {
      'timestamp': '2024-01-01T00:00:00.000Z',
      'error_code': 0,
      'error_message': null,
    },
  };

  static const Map<String, dynamic> errorResponse = {
    'status': {
      'timestamp': '2024-01-01T00:00:00.000Z',
      'error_code': 500,
      'error_message': 'Internal server error',
    },
  };

  static const Map<String, dynamic> notFoundResponse = {
    'status': {
      'timestamp': '2024-01-01T00:00:00.000Z',
      'error_code': 404,
      'error_message': 'Exchange not found',
    },
  };

  static const Map<String, dynamic> forbiddenResponse = {
    'status': {
      'timestamp': '2024-01-01T00:00:00.000Z',
      'error_code': 403,
      'error_message': 'Access denied',
    },
  };

  static const Map<String, dynamic> malformedResponse = {
    'data': 'invalid_data',
    'status': {
      'timestamp': '2024-01-01T00:00:00.000Z',
      'error_code': 0,
      'error_message': null,
    },
  };

  static const Map<String, dynamic> emptyResponse = {
    'data': [],
    'status': {
      'timestamp': '2024-01-01T00:00:00.000Z',
      'error_code': 0,
      'error_message': null,
    },
  };

  static Map<String, dynamic> getExchangeMapResponse(
    List<Map<String, dynamic>> exchanges,
  ) {
    return {
      'data': exchanges,
      'status': {
        'timestamp': '2024-01-01T00:00:00.000Z',
        'error_code': 0,
        'error_message': null,
      },
    };
  }

  static Map<String, dynamic> getExchangeDetailsResponse(
    Map<String, dynamic> exchanges,
  ) {
    return {
      'data': exchanges,
      'status': {
        'timestamp': '2024-01-01T00:00:00.000Z',
        'error_code': 0,
        'error_message': null,
      },
    };
  }

  static Map<String, dynamic> getExchangeAssetsResponse(
    List<Map<String, dynamic>> assets,
  ) {
    return {
      'data': assets,
      'status': {
        'timestamp': '2024-01-01T00:00:00.000Z',
        'error_code': 0,
        'error_message': null,
      },
    };
  }
}
