class SepetFood{



  int sepetfoodId;
  String sepetfoodName;
  String sepetfoodImage;
  int sepetfoodPrice;
  int sepetfoodadet;
  String kullanici;

  SepetFood(
      { required this.sepetfoodId,
        required this.sepetfoodName,
        required this.sepetfoodImage,
        required this.sepetfoodPrice,
        required this.sepetfoodadet,
        required this.kullanici});


// jsondan gelen veri formatına uygun olarak hazırlandı
  factory SepetFood.fromJson(Map<String, dynamic> json) {
    return SepetFood(
      sepetfoodId: int.parse(json["sepet_yemek_id"]),
      sepetfoodName: json["yemek_adi"],
      sepetfoodImage: json["yemek_resim_adi"],
      sepetfoodPrice: int.parse(json["yemek_fiyat"]),
        sepetfoodadet: int.parse(json["yemek_siparis_adet"]),
        kullanici : json["kullanici_adi"],
    );
  }




}