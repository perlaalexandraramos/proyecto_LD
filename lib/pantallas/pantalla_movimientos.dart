import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controladores/transaction_controller.dart';
import 'package:intl/intl.dart';

class PantallaMovimientos extends StatelessWidget {
  PantallaMovimientos({super.key});

  final TransactionController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Movimientos'),
        backgroundColor: const Color.fromARGB(255, 245, 231, 105),
      ),
      body: Obx(() {
        if (controller.transacciones.isEmpty) {
          return const Center(child: Text('No hay movimientos registrados'));
        } else {
          return ListView.builder(
            itemCount: controller.transacciones.length,
            itemBuilder: (context, index) {
              final t = controller.transacciones[index];
              final fecha = DateTime.parse(t['fecha']);
              return ListTile(
                leading: Icon(
                  t['tipo'] == 'Ingreso' ? Icons.arrow_downward : Icons.arrow_upward,
                  color: t['tipo'] == 'Ingreso' ? Colors.green : Colors.red,
                ),
                title: Text(t['categoria']),
                subtitle: Text(DateFormat('dd/MM/yyyy').format(fecha)),
                trailing: Text(
                  '\$${(t['monto'] as double).toStringAsFixed(2)}',
                  style: TextStyle(
                    color: t['tipo'] == 'Ingreso' ? Colors.green : Colors.red,
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