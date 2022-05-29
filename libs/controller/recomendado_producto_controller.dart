import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/repository/producto_recomendado_repo.dart';
import '../models/product_model.dart';



class RecomendadoProductoController extends GetxController{
  final RecomendadoProductoRepo recomendadoProductoRepo;
  RecomendadoProductoController({required this.recomendadoProductoRepo});
  List<dynamic> _recomendadoProductoList = [];
  List<dynamic>  get recomendadoProductoList => _recomendadoProductoList;

  bool _cargando = false;
  bool get cargando => _cargando;

  Future<void> getRecomendadoProductList() async{
    Response response = await recomendadoProductoRepo.getRecomendadoProductoList();
    if(response.statusCode == 200){
      //print("Tengo los productos");
      //¿Por que se inicializa la lista en null? Pues por que se puede duplicar
      _recomendadoProductoList = [];
      _recomendadoProductoList.addAll(Product.fromJson(response.body).products);
      //print(_popularProductoList);
      //Despues de llamar, hay que actualizar, es mas como un setState hacia la UI
      _cargando = true;
      update();
    }else{

    }
  }
}