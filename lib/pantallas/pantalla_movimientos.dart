import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controladores/movimientos_controller.dart';
import '../models/movimiento.dart';

class PantallaMovimientos extends StatelessWidget {
 final box = GetStorage();
   PantallaMovimientos({super.key});
  final MovimientosController controller = Get.put(MovimientosController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Movimientos'),
      ),
      body: Obx(() {
        if (controller.movimientos.isEmpty) {
          return Center(child: Text('No hay movimientos registrados'));
        } else {
          return ListView.builder(
            itemCount: controller.movimientos.length,
            itemBuilder: (context, index) {
              Movimiento movimiento = controller.movimientos[index];
              return ListTile(
                leading: Icon(
                  movimiento.tipo == 'ingreso'
                      ? Icons.arrow_downward
                      : Icons.arrow_upward,
                  color: movimiento.tipo == 'ingreso'
                      ? Colors.green
                      : Colors.red,
                ),
                title: Text(movimiento.categoria),

                subtitle: Text(
                movimiento.fecha.toLocal().toString().split(' ')[0],),

                trailing: Text(
                  '\$${movimiento.monto.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: movimiento.tipo == 'ingreso'
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}