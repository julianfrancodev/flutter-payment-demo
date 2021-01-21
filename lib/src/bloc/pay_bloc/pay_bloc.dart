import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:payment_flutter_app/src/models/tajeta_credito.dart';

part 'pay_event.dart';
part 'pay_state.dart';

class PayBloc extends Bloc<PayEvent, PayState> {
  PayBloc() : super(PayState());

  @override
  Stream<PayState> mapEventToState(
    PayEvent event,
  ) async* {
    if(event is OnSeleccionarTarjeta){
      yield state.copyWith(tarjetaActiva: true, tarjetaCredito: event.tarjetaCredito);

    }else if(event is OnDesactivarTarjeta){
      yield state.copyWith(tarjetaActiva: false);
    }
  }
}
