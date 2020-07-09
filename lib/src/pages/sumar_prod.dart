import 'package:deposito_11/src/models/producto_model.dart';
import 'package:deposito_11/src/providers/productos_provider.dart';
import 'package:deposito_11/src/utils/utils.dart' as utils;
import 'package:flutter/material.dart';


class SumarProd extends StatefulWidget {

  @override
  _SumarProdState createState() => _SumarProdState();
}

class _SumarProdState extends State<SumarProd> {


  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productoProvider = new ProductosProvider();

  ProductoModel producto = new ProductoModel();
  bool _guardando = false;

  @override
  Widget build(BuildContext context) {

    //para saber si precione un elemento coon datos del Home
    //Toma el argumento SI VIENE
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;

    if(prodData!=null){
      producto = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 164, 0, 1),
        title: Text('Nuevo '),
        actions: <Widget>[
          IconButton(
            icon:  Image(image: AssetImage('assets/code.png')),
            onPressed: (){
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _crearPosicion(),
                SizedBox(height: 20.0),                  
                _crearNombre(),
                SizedBox(height: 20.0),                   
                _crearCantidad(),
                SizedBox(height: 20.0),
                _crearLote(),
                SizedBox(height: 20.0),
                _crearPresentacion(),
                SizedBox(height: 50.0),
                // _crearDisponible(),
                // SizedBox(height: 20.0),
                _crearBoton(),
                
              ],
            ),
          ),
        ),
      ),
    );
  }


Widget _crearPosicion(){
  return TextFormField(
      initialValue: producto.posicion,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Posicion'
      ),
      onSaved: (value) {
        final  valor = value.toUpperCase();
        producto.posicion = valor;
      },
      // onSaved: (value) => producto.titulo = value,
      validator: (value) {

        RegExp expReg = RegExp(r"([a-dA-D]-[1-4]-((?=1[0-9])|(?=2[0-3])|([0-9]$)))|(pasillo(?=1|2))");

        final caca = value;

        if (  !expReg.hasMatch(caca) ) {
          return 'Ingrese posicion existente (ej. "A-4-23" o "pasillo1")';
        } else {
          return null; 
          
        }
        
      },
    );

}


  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.producto,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      onSaved: (value) => producto.producto = value,
      // onSaved: (value) => producto.titulo = value,
      validator: (value) {
        if ( value.length < 3 ) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearCantidad() {
    return TextFormField(
      initialValue: producto.cantidad.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      decoration: InputDecoration(
        labelText: 'Cantidad'
      ),
      onSaved: (value) => producto.cantidad = double.parse(value),
      validator: (value){
        if(utils.isNumeric(value)){
          return null;
        }else{
          return 'Solo numeros';
        }
      },
      
      
    );
  }



  Widget _crearLote(){
    return TextFormField(
      initialValue: producto.lote,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Lote'
      ),
      onSaved: (value) => producto.lote = value,
      validator: (value){
        if ( value.length<=0 ) {
          return 'Ingrese el Lote';
        } else {
          return null;
        }
      },
      
      
    );
  }

  Widget _crearPresentacion() {

    return TextFormField(
      initialValue: producto.presentacion,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'presentacion'
      ),
      onSaved: (value) => producto.presentacion = value,
      validator: (value) {
        if ( value.length < 3 ) {
          return 'Ingrese presentacion';
        } else {
          return null;
        }
      },
    );

  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color:  Color.fromRGBO(255, 164, 0, 1),
      elevation: 10,
      textColor: Colors.white,
      label: Text('Agregar', style: TextStyle(fontSize: 25),),
      icon: Icon( Icons.system_update_alt ),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit(){

    //Si no es valido
    if( !formKey.currentState.validate() ) return ;

    formKey.currentState.save();
    //si si es valido:
    
    setState(() { _guardando=true; });
    
    if(producto.id == null){
      productoProvider.crearProducto(producto);

    } else{
      productoProvider.editarProducto(producto);
    }
    // setState(() { _guardando=false; });
    mostrarSnackbar('Producto agregado');

    // Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje){
    final snackbar = SnackBar(

      backgroundColor: Colors.green,
      content: Text(mensaje, style: TextStyle(fontSize: 20.0)),
      duration: Duration(milliseconds: 1500),
    );


    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  /*
  Widget _crearDisponible() {

    return SwitchListTile(
      title: const Text('Posicion Controlada'),
      value: producto.posControlada,
      activeColor: Colors.green,
      inactiveThumbColor: Colors.red,
      onChanged: (value)=> setState((){
        producto.posControlada=value;
      }),
      
    );

  }
  */





}