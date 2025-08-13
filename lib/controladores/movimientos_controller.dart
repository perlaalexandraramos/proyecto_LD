import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/movimiento.dart';

class MovimientosController extends GetxController {
  var movimientos = <Movimiento>[].obs;

  final box = GetStorage();

  final String storageKey = 'movimientos';

  @override
  void onInit() {
    super.onInit();
    cargarMovimientos();
  }

  void cargarMovimientos() {
    List<dynamic>? datosGuardados = box.read<List<dynamic>>(storageKey);

    if (datosGuardados != null) {
      movimientos.value = datosGuardados
          .map((item) => Movimiento.fromJson(item))
          .toList();
    } else {
      movimientos.value = [];
    }
  }

  void guardarMovimientos() {
    List<Map<String, dynamic>> listaParaGuardar =
        movimientos.map((m) => m.toJson()).toList();

    box.write(storageKey, listaParaGuardar);
  }

  void agregarMovimiento(Movimiento movimiento) {
    movimientos.add(movimiento);
    guardarMovimientos();
  }

  void eliminarMovimiento(int index) {
    if (index >= 0 && index < movimientos.length) {
      movimientos.removeAt(index);
      guardarMovimientos();
    }
  }

}
