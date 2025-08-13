import 'package:flutter/material.dart';
import 'package:proyecto/registro/pantalla_login.dart';
import 'package:proyecto/registro/pantalla_registro.dart';

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home, size: 65,),  
              SizedBox(height: 10),
              Text("Bienvenido",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
              ),

              
              
              SizedBox(height: 50),
              Text("¿Ya tiene una cuenta?",
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 15,
              ),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                  backgroundColor: Colors.black
                ),
                onPressed: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context)=> PantallaLogin()),
                    );
                  },
                child: Text("Iniciar Sesión",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                ),
                ),

              SizedBox(height: 40),
              Text("¿No tiene cuenta?",
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 15,
              ),
              ),


              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 41, vertical: 12),
                  backgroundColor: Colors.black
                ),
                onPressed: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context)=> PantallaRegistro()),
                    );
                },
                child: Text("Registrarse",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
              ),
            ],
          ), ),
      )

    );
  }
}