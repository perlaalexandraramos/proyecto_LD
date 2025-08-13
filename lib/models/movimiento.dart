
class Movimiento {
  double monto;
  String categoria;
  DateTime fecha;
  String tipo; 

  Movimiento({
    required this.monto,
    required this.categoria,
    required this.fecha,
    required this.tipo,
  });

  Map<String, dynamic> toJson() {
    return {
      'monto': monto,
      'categoria': categoria,
      'fecha': fecha.toIso8601String(), 
      'tipo': tipo,
    };
  }

  factory Movimiento.fromJson(Map<String, dynamic> json) {
    return Movimiento(
      monto: json['monto'],
      categoria: json['categoria'],
      fecha: DateTime.parse(json['fecha']),
      tipo: json['tipo'],
    );
  }
}
