import 'package:flutter_final_project_food_order/data/entity/sepetFoodModel.dart';

class SepetFoodResponse{


  List<SepetFood> sepetFoods;
  int success;


  SepetFoodResponse({required this.sepetFoods,required  this.success});


  //gelen json verideki listeyi  yemekler ve success olarak ayırır.
  factory SepetFoodResponse.fromJson(Map<String,dynamic> json){
    var foodsJsonArray = json["sepet_yemekler"] as List;
    var success = json["success"] as int;

    // jsondaki yemekler tagi altındaki  objeleri alıp listeye atar daha sonra bu objeler food nesnesine dönüşür
    var foods =  foodsJsonArray.map((jsonArrayObject) =>SepetFood.fromJson(jsonArrayObject)).toList();

    return SepetFoodResponse(sepetFoods: foods, success: success);

  }



}