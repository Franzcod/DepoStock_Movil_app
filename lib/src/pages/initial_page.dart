import 'package:flutter/material.dart';



class InitialPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Stack( // <-- STACK AS THE SCAFFOLD PARENT
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/probusol2.png"), // <-- BACKGROUND IMAGE
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent, // <-- SCAFFOLD WITH TRANSPARENT BG
          appBar: AppBar(
            //title: Text('NEW USER'),
            backgroundColor: Colors.transparent, // <-- APPBAR WITH TRANSPARENT BG
            elevation: 0, // <-- ELEVATION ZEROED
          ),
          body: Padding(
            padding: EdgeInsets.all(100.0),
            
            child: Column(
              children: [
                SizedBox(height: 400.0,),
                SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    padding: EdgeInsets.all(20.0),
                    color: Color.fromRGBO(255, 164, 0, 1),
                    child: Text('Abrir Contador', style: TextStyle(color: Colors.white, fontSize: 25.0)),
                    onPressed: ()=> Navigator.pushReplacementNamed(context, 'home'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}