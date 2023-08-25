
import 'package:crypt/repositories/crypto_coins/abstarct_coins_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'crypto_coin_details_event.dart';
import 'crypto_coin_details_state.dart';

class CryptoCoinDetailsBloc extends
    Bloc<CryptoCoinDetailsEvent, CryptoCoinDetailsState> {
  CryptoCoinDetailsBloc (this.coinsRepository)
      : super(const CryptoCoinDetailsState()) {
    on<LoadCryptoCoinDetails>(_load);
  }
  final AbstractCoinsRepository coinsRepository;

  Future<void> _load(
  LoadCryptoCoinDetails event,
  Emitter<CryptoCoinDetailsState> emit,
      ) async {
    try{
      if (state is! CryptoCoinDetailsLoaded) {
        emit (const CryptoCoinDetailsLoading());
      }
      final coinDetails =
          await coinsRepository.getCoinsDetails(event.currencyCode);

      emit(CryptoCoinDetailsLoaded(coinDetails));
    } catch (e) {
      emit(CryptoCoinDetailsLoadingFailure(e));
    }
  }
}







