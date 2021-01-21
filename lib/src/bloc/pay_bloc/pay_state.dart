part of 'pay_bloc.dart';

@immutable
class PayState {
  final double monto;
  final String moneda;
  final bool tarjetaActiva;
  final TarjetaCredito tarjetaCredito;

  PayState(
      {this.monto = 375.5,
      this.moneda = "USD",
      this.tarjetaActiva = false,
      this.tarjetaCredito});

  PayState copyWith({
    double monto,
    String moneda,
    bool tarjetaActiva,
    TarjetaCredito tarjetaCredito,
  }) =>
      PayState(
          monto: monto ?? this.monto,
          moneda: moneda ?? this.moneda,
          tarjetaActiva: tarjetaActiva ?? this.tarjetaActiva,
          tarjetaCredito: tarjetaCredito ?? this.tarjetaCredito);
}
