
import 'package:deposito_11/src/models/producto_model.dart';
import 'package:deposito_11/src/providers/productos_provider.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      //MENU LATERAL CANCELADO
      // drawer: navDrawer(context),
      appBar: AppBar(
        actions: <Widget>[
        
        IconButton(
          icon:Icon(Icons.delete_forever) , 
          onPressed: () async{
            final bool res = await showDialog(
              
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.redAccent,
                  content: Container(
                    color: Colors.redAccent,
                    height: 200.0,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.cancel, color: Colors.yellow, size: 120,),
                        // FlutterLogo(size: 120,colors: Colors.red,),
                        SizedBox(height: 10.0),
                        Text(
                            "Estas MUY seguro de vaciar el deposito ?",
                            style: TextStyle(color: Colors.white,fontSize: 20.0)),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    
                    FlatButton(
                      child: Text(
                        "Cancelar",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text(
                        'Vaciar',
                        style: TextStyle(color: Colors.yellow, fontSize: 20.0),
                      ),
                      onPressed: () {
                        // Metodo que vacia el deposito
                        productosProvider.vaciarDeposito();
                        
                        
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
          return res;
          }
        )
      ],
        backgroundColor: Color.fromRGBO(255, 164, 0, 1),
        title: Text('Deposito de terminados'),
      ),


      //LISTADO DE CONTEOS
      body: _crearListado(),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 1,
        color: Colors.transparent,
        child: Container(height: 40.0),
      ),
      floatingActionButton: _crearBoton( context ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      

    );
  }

  Widget _crearListado() {

    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if ( snapshot.hasData ) {

          final productos = snapshot.data;

          return ListView.separated(
            itemCount: productos.length,
            
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: 5.0,color: Colors.black);
            },
            itemBuilder: (context, i) => _crearItem(context, productos[i] ),
          );

        } else {
          return Center( child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto ) {

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: slideRightBackground(),
      confirmDismiss: (direccion) async {
        if (direccion == DismissDirection.endToStart) {
          final bool res = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Container(
                    height: 200.0,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.cancel, color: Colors.red, size: 120,),
                        // FlutterLogo(size: 120,colors: Colors.red,),
                        SizedBox(height: 10.0),
                        Text(
                            "Estas seguro de eliminar este producto ?",
                            style: TextStyle(color: Colors.black,fontSize: 20.0)),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    
                    FlatButton(
                      child: Text(
                        "Cancelar",
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                      onPressed: () {
                        
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text(
                        "Eliminar",
                        style: TextStyle(color: Colors.red, fontSize: 20.0),
                      ),
                      onPressed: () {
                        
                        productosProvider.borrarProducto(producto.id);
                        
                        Navigator.pushNamed(context, 'home' ).then((value){
                          setState(() {
                          });
                        });
                        
                        
                      
                      },
                    ),
                  ],
                );
              });
          return res;
        } else {
          
        }
      },
      
      onDismissed: ( direccion ){
        productosProvider.borrarProducto(producto.id);
      },
      child: ListTile(
        leading: Image(image: AssetImage('assets/pallet2.png')),
        title: Text('${ producto.producto } - ', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        trailing: Text('${producto.cantidad}', style: TextStyle(fontSize: 20.0),),
        subtitle: Text( '${producto.lote}  - ${producto.presentacion}' , style: TextStyle(fontSize: 20.0)),
        
        onTap: () => Navigator.pushNamed(context, 'sumar', arguments: producto ).then((value){
          setState(() {
            
          });
        }),
      )
    );
  }

  Widget slideRightBackground() {
  return Container(
    color: Colors.red,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text(
            "Eliminar",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      alignment: Alignment.centerRight,
    ),
  );
}

  _crearBoton(BuildContext context) {
    return FloatingActionButton.extended(
      elevation: 20.0,
      label: Text("Agregar"),
      icon: Icon( Icons.add ),
      backgroundColor: Color.fromRGBO(13, 202, 99 , 1),
      onPressed: ()=> Navigator.pushNamed(context, 'sumar').then((value){
        setState(() {
          
        });
      }),
    );
  }
  //Menu lateral desactivado
  Widget navDrawer(BuildContext context){
  return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              '',
              style: TextStyle(color: Color.fromRGBO(255, 164, 0, 1), fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/initial-img.jpg'))),
          ),
          SizedBox(height: 20.0,),
          Divider(
            color: Colors.grey,
            height: 2,
            thickness: 2,
            indent: 2,
            endIndent: 0,
          ),
          ListTile(
            leading: Icon(Icons.apps),
            title: Text('Pasillo 1 - Lado A'),
            onTap: ()=> Navigator.pushReplacementNamed(context, 'pasillo1A'),
          ),
          Divider(
            color: Colors.grey,
            height: 2,
            thickness: 2,
            indent: 2,
            endIndent: 0,
          ),
          ListTile(
            leading: Icon(Icons.apps),
            title: Text('Pasillo 1 - Lado B'),
            onTap: () => Navigator.pushReplacementNamed(context, 'pasillo1B'),
          ),
          Divider(
            color: Colors.grey,
            height: 2,
            thickness: 2,
            indent: 2,
            endIndent: 0,
          ),
          ListTile(
            leading: Icon(Icons.apps),
            title: Text('Pasillo 2 - Lado C'),
            onTap: () => Navigator.pushReplacementNamed(context, 'pasillo2C'),
          ),
          Divider(
            color: Colors.grey,
            height: 2,
            thickness: 2,
            indent: 2,
            endIndent: 0,
          ),
          
          ListTile(
            leading: Icon(Icons.apps),
            title: Text('Pasillo 2 - Lado D'),
            onTap: () => Navigator.pushReplacementNamed(context, 'pasillo2D'),
          ),
          Divider(
            color: Colors.grey,
            height: 2,
            thickness: 2,
            indent: 2,
            endIndent: 0,
          ),
          SizedBox(height: 150.0,),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Salir'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}


