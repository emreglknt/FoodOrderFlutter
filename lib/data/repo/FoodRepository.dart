import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_final_project_food_order/data/entity/foodModel.dart';
import 'package:flutter_final_project_food_order/data/entity/foodResponse.dart';
import 'package:flutter_final_project_food_order/data/entity/sepetFoodModel.dart';
import 'package:flutter_final_project_food_order/data/entity/sepetFoodResponse.dart';


class FoodRepository {


  //alınan responstaki film objelerini ve success i birbirinde ayırır.
  //böylece objelerin bulunduğu listeye erişebiliriz.

  List<Food> parseFoods(String response) {
    return FoodResponse
        .fromJson(json.decode(response))
        .foods;
  }

  List<SepetFood> parseSepetFoods(String response) {
    return SepetFoodResponse
        .fromJson(json.decode(response))
        .sepetFoods;
  }

  // base url deki verileri get metodu ile getirir.
  // sonra response değişkeninin datasını string olarak parse etmek için fonksiyhona gönderir.
  // success ile yemek objeleir burada ayrılmak için gönderilir.
  Future<List<Food>> loadFoods() async {
    var baseUrl = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var response = await Dio().get(baseUrl);
    return parseFoods(response.data.toString());
  }


  Future<void> addChart(String foodname, String image, int fiyat, int adet, String kullanici_adi) async
  {
    var baseUrl = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {
      "yemek_adi": foodname,
      "yemek_resim_adi": image,
      "yemek_fiyat": fiyat,
      "yemek_siparis_adet": adet,
      "kullanici_adi": kullanici_adi
    };
    var response = await Dio().post(baseUrl, data: FormData.fromMap(veri));
  }


  Future<List<SepetFood>> loadSepetFoods(String kullaniciAdi) async {
    var baseUrl = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi": kullaniciAdi};
    var response = await Dio().post(baseUrl, data: FormData.fromMap(veri));
    return parseSepetFoods(response.data.toString());
  }



  //DELETE
  Future<void> deleteFood(int sepetfoodId,String kullanici) async{
    var baseurl = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {"sepet_yemek_id":sepetfoodId,"kullanici_adi":kullanici};
    var response = await Dio().post(baseurl,data: FormData.fromMap(veri));

  }






}