import 'package:crypt/repositories/crypto_coins/crypto_coins_repository.dart';
import 'package:flutter/material.dart';
import '../../../repositories/models/crypto_coin.dart';
import '../../crypto_coin/view/crypto_coin_screen.dart';
import '../widgets/crypto_coin_title.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({
    super.key,
  });

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {

  List<CryptoCoin>? _cryptoCoinsList;


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('CryptoCurrenciesList'),
      ),
      body:(_cryptoCoinsList == null)
          ? const SizedBox() :
      ListView.separated(
        itemCount: _cryptoCoinsList!.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, i) {
         final coin = _cryptoCoinsList![i];
          return CryptoCoinTile(coin : coin);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.download),
        onPressed: ()async{
          _cryptoCoinsList = await CryptoCoinsRepository().getCoinsList();
          setState(() {});
          },
      ),
    );
  }
}
