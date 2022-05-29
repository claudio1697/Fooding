import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/carrito_repo.dart';
import '../models/carrito_model.dart';
import '../models/product_model.dart';
import '../utils/colors.dart';

class CarritoController extends GetxController {
  final CarritoRepo carritoRepo;

  CarritoController({required this.carritoRepo});

  Map <int, CarritoModel> _productos = {};

  Map<int, CarritoModel> get productos => _productos;

  /*
  * Solo para almacenamiedo de sharedPref
  * */
  List<CarritoModel> almacenProductos = [];

  //añadir al carrito
  //0, 1, 2...
  void addProd(ProductModel productModel, int cantidad) {
    var cantidadTotal = 0;
    if (_productos.containsKey(productModel.id!)) {
      _productos.update(productModel.id!, (value) {
        cantidadTotal = value.quantity! + cantidad;

        return CarritoModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + cantidad,
          isExist: true,
          time: DateTime.now().toString(),
          productModel: productModel,
        );
      });

      if (cantidadTotal <= 0) {
        _productos.remove(productModel.id);
      }
    } else {
      //print("tamaño de la lista de prod " + _productos.length.toString());
      if (cantidad > 0) {
        _productos.putIfAbsent(productModel.id!, () {
          //print("Producto añadido con id: " + productModel.id!.toString() + " cantidad " + cantidad.toString();
          return CarritoModel(
            id: productModel.id,
            name: productModel.name,
            price: productModel.price,
            img: productModel.img,
            quantity: cantidad,
            isExist: true,
            time: DateTime.now().toString(),
            productModel: productModel,
          );
        });
      } else {
        Get.snackbar("Contador", "Tienes que añadir al menos 1!",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }
    }
    carritoRepo.addToCarritoLista(getProductos);
    update();
  }

  //Comprobar si se añadio el producto o no al carrito
  bool existEnCarrito(ProductModel productModel) {
    if (_productos.containsKey(productModel.id)) {
      return true;
    }
    return false;
  }

  int getCantidad(ProductModel productModel) {
    var cantidad = 0;
    if (_productos.containsKey(productModel.id)) {
      _productos.forEach((key, value) {
        if (key == productModel.id) {
          cantidad = value.quantity!;
        }
      });
    }
    return cantidad;
  }

  int get totalProductos {
    var cantidadTotal = 0;
    _productos.forEach((key, value) {
      cantidadTotal += value.quantity!;
    });
    return cantidadTotal;
  }

  List<CarritoModel> get getProductos {
    return _productos.entries.map((e) {
      return e.value;
    }).toList();
  }

  //Calculo de lo que hay que pagar en total
  int get cantidadTotal {
    var total = 0;
    _productos.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CarritoModel> getCarritoData() {
    setCarrito = carritoRepo.getCarritoLista();

    return almacenProductos;
  }

  set setCarrito(List<CarritoModel> productos) {
    almacenProductos = productos;

    for (int i = 0; i < almacenProductos.length; i++) {
      _productos.putIfAbsent(almacenProductos[i].productModel!.id!,
              () => almacenProductos[i]);
    }
  }

  void addToHistorial() {
    carritoRepo.addToCarritoHistorialLista();
    clear();
  }

  void clear() {
    _productos = {};
    update();
  }

  List<CarritoModel> getCarritoHistorialLista(){
    return carritoRepo.getCarritoHistorialLista();
  }

  set setProductos(Map<int, CarritoModel> setProductos){
    _productos = {};
      _productos = setProductos;
  }

  void addToCarritoLista(){
    carritoRepo.addToCarritoLista(getProductos);
    update();
  }

}