class Food{


  int foodId;
  String foodName;
  String foodImage;
  int foodPrice;

  Food({required this.foodId,required  this.foodName,required  this.foodImage,required  this.foodPrice});



// jsondan gelen veri formatına uygun olarak hazırlandı
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      foodId: int.parse(json["yemek_id"]),
      foodName: json["yemek_adi"],
      foodImage: json["yemek_resim_adi"],
      foodPrice: int.parse(json["yemek_fiyat"]),
    );
  }


}