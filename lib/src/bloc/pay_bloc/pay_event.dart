part of 'pay_bloc.dart';

@immutable
abstract class PayEvent {}

class OnSeleccionarTarjeta extends PayEvent{
  final TarjetaCredito tarjetaCredito;

  OnSeleccionarTarjeta(this.tarjetaCredito);

}

class OnDesactivarTarjeta extends PayEvent{

}
