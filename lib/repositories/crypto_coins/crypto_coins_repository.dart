import 'package:dio/dio.dart';
import '../models/crypto_coin.dart';

class CryptoCoinsRepository {
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await Dio().get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC&tsyms=USD,EUR');

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['Raw'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e) {
          final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
          final price = usdData['PRICE'];
          final imageUrl = usdData['IMAGEURL'];
          return CryptoCoin(
              name: e.key,
              priceInUSD: price,
              imageUrl: imageUrl,
          );
        }).toList();
    return cryptoCoinsList;
  }
}