import 'dart:async';

import 'package:crypt/repositories/crypto_coins/abstarct_coins_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../../repositories/models/crypto_coin.dart';
part 'crypto_list_event.dart';
part 'crypto_list_state.dart';


class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState>{
  CryptoListBloc(this.coinsRepository) : super(CryptoListInitial()) {
    on<LoadCryptoList(_load);

    final AbstractCoinsRepository coinsRepository;
  }

  Future<void> _load(
      LoadCryptoList event,
      Emitter<CryptoListState> emit,
      ) async {
    try {
      if (state is! CryptoListLoaded){
        emit(CryptoListLoading());
      }
      final coinsList = await coinsRepository.getCoinsList();
      emit(CryptoListLoaded(coinsList : coinsList));
    } catch (e,st) {
      emit(CryptoListLoadingFailure(exception: e));
      GetIt.I<Talker>().handle(e,st, 'Vulit');
    }
    finally {
      event.completer?.complete();
    }
  }
  @override
  void onError (Object error, StackTrace stackTrace){
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
