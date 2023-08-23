part of 'crypto_list_bloc.dart';

abstract class CryptoListEvent{
  var completer;
}

class LoadCryptoList extends CryptoListEvent{
  LoadCryptoList({
     this.completer,
  });

  final Completer? completer;
}