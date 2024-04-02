import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project_food_order/data/entity/foodModel.dart';
import 'package:flutter_final_project_food_order/ui/cubits/DetailsPageCubit.dart';
import 'package:flutter_final_project_food_order/ui/view/home_page.dart';
import 'package:flutter_final_project_food_order/ui/view/spet_page.dart';

class DetailsPage extends StatefulWidget {
  final Food food;

  DetailsPage({required this.food, Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    int totalPrice = widget.food.foodPrice * _quantity;
    String kullanici = "emreG";

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.food.foodName),
      ),
      body: Column(
        children: [
          Expanded(
            child: Card(
              elevation: 8.0,
              color: Colors.white,
              margin: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            "http://kasimadalan.pe.hu/yemekler/resimler/${widget.food.foodImage}",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 60,
                          bottom: 5,
                          child: Text(
                            widget.food.foodName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 60,
                          bottom: 5,
                          child: Text(
                            '${widget.food.foodPrice} ₺',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (_quantity > 1) {
                                _quantity--;
                              }
                            });
                          },
                          child: Icon(Icons.remove,color: Colors.white,),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            primary: Colors.deepPurple,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '$_quantity',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _quantity++;
                            });
                          },
                          child: Icon(Icons.add,color: Colors.white,),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            primary: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    '$totalPrice ₺',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // sepete eklemeyi çalıştırır. ürünleri sepete kayıt eder.
                    context.read<DetailsPageCubit>().addChart(widget.food.foodName,widget.food.foodImage,widget.food.foodPrice,_quantity,"emreG");
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Ürün Sepete Eklendi"),
                          content: Text(
                              "Başka bir ürün eklemek ister misiniz?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Geri gitme işlemi
                                Navigator.of(context).pop();
                              },

                              child: Text("Ürün Ekle"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SepetPage(),
                                  ),
                                );
                              },
                              child: Text("Sepete Git"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.shopping_cart, color: Colors.white),
                  label: Text(
                    'Sepete Ekle',
                    style: const TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
