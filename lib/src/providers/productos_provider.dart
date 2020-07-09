import 'dart:convert';

import 'package:deposito_11/src/models/producto_model.dart';
import 'package:http/http.dart' as http;

// el encargado de la interaccion con la base de datos firebase!!!!

class ProductosProvider{

  //url de base de de datos de firebase (raiz)
  final String _url = 'https://deposito-2ac44.firebaseio.com';

  //depositoprobusol@gmail.com
  //deposito1234


  // database firebase Franzcod:
  //https://deposito05-20.firebaseio.com


  Future<bool> crearProducto(ProductoModel producto) async{

    final url = '$_url/productos.json';
    
    //postear
    final resp = await  http.post(url, body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);

    print(decodedData);
    return true;
    

  }

  //para mostrar lo de firebase en la lista del home!
  Future<List<ProductoModel>> cargarProductos() async{

    final url = '$_url/productos.json';
    final resp = await http.get(url);


    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<ProductoModel> productos = new List();

    if(decodedData == null) return [];


    //forEach para recorrer la respuesta Json de Firebase completo
    decodedData.forEach( (id,prod) {
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;

      productos.add(prodTemp);
    });

    return productos;

  }

  //funcion para borrar Producto del firebase database

  Future<int> borrarProducto(String id) async{

    final url = '$_url/productos/$id.json';
    final resp = await http.delete(url);

    print(resp.body);

    return 1;
  }


  //VAciar deposito????????
  Future<int> vaciarDeposito() async{

    final url = '$_url/productos.json';
    final resp = await http.delete(url);

    print(resp.body);

    return 1;
  }


  Future<bool> editarProducto(ProductoModel producto) async{

    final url = '$_url/productos/${producto.id}.json';
    
    //postear
    final resp = await  http.put(url, body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);

    print(decodedData);
    return true;
    

  }





  
}