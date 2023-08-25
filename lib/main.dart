import 'package:crypt/repositories/crypto_coins/abstarct_coins_repository.dart';
import 'package:crypt/repositories/crypto_coins/crypto_coins_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'crypto_currencies_list_app.dart';


void main() {
  final talker = TalkerFlutter.init();
  GetIt.I.registerLazySingleton(talker as FactoryFunc<Object>);
  GetIt.I<Talker>().debug('Talker starter...');

  GetIt.I.registerLazySingleton<AbstractCoinsRepository>
    (() => CryptoCoinsRepository(dio: Dio()),
  );

  runApp(const CryptoCurrenciesListApp());
}