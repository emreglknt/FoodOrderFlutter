import 'package:flutter_final_project_food_order/data/entity/foodModel.dart';

class FoodResponse{


  List<Food> foods;
  int success;

  FoodResponse({required this.foods,required  this.success});


//gelen json verideki listeyi  yemekler ve success olarak ayırır.
  factory FoodResponse.fromJson(Map<String,dynamic> json){
    var foodsJsonArray = json["yemekler"] as List;
    var success = json["success"] as int;

    // jsondaki yemekler tagi altındaki  objeleri alıp listeye atar daha sonra bu objeler food nesnesine dönüşür
    var foods =  foodsJsonArray.map((jsonArrayObject) =>Food.fromJson(jsonArrayObject)).toList();

    return FoodResponse(foods: foods, success: success);

  }



}