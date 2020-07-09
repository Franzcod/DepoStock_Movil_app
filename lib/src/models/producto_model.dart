
import 'dart:convert';

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
    String posicion;
    String id;
    String producto;
    double cantidad;
    String lote;
    String presentacion;
    bool posControlada;

    ProductoModel({
        this.posicion = '',
        this.id,
        this.producto = '',
        this.cantidad = 0.0,
        this.lote = 'S/L',
        this.presentacion = 'S/C',
        this.posControlada = false,
    });

    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        posicion       : json["posicion"] ,
        id             : json["id"],
        producto       : json["producto"],
        cantidad       : json["cantidad"],
        lote           : json["lote"],
        presentacion   : json["presentacion"],
        posControlada  : json["posControlada"],
    );

    Map<String, dynamic> toJson() => {
        "posicion"      : posicion,
        "id"            : id,
        "producto"      : producto,
        "cantidad"      : cantidad,
        "lote"          : lote,
        "presentacion"  : presentacion,
        "posControlada" : posControlada,
    };
}
