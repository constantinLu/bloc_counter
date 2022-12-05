import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/enum.dart';
import 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  StreamSubscription? streamSubscription;

  // initial state in the constructor always
  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    //initialize stream subscription into the constructor
    monitorInternetConnection();
  }

  void monitorInternetConnection() {
    //initialize stream subscription into the constructor
    streamSubscription = connectivity.onConnectivityChanged.listen((connectivityEvent) {
      if (connectivityEvent == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionType.Wifi);
      } else if (connectivityEvent == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.Mobile);
      } else if (connectivityEvent == ConnectivityResult.none) {
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType connectionType) =>
      emit(InternetConnected(connectionType: connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  //its possible that is already closed in this new version.
  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }

//close the stream

}
