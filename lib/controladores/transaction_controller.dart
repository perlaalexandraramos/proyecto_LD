import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TransactionController extends GetxController {
  var transacciones = <Map<String, dynamic>>[].obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    cargarTransacciones();
  }

  void cargarTransacciones() {
    var almacenarTransacciones = box.read<List>('transacciones') ?? [];
    transacciones.assignAll(almacenarTransacciones.cast<Map<String, dynamic>>());
  }

  void agregarTransaccion({
    required double monto,
    required String categoria,
    required DateTime fecha,
    required String tipo,
  }) {
    final nuevaTransaccion = {
      'monto': monto,
      'categoria': categoria.trim(), // trim para evitar espacios extra
      'fecha': fecha.toIso8601String(),
      'tipo': tipo,
    };
    transacciones.add(nuevaTransaccion);
    guardarTransacciones();
  }

  void guardarTransacciones() {
    box.write('transacciones', transacciones);
  }

  List<Map<String, dynamic>> filtrarPorCategoria(String categoria) {
    return transacciones
        .where((t) => t['categoria'] == categoria.trim())
        .toList();
  }

  List<Map<String, dynamic>> filtrarPorFecha(DateTime date) {
    return transacciones
        .where((t) {
          final fechaTransaccion = DateTime.parse(t['fecha']);
          return fechaTransaccion.day == date.day &&
              fechaTransaccion.month == date.month &&
              fechaTransaccion.year == date.year;
        })
        .toList();
  }
}