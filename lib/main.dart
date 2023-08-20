import 'package:crypt/repositories/crypto_coins/abstarct_coins_repository.dart';
import 'package:crypt/repositories/crypto_coins/crypto_coins_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'crypto_currencies_list_app.dart';

void main() {
  GetIt.I.registerLazySingleton<AbstractCoinsRepository>
    (() => CryptoCoinsRepository(dio: Dio()),
  );

  runApp(const CryptoCurrenciesListApp());
}