import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project_food_order/data/repo/FoodRepository.dart';

class DetailsPageCubit extends Cubit<void> {


  DetailsPageCubit():super(0);


  var fRepo = FoodRepository();


  Future<void> addChart(String foodname,String image,int fiyat,int adet,String kullanici_adi) async
  {
    await fRepo.addChart(foodname,image,fiyat,adet,"emreG");
  }


}