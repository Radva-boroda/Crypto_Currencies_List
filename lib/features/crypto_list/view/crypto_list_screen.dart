import 'dart:async';

import 'package:crypt/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:crypt/repositories/crypto_coins/abstarct_coins_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../../repositories/models/crypto_coin.dart';
import '../widgets/crypto_coin_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({
    super.key,
  });

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  List<CryptoCoin>? _cryptoCoinsList;
  final _cryptoListBloc = CryptoListBloc(
    GetIt.I<AbstractCoinsRepository>(),
  );

  @override
  void initState() {
    _cryptoListBloc.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Crypto List'),
          actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TalkerScreen(
                    talker: GetIt.I<Talker> (),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.document_scanner_outlined,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            final completer = Completer();
           _cryptoListBloc.add(LoadCryptoList(completer: completer));
           return completer.future;
            },
          child: BlocBuilder<CryptoListBloc,CryptoListState>(
          bloc: _cryptoListBloc,
          builder: (context, state) {
            if (state is CryptoListLoaded) {
                  return ListView.separated(
                      padding: const EdgeInsets.only(top: 16),
                      itemCount: state.coinsList.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, i) {
                        final coin = state.coinsList[i];
                        return CryptoCoinTile(coin: coin);
                      },
                    );
            }
            if(state is CryptoListLoadingFailure){
              var theme;
              return Center(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children : [
                  Text(
                      'Something went wrong',
                  style: theme.textThene.headlineMedium,
                  ),
                    Text(
                      'Please try againg later',
                      style: theme.textTheme.labelSmall?.copyWith(fontSize:16),
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                        onPressed: (){
                      _cryptoListBloc.add(LoadCryptoList());
                    },
                        child: const Text('Try aging')),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        )
    ),
    );
  }
}