import 'package:crypt/repositories/crypto_coins/abstarct_coins_repository.dart';
import 'package:dio/dio.dart';
import '../models/crypto_coin.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  CryptoCoinsRepository({
    required this.dio,
  });

  final Dio dio;


  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,ETC,BNB,TRX,DOGE,SHIB,WIN&tsyms=USD,EUR');

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e) {
          final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
          final price = usdData['PRICE'];
          final imageUrl = usdData['IMAGEURL'];
          return CryptoCoin(
              name: e.key,
              priceInUSD: price,
              imageUrl:  'https://www.cryptocompare.com/$imageUrl',
          );
        }).toList();
    return cryptoCoinsList;
  }
}