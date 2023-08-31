import 'dart:async';

import 'package:crypt/repositories/crypto_coins/abstarct_coins_repository.dart';
import 'package:crypt/repositories/crypto_coins/crypto_coins_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'crypto_currencies_list_app.dart';


void main() {
  final talker = TalkerFlutter.init();
  GetIt.I.registerLazySingleton(talker as FactoryFunc<Object>);
  GetIt.I<Talker>().debug('Talker starter...');

  final dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
    settings: const TalkerDioLoggerSettings(
      printResponseData: false,
      ),
    ),
  );

  Bloc.observer = TalkerBlocObserver(
    settings:const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    ),
  );

  GetIt.I.registerLazySingleton<AbstractCoinsRepository>
    (() => CryptoCoinsRepository(dio: dio),
  );

  FlutterError.onError =
      (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

runZonedGuarded(() => runApp(const CryptoCurrenciesListApp()), (e, st) {
  GetIt.I<Talker>().handle(e, st);
    },
  );
}