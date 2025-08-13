import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class TransactionController extends GetxController {
  var transacciones = <Map<String, dynamic>>[].obs;
  final box = GetStorage();
  String? usuarioIdActivo;

  @override
  void onInit() {
    super.onInit();
    final usuarioActivo = box.read('usuarioActivo');
    usuarioIdActivo = usuarioActivo?['id'];
    cargarTransacciones();
  }

  void cargarTransacciones() {
      var almacenarTransacciones = box.read<List>('transacciones') ?? [];
    
    transacciones.assignAll(
      almacenarTransacciones
          .cast<Map<String, dynamic>>()
          .where((t) => t['usuarioId'] == usuarioIdActivo)
          .toList(),
    );
  }

  void agregarTransaccion({
    required double monto,
    required String categoria,
    required DateTime fecha,
    required String tipo,
  }) {
    final nuevaTransaccion = {
      'monto': monto,
      'categoria': categoria.trim(),
      'fecha': fecha.toIso8601String(),
      'tipo': tipo,
      'usuarioId': usuarioIdActivo,
    };
    transacciones.add(nuevaTransaccion);
    guardarTransacciones();
  }

  void guardarTransacciones() {
     var almacenarTransacciones = box.read<List>('transacciones') ?? [];
    almacenarTransacciones.add(transacciones.last);
    box.write('transacciones', almacenarTransacciones);
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