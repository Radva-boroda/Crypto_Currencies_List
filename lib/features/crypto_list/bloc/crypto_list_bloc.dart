import 'package:crypt/repositories/crypto_coins/abstarct_coins_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'crypto_list_event.dart';
part 'crypto_list_state.dart';


class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState>{
  CryptoListBloc(this.coinsRepository) : super(CryptoListInitial()) {
    on<CryptoListEvent>((event, emit) async {
     final cryptoCoinsList = await coinsRepository.getCoinsList();
    });
  }

  final AbstractCoinsRepository coinsRepository;


}