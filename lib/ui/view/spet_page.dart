import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project_food_order/data/entity/sepetFoodModel.dart';
import 'package:flutter_final_project_food_order/ui/cubits/SepetPageCubit.dart';
import 'package:lottie/lottie.dart';

class SepetPage extends StatefulWidget {
  const SepetPage({super.key});


  @override
  State<SepetPage> createState() => _SepetPageState();
}

class _SepetPageState extends State<SepetPage> {
  String kullanici = "emreG";
  @override
  void initState() {
    super.initState();
    context.read<SepetPageCubit>().loadSepetFoods(kullanici);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                BlocBuilder<SepetPageCubit, List<SepetFood>>(
                  builder: (context, sepetList) {
                    double totalAmount = 0;
                    sepetList.forEach((sepetFood){
                      totalAmount +=(sepetFood.sepetfoodadet * sepetFood.sepetfoodPrice);
                    });

                    if (sepetList.isNotEmpty) {
                      return Stack(
                        children: [
                          ListView.builder(
                            itemCount: sepetList.length,
                            itemBuilder: (context, index) {
                              var sepetfood = sepetList[index];
                              return Card(
                                color: Colors.white,
                                elevation: 5.0,
                                margin: const EdgeInsets.all(8.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: ListTile(
                                    leading: Image.network(
                                      'http://kasimadalan.pe.hu/yemekler/resimler/${sepetfood.sepetfoodImage}',
                                      width: 100,
                                      height: 150,
                                      fit: BoxFit.contain,
                                    ),
                                    title: Text(
                                      sepetfood.sepetfoodName,
                                      style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Fiyat: "
                                            '${sepetfood.sepetfoodPrice}₺',
                                          style: TextStyle(color: Colors.black, fontSize: 16,),
                                        ),
                                        Text(
                                          'Adet: ${sepetfood.sepetfoodadet}',
                                          style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          color: Colors.deepPurpleAccent,
                                          onPressed: () {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text("Are you sure want to delete ${sepetfood.sepetfoodName}"),
                                                  action:  SnackBarAction(
                                                    label: "Yes",
                                                    onPressed: (){
                                                      context.read<SepetPageCubit>().deleteFood(sepetfood.sepetfoodId);
                                                    },
                                                  ),
                                                )
                                            );
                                          },
                                        ),
                                        Text(
                                          '${sepetfood.sepetfoodadet * sepetfood.sepetfoodPrice} ₺',
                                          style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              color: Colors.white.withOpacity(0.15),
                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Toplam fiyatı burada gösterebilirsiniz
                                  Text(
                                    'Toplam: $totalAmount ₺',
                                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Sipariş Onayı"),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text("Siparişinizi onaylamak istediğinizden emin misiniz?"),
                                              ],
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(); // Dialog kapatma işlemi
                                                },
                                                child: Text(
                                                  "İptal",
                                                  style: TextStyle(color: Colors.red),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(); // Dialog kapatma işlemi

                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                          "Sipariş Onaylandı 😊 ",
                                                          style: TextStyle(fontSize: 18),
                                                        ),
                                                        content: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: <Widget>[
                                                            // Lottie animasyonu eklemek için bir Container kullanabilirsiniz
                                                            Container(
                                                              height: 200,
                                                              width: 200,
                                                              child: Lottie.asset(
                                                                'assets/animations/delivered.json',
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                            SizedBox(height: 16), // Boşluk ekleyelim
                                                            Text(
                                                              "Tahmini Teslim Süresi: 35 - 45 dakika",
                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                            ),
                                                          ],
                                                        ),
                                                        actions: <Widget>[
                                                          IconButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop(); // Dialog kapatma işlemi
                                                            },
                                                            icon: Icon(
                                                              Icons.check_circle,
                                                              color: Colors.deepPurple,
                                                              size: 50,
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );

                                                },
                                                child: Text(
                                                  "Onayla",
                                                  style: TextStyle(color: Colors.green),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.orange, // Arka plan rengini turuncu olarak ayarla
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13), // Köşeleri biraz daha az kavisli yap
                                      ),
                                    ),
                                    child: Text(
                                      'Sepeti Onayla',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),

                        ],
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'Sepetinizde ürün bulunmamaktadır.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                  },
                ),
                // Buraya eklenen widget, ListView'in üzerinde kalacak


              ],
            ),
          ),
        ],
      ),
    );
  }
}
