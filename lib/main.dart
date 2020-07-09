
import 'package:deposito_11/src/pages/home_page.dart';
import 'package:deposito_11/src/pages/initial_page.dart';
import 'package:deposito_11/src/pages/pasillo_1_A.dart';
import 'package:deposito_11/src/pages/pasillo_1_B.dart';
import 'package:deposito_11/src/pages/pasillo_2_C.dart';
import 'package:deposito_11/src/pages/pasillo_2_D.dart';
import 'package:deposito_11/src/pages/sumar_prod.dart';
import 'package:flutter/material.dart';


void main() async {

  // final prefs = new PreferenciasUsuario();
  // await prefs.initPrefs();

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    // final prefs = new PreferenciasUsuario();
    // print( prefs.token );
    
    
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'initial',
        routes: {
          'initial'    : ( BuildContext context ) => InitialPage(),
          // 'registro' : ( BuildContext context ) => RegistroPage(),
          'home'      : ( BuildContext context ) => HomePage(),

          'pasillo1A' : ( BuildContext context ) => Pasillo1A(),
          'pasillo1B' : ( BuildContext context ) => Pasillo1B(),
          'pasillo2C' : ( BuildContext context ) => Pasillo2C(),
          'pasillo2D' : ( BuildContext context ) => Pasillo2D(),

          'sumar'     : ( BuildContext context ) => SumarProd(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      );
    
      
  }
}