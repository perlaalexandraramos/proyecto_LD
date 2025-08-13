import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto/pantallas/pantalla_ingresos.dart';
import 'package:proyecto/pantallas/pantalla_inicio.dart';
import 'package:proyecto/pantallas/pantalla_principal.dart';
import 'package:proyecto/registro/pantalla_login.dart';
import 'package:proyecto/registro/pantalla_registro.dart';
import 'package:proyecto/controladores/transaction_controller.dart';
import 'package:proyecto/pantallas/pantalla_graficos.dart';
import 'package:proyecto/pantallas/pantalla_movimientos.dart';


void main() async {

  await GetStorage.init();
  Get.put(TransactionController());  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Control de gastos",
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: ()=> PantallaInicio()),
        GetPage(name: '/registro', page: ()=> PantallaRegistro()),
        GetPage(name: '/login', page: ()=> PantallaLogin()),
        GetPage(name: '/inicio', page: ()=> PantallaInicio()),
        GetPage(name: '/ingresos', page: ()=> PantallaIngresos()),
        GetPage(name: '/Graficos', page: ()=> PantallaGraficos()),
        GetPage(name: '/movimientos', page: () => PantallaMovimientos()),

      ],
    );
  }
}