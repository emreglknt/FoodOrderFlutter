
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project_food_order/data/entity/sepetFoodModel.dart';
import 'package:flutter_final_project_food_order/data/repo/FoodRepository.dart';

class SepetPageCubit extends Cubit<List<SepetFood>>{


  SepetPageCubit():super(<SepetFood>[]);

  var fRepo = FoodRepository();

  Future<void> loadSepetFoods(String kullanici)async{
    var sepetList = await fRepo.loadSepetFoods("emreG");
    emit(sepetList);// repodan gelen food türündeki listeyi arayüz sınıfına gönderir.
  }



  Future<void> deleteFood(int sepetfoodId) async{
    await fRepo.deleteFood(sepetfoodId);
    await loadSepetFoods("emreG"); // silinen kişiyi arayüzde güncelleyerek kaldırmak için kullandık.
  }

}