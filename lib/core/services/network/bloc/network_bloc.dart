// import 'dart:developer';

// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../service/network_service.dart';
// part 'network_event.dart';
// part 'network_state.dart';

// class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
//   NetworkBloc._() : super(NetworkInitial()) {
//     on<NetworkObserve>(_observe);
//     on<NetworkNotify>(_notifyStatus);
//   }

//   static final NetworkBloc _instance = NetworkBloc._();

//   factory NetworkBloc() => _instance;

//   void _observe(NetworkObserve event, Emitter<NetworkState> emit) {
//     log("IN NETWORK OBSERVE");
//     NetworkService.observeNetwork().listen((isConnected) {
//       add(NetworkNotify(isConnected: isConnected));
//     });
//   }

//   void _notifyStatus(NetworkNotify event, emit) {
//     log("Network Check ${event.isConnected}");
//     event.isConnected ? emit(NetworkSuccess()) : emit(NetworkFailure());
//   }
// }
