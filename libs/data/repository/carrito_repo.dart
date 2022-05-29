import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/carrito_model.dart';
import '../../utils/app_constants.dart';

class CarritoRepo{
  final SharedPreferences sharedPreferences;
  CarritoRepo({required this.sharedPreferences});

  List<String> carrito = [];
  List<String> carritoHistorial = [];

  void addToCarritoLista(List<CarritoModel> carritoLista){
    //sharedPreferences.remove(AppConstants.CART_LIST);
    //sharedPreferences.remove(AppConstants.CART_HIST_LIST);
    var time = DateTime.now().toString();
    carrito = [];
    /*
    * Convertir objetos a String pk sharedPref solo accepta Strings
    * */
    carritoLista.forEach((element) {
      element.time = time;
      return carrito.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, carrito);
    //print(sharedPreferences.getStringList(AppConstants.CART_LIST));
  }

  List<CarritoModel> getCarritoLista(){
    List<String> carritos = [];
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
     carritos = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }
    List<CarritoModel> carritoLista = [];
    /*
    * List<Objeto> list = [
    * "objeto",
    * "objeto1,
    * "objeto3"
    * ]
    * */

    carritos.forEach((element)=>
        carritoLista.add(CarritoModel.fromJson(jsonDecode(element))));
    
    return carritoLista;
  }

  List<CarritoModel> getCarritoHistorialLista(){
    if(sharedPreferences.containsKey(AppConstants.CART_HIST_LIST)){
      carritoHistorial = [];
      carritoHistorial = sharedPreferences.getStringList(AppConstants.CART_HIST_LIST)!;
    }
    List<CarritoModel> carritoListaHistorial = [];

    carritoHistorial.forEach((element) =>
        carritoListaHistorial.add(CarritoModel.fromJson(jsonDecode(element))));

    return carritoListaHistorial;
  }

  void addToCarritoHistorialLista(){

    if(sharedPreferences.containsKey(AppConstants.CART_HIST_LIST)){
      carritoHistorial = sharedPreferences.getStringList(AppConstants.CART_HIST_LIST)!;

    }
    for(int i = 0; i < carrito.length; i++){
      carritoHistorial.add(carrito[i]);
    }
    removeCarrito();
    sharedPreferences.setStringList(AppConstants.CART_HIST_LIST, carritoHistorial);
    //print("Historial tamaño " + getCarritoHistorialLista().length.toString());
  }
  void removeCarrito(){
    carrito=[];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }
}