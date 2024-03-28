import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project_food_order/data/entity/foodModel.dart';
import 'package:flutter_final_project_food_order/ui/cubits/HomePageCubit.dart';
import 'package:flutter_final_project_food_order/ui/view/details_page.dart';
import 'package:flutter_final_project_food_order/ui/view/spet_page.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showAnimation = true;
  bool _loadingImages = true;

  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    context.read<HomePageCubit>().loadFoods();

    // SharedPreferences yükleniyor.
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
      });
    });

    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _showAnimation = false;
      });
    });

    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        _loadingImages = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Center(child: Text('Mutlu Göbekler', style: TextStyle(color: Colors.white))),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SepetPage()),
              );
            },
            icon: Icon(Icons.shopping_cart, size: 30,),
            color: Colors.white,
          ),
        ],
      ),
      body: Stack(
        children: [
          if (_showAnimation)
            Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: Lottie.asset(
                  'assets/animations/deliveranimation.json',
                  width: 400,
                  height: 400,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          BlocBuilder<HomePageCubit, List<Food>>(
            builder: (context, foodList) {
              if (foodList.isNotEmpty) {
                return GridView.builder(
                  itemCount: foodList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.4,
                  ),
                  itemBuilder: (context, index) {
                    var food = foodList[index];

                    bool isFavorited = _prefs.getBool('favorited_$index') ?? false;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailsPage(food: food)),
                        ).then((value) {
                          print("Returned to home page");
                        });
                      },
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Card(
                          elevation: 6.0,
                          margin: const EdgeInsets.all(6.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                image: AssetImage("assets/foodpattern.jpg"),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _loadingImages
                                        ? CircularProgressIndicator()
                                        : Image.network(
                                      "http://kasimadalan.pe.hu/yemekler/resimler/${food.foodImage}",
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      color: Colors.white.withOpacity(0.4),
                                      margin: const EdgeInsets.all(12.0),
                                      padding: EdgeInsets.all(2.0),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '${food.foodName}',
                                            style: const TextStyle(color: Colors.deepPurple, fontSize: 18),
                                          ),
                                          Text(
                                            '${food.foodPrice} ₺',
                                            style: const TextStyle(color: Colors.deepPurple, fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 2,
                                  right: 2,
                                  child: IconButton(
                                    icon: Icon(
                                      isFavorited ? Icons.favorite : Icons.favorite_border,
                                      color: isFavorited ? Colors.red : null,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isFavorited = !isFavorited;
                                        _prefs.setBool('favorited_$index', isFavorited);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center();
              }
            },
          ),
        ],
      ),
    );
  }
}
