
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TransactionController extends GetxController {
  var transacciones = <Map<String, dynamic>>[].obs;
  
   final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    CargarTransacciones();
  }

  void CargarTransacciones(){
    var almacenarTransacciones = box.read<List>("Transacciones") ?? [];
    transacciones.assignAll(almacenarTransacciones.cast<Map<String, dynamic>>());
  }

  void AgregarTransacciones({
    required double monto,
    required String categoria,
    required DateTime fecha,
    required String tipo, 
  }) {

  final nuevaTransaccion = {
      'monto': monto,
      'categoria': categoria,
      'fecha': fecha.toIso8601String(),
      'tipo': tipo,
    };
     transacciones.add(nuevaTransaccion);
    GuardarTransacciones();
  }

  void GuardarTransacciones(){
    box.write('transacciones', transacciones);
  }

    List<Map<String, dynamic>> filtrarporCategoria(String categoria) {
    return transacciones
        .where((t) => t['categoria'] == categoria)
        .toList();
  }

  // Filtrar por fecha
  List<Map<String, dynamic>> filtrarPorFecha(DateTime date) {
    return transacciones
        .where((t) =>
            DateTime.parse(t['Fecha']).day == date.day &&
            DateTime.parse(t['date']).month == date.month &&
            DateTime.parse(t['date']).year == date.year)
        .toList();
  }
  
}