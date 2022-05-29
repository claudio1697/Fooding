import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/producto_popular_repo.dart';
import '../models/carrito_model.dart';
import '../models/product_model.dart';
import '../utils/colors.dart';
import 'carrito_controller.dart';

class PopularProductoController extends GetxController{
  final PopularProductoRepo popularProductoRepo;
  PopularProductoController({required this.popularProductoRepo});
  List<dynamic> _popularProductoList = [];
  List<dynamic>  get popularProductoList => _popularProductoList;
  late CarritoController _carritoController;

  bool _cargando = false;
  bool get cargando => _cargando;

  int _cantidad = 0;
  int get cantidad => _cantidad;
  int _productoEnCarrito = 0;
  int get productoEnCarrito => _productoEnCarrito + _cantidad;

  Future<void> getPopularProductList() async{
    Response response = await popularProductoRepo.getPopularProductoList();
    if(response.statusCode == 200){
      //print("Tengo los productos");
      //¿Por que se inicializa la lista en null? Pues por que se puede duplicar
      _popularProductoList = [];
      _popularProductoList.addAll(Product.fromJson(response.body).products);
      //print(_popularProductoList);
      //Despues de llamar, hay que actualizar, es mas como un setState hacia la UI
      _cargando = true;
      update();
    }else{

    }
  }

  //METODOS SIGUIENTES SON REUSABLES
  void setQuantity(bool isIncrement){
    if(isIncrement){
      _cantidad = comprobarCantidad(_cantidad + 1);
      //print("Numero de productos " + _cantidad.toString());
    }else{
      _cantidad = comprobarCantidad(_cantidad - 1);
      //print("Restar " + _cantidad.toString());
    }
    update();
  }
  // _productoEnCarrito = 2;
  // _cantidad = 0;
  // _cantidad = -2;
  //
  comprobarCantidad(int cantidad){
    if((_productoEnCarrito + cantidad)<0){
      Get.snackbar("Contador", "No puedes reducir mas!",
      backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if(_productoEnCarrito>0){
        _cantidad = -_productoEnCarrito;
        return _cantidad;
      }
      return 0;
    }else if((_productoEnCarrito + cantidad)>20){
      Get.snackbar("Contador", "No puedes aumentar mas!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    }else{
      return cantidad;
    }
  }

  void initProducto(ProductModel productModel,CarritoController carritoController){
    _cantidad = 0;
    _productoEnCarrito = 0;
    _carritoController = carritoController;
    var exist = false;
    exist = _carritoController.existEnCarrito(productModel);
    //if exist
    //get from almacen _productoEnCarrito = 3
    //Print que comprueba si un producto existe o no en el carrito
    //print("Existe? " + exist.toString());
    if(exist){
      _productoEnCarrito = _carritoController.getCantidad(productModel);
    }
    //print("La cantidad en el carrito es " + _productoEnCarrito.toString());
  }

  void addProd(ProductModel productModel){
      _carritoController.addProd(productModel, _cantidad);
      _cantidad = 0;
      //Para evitar que se settee a 0 al darle a menos
      _productoEnCarrito = _carritoController.getCantidad(productModel);

      _carritoController.productos.forEach((key, value) {
        print("El id es " + value.id.toString() + " la cantidad es " + value.quantity.toString());
      });
    update();
  }

  int get totalProductos{
    return _carritoController.totalProductos;
  }
  List<CarritoModel> get getProductos{
    return _carritoController.getProductos;
  }
}