import 'package:challenge_mb/src/features/exchanges/domain/domain.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/bloc/exchange_details_bloc.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/bloc/exchange_details_state.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/bloc/exchanges_bloc.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/bloc/exchanges_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockExchangeDetailsBloc extends Mock implements ExchangeDetailsBloc {}

class MockExchangesBloc extends Mock implements ExchangesBloc {
  @override
  Stream<ExchangesState> get stream => Stream.value(ExchangesInitial());
}

class UIMocks {
  static Exchange createMockExchange({
    String id = '1',
    String name = 'Binance',
    String? logo = 'https://example.com/binance.png',
    String? description = 'Leading cryptocurrency exchange',
    String? url = 'https://binance.com',
    double? makerFee = 0.1,
    double? takerFee = 0.1,
    DateTime? dateLaunched,
    double? spotVolumeUsd = 15000000.0,
  }) {
    return Exchange(
      id: id,
      name: name,
      logo: logo,
      description: description,
      url: url,
      makerFee: makerFee,
      takerFee: takerFee,
      dateLaunched: dateLaunched ?? DateTime(2017, 7, 14),
      spotVolumeUsd: spotVolumeUsd,
    );
  }

  static ExchangeAsset createMockExchangeAsset({
    String? walletAddress = '0x1234567890abcdef',
    double? balance = 1.5,
    Platform? platform,
    AssetCurrency? currency,
  }) {
    return ExchangeAsset(
      walletAddress: walletAddress,
      balance: balance,
      platform:
          platform ??
          const Platform(cryptoId: 1, symbol: 'BTC', name: 'Bitcoin'),
      currency:
          currency ??
          const AssetCurrency(
            cryptoId: 1,
            priceUsd: 50000.0,
            symbol: 'BTC',
            name: 'Bitcoin',
          ),
    );
  }

  static List<Exchange> createMockExchangesList() {
    return [
      createMockExchange(
        id: '1',
        name: 'Binance',
        logo: 'https://example.com/binance.png',
        spotVolumeUsd: 15000000.0,
      ),
      createMockExchange(
        id: '2',
        name: 'Coinbase',
        logo: 'https://example.com/coinbase.png',
        spotVolumeUsd: 8000000.0,
      ),
      createMockExchange(
        id: '3',
        name: 'Kraken',
        logo: 'https://example.com/kraken.png',
        spotVolumeUsd: 5000000.0,
      ),
    ];
  }

  static List<ExchangeAsset> createMockExchangeAssetsList() {
    return [
      createMockExchangeAsset(
        currency: const AssetCurrency(
          cryptoId: 1,
          priceUsd: 50000.0,
          symbol: 'BTC',
          name: 'Bitcoin',
        ),
        balance: 1.5,
      ),
      createMockExchangeAsset(
        currency: const AssetCurrency(
          cryptoId: 1027,
          priceUsd: 3000.0,
          symbol: 'ETH',
          name: 'Ethereum',
        ),
        balance: 10.0,
      ),
      createMockExchangeAsset(
        currency: const AssetCurrency(
          cryptoId: 2010,
          priceUsd: 1.5,
          symbol: 'ADA',
          name: 'Cardano',
        ),
        balance: 1000.0,
      ),
    ];
  }

  static ExchangesLoaded createMockExchangesLoadedState({
    List<Exchange>? exchanges,
    bool hasReachedMax = false,
    int currentPage = 1,
  }) {
    return ExchangesLoaded(
      exchanges: exchanges ?? createMockExchangesList(),
      hasReachedMax: hasReachedMax,
      currentPage: currentPage,
    );
  }

  static ExchangeDetailsLoaded createMockExchangeDetailsLoadedState({
    Exchange? exchange,
    List<ExchangeAsset>? allAssets,
    bool hasMoreAssets = false,
    int currentPage = 1,
    int assetsPerPage = 10,
  }) {
    final mockExchange = exchange ?? createMockExchange();
    final mockAssets = allAssets ?? createMockExchangeAssetsList();

    return ExchangeDetailsLoaded(
      ExchangeDetailsWithAssets(exchange: mockExchange, assets: mockAssets),
      allAssets: mockAssets,
      hasMoreAssets: hasMoreAssets,
      currentPage: currentPage,
      assetsPerPage: assetsPerPage,
    );
  }

  static Widget createWidgetWithMockBloc<T extends BlocBase>(
    Widget child,
    T mockBloc,
  ) {
    return BlocProvider<T>.value(
      value: mockBloc,
      child: MaterialApp(
        home: Scaffold(body: child),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  static Widget createWidgetWithMockExchangesBloc(
    Widget child,
    MockExchangesBloc mockBloc,
  ) {
    return BlocProvider<ExchangesBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: Scaffold(body: child),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  static Widget createWidgetWithMockExchangeDetailsBloc(
    Widget child,
    MockExchangeDetailsBloc mockBloc,
  ) {
    return BlocProvider<ExchangeDetailsBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: Scaffold(body: child),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
