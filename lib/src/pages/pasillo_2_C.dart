import 'package:flutter/material.dart';


class Pasillo2C extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //Controlar si se puede volver para atras y se mantienen los datos
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){Navigator.pushNamed(context, 'home');}),
          title: Text('Pasillo 2 - Lado C'),
          backgroundColor: Color.fromRGBO(255, 164, 0, 1),
        ),
        
        body: GridView.count(
          
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 5.0,
          scrollDirection: Axis.horizontal,
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 4,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(60, (index) {
            return Container(
              child: Center(child: Text('C $index - ', style: TextStyle(fontSize: 30.0),)),
              decoration: BoxDecoration(
                color:  Colors.red[200],
                border: Border.all(
                  color: Color.fromRGBO(5, 112, 198, 1),
                  width: 8,
                ),
                borderRadius: BorderRadius.circular(0),
                
              ),
              
            );
          }
        ),
        ),
      );
    
  }
}
