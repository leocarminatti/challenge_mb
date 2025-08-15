import 'package:challenge_mb/src/features/exchanges/domain/entities/exchange.dart';
import 'package:challenge_mb/src/features/exchanges/domain/entities/exchange_asset.dart';
import 'package:challenge_mb/src/features/exchanges/domain/entities/exchange_map.dart';

class EntitiesMocks {
  static final List<ExchangeMap> exchangeMaps = [
    const ExchangeMap(id: '1'),
    const ExchangeMap(id: '2'),
    const ExchangeMap(id: '3'),
    const ExchangeMap(id: '4'),
    const ExchangeMap(id: '5'),
  ];

  static final List<Exchange> exchanges = [
    Exchange(
      id: '1',
      name: 'Binance',
      logo: null,
      description: 'Leading cryptocurrency exchange',
      dateLaunched: DateTime.parse('2017-07-14T20:00:00.000Z'),
      spotVolumeUsd: 1000000000.0,
    ),
    Exchange(
      id: '2',
      name: 'Coinbase',
      logo: null,
      description: 'Digital currency exchange',
      dateLaunched: DateTime.parse('2017-01-01T00:00:00.000Z'),
      spotVolumeUsd: 500000000.0,
    ),
    Exchange(
      id: '3',
      name: 'Kraken',
      logo: null,
      description: 'Cryptocurrency exchange',
      dateLaunched: DateTime.parse('2011-07-28T00:00:00.000Z'),
      spotVolumeUsd: 300000000.0,
    ),
    Exchange(
      id: '4',
      name: 'KuCoin',
      logo: 'https://via.placeholder.com/48x48/23D160/FFFFFF?text=K',
      description: 'Global cryptocurrency exchange',
      dateLaunched: DateTime.parse('2017-09-01T00:00:00.000Z'),
      spotVolumeUsd: 200000000.0,
    ),
    Exchange(
      id: '5',
      name: 'Huobi',
      logo: 'https://via.placeholder.com/48x48/FF6B35/FFFFFF?text=H',
      description: 'Digital asset exchange',
      dateLaunched: DateTime.parse('2013-09-01T00:00:00.000Z'),
      spotVolumeUsd: 400000000.0,
    ),
    Exchange(
      id: '6',
      name: 'OKX',
      logo: 'https://via.placeholder.com/48x48/000000/FFFFFF?text=O',
      description: 'Cryptocurrency trading platform',
      dateLaunched: DateTime.parse('2017-10-01T00:00:00.000Z'),
      spotVolumeUsd: 350000000.0,
    ),
    Exchange(
      id: '7',
      name: 'Bybit',
      logo: 'https://via.placeholder.com/48x48/FFD700/000000?text=B',
      description: 'Cryptocurrency derivatives exchange',
      dateLaunched: DateTime.parse('2018-03-01T00:00:00.000Z'),
      spotVolumeUsd: 250000000.0,
    ),
    Exchange(
      id: '8',
      name: 'Bitfinex',
      logo: 'https://via.placeholder.com/48x48/87CEEB/000000?text=B',
      description: 'Digital asset trading platform',
      dateLaunched: DateTime.parse('2012-12-01T00:00:00.000Z'),
      spotVolumeUsd: 180000000.0,
    ),
    Exchange(
      id: '9',
      name: 'Gate.io',
      logo: 'https://via.placeholder.com/48x48/32CD32/FFFFFF?text=G',
      description: 'Cryptocurrency exchange',
      dateLaunched: DateTime.parse('2017-04-01T00:00:00.000Z'),
      spotVolumeUsd: 120000000.0,
    ),
    Exchange(
      id: '10',
      name: 'Bitstamp',
      logo: 'https://via.placeholder.com/48x48/FF4500/FFFFFF?text=B',
      description: 'Digital currency exchange',
      dateLaunched: DateTime.parse('2011-08-01T00:00:00.000Z'),
      spotVolumeUsd: 90000000.0,
    ),
    Exchange(
      id: '11',
      name: 'Gemini',
      logo: 'https://via.placeholder.com/48x48/00CED1/000000?text=G',
      description: 'Cryptocurrency exchange and custodian',
      dateLaunched: DateTime.parse('2015-10-01T00:00:00.000Z'),
      spotVolumeUsd: 80000000.0,
    ),
    Exchange(
      id: '12',
      name: 'Crypto.com',
      logo: 'https://via.placeholder.com/48x48/103F68/FFFFFF?text=C',
      description: 'Cryptocurrency exchange and wallet',
      dateLaunched: DateTime.parse('2016-06-01T00:00:00.000Z'),
      spotVolumeUsd: 150000000.0,
    ),
    Exchange(
      id: '13',
      name: 'FTX',
      logo: 'https://via.placeholder.com/48x48/FF6B6B/FFFFFF?text=F',
      description: 'Cryptocurrency derivatives exchange',
      dateLaunched: DateTime.parse('2019-05-01T00:00:00.000Z'),
      spotVolumeUsd: 300000000.0,
    ),
    Exchange(
      id: '14',
      name: 'Deribit',
      logo: 'https://via.placeholder.com/48x48/8A2BE2/FFFFFF?text=D',
      description: 'Cryptocurrency options exchange',
      dateLaunched: DateTime.parse('2016-07-01T00:00:00.000Z'),
      spotVolumeUsd: 70000000.0,
    ),
    Exchange(
      id: '15',
      name: 'dYdX',
      logo: 'https://via.placeholder.com/48x48/00D4AA/FFFFFF?text=D',
      description: 'Decentralized derivatives exchange',
      dateLaunched: DateTime.parse('2017-08-01T00:00:00.000Z'),
      spotVolumeUsd: 60000000.0,
    ),
  ];

  static final List<ExchangeAsset> exchangeAssets = [
    const ExchangeAsset(
      walletAddress: '0x1234567890abcdef',
      balance: 1000.5,
      platform: null,
      currency: AssetCurrency(cryptoId: 1, symbol: 'BTC', name: 'Bitcoin'),
    ),
    const ExchangeAsset(
      walletAddress: '0xabcdef1234567890',
      balance: 5000.0,
      platform: null,
      currency: AssetCurrency(cryptoId: 1027, symbol: 'ETH', name: 'Ethereum'),
    ),
    const ExchangeAsset(
      walletAddress: '0x9876543210fedcba',
      balance: 25000.0,
      platform: Platform(cryptoId: 52, symbol: 'XRP', name: 'XRP'),
      currency: AssetCurrency(cryptoId: 52, symbol: 'XRP', name: 'XRP'),
    ),
  ];

  static Exchange getExchangeById(String id) {
    return exchanges.firstWhere((exchange) => exchange.id == id);
  }

  static List<Exchange> getExchangesByIds(List<String> ids) {
    return exchanges.where((exchange) => ids.contains(exchange.id)).toList();
  }

  static List<ExchangeMap> getExchangeMapsByIds(List<String> ids) {
    return exchangeMaps.where((map) => ids.contains(map.id)).toList();
  }

  static List<ExchangeAsset> getAssetsForExchange(String exchangeId) {
    switch (exchangeId) {
      case '1':
        return exchangeAssets;
      case '2':
        return [exchangeAssets[0], exchangeAssets[1]];
      case '3':
        return [exchangeAssets[2]];
      default:
        return [];
    }
  }
}
