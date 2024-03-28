

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project_food_order/data/entity/foodModel.dart';
import 'package:flutter_final_project_food_order/data/repo/FoodRepository.dart';

class HomePageCubit extends Cubit<List<Food>>{


  HomePageCubit():super(<Food>[]);

  var fRepo = FoodRepository();

  Future<void> loadFoods()async{
    var fList = await fRepo.loadFoods();
    emit(fList);// repodan gelen food türündeki listeyi arayüz sınıfına gönderir.
  }



}