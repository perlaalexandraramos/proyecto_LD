import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto/pantallas/pantalla_graficos.dart';
import 'package:proyecto/pantallas/pantalla_ingresos.dart';

class PantallaInicio extends StatelessWidget {
  final box = GetStorage();
   PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioActivo= box.read('usuarioActivo');
    final nombreUsuario =usuarioActivo?['nombre'] ?? 'Usuario';

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Control de Gastos Personales",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
      
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.account_balance_wallet_rounded,
              size: 100,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
             Text(
              "¡Bienvenido!, $nombreUsuario!",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 40),

            ElevatedButton.icon(
              icon: const Icon(Icons.add_circle_outline, size: 28, 
              color: Colors.black),
              label: const Text(
                "Registrar Gastos / Ingresos",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,
                color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                backgroundColor: const Color.fromARGB(255, 245, 231, 105),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PantallaIngresos()),
                );
              },
            ),
            const SizedBox(height: 25),

          
            ElevatedButton.icon(
              icon: const Icon(Icons.list_alt_outlined, size: 28, color: Colors.black,),
              label: const Text(
                "Ver Movimientos",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,
                color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                backgroundColor: const Color.fromARGB(255, 136, 190, 243),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PantallaIngresos()),
                );
              },
            ),
            const SizedBox(height: 25),

         
            ElevatedButton.icon(
              icon: const Icon(Icons.bar_chart_outlined, size: 28, color: Colors.black,),
              label: const Text(
                "Ver Gráficos",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,
                color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                backgroundColor: const Color.fromARGB(255, 64, 219, 116),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  PantallaGraficos()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}