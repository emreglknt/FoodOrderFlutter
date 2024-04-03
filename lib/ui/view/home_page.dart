import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project_food_order/data/entity/foodModel.dart';
import 'package:flutter_final_project_food_order/ui/cubits/HomePageCubit.dart';
import 'package:flutter_final_project_food_order/ui/view/details_page.dart';
import 'package:flutter_final_project_food_order/ui/view/login.dart';
import 'package:flutter_final_project_food_order/ui/view/spet_page.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final String username;


  HomePage(this.username);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.white),
          onPressed: _showLogoutDialog,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SepetPage(widget.username)),
              );
            },
            icon: Icon(Icons.shopping_cart, size: 30, color: Colors.white),
          ),
        ],
      ),
      body: Stack(
        children: [
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
                          MaterialPageRoute(builder: (context) => DetailsPage(food: food,username: widget.username,)),
                        ).then((value) {
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


  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Çıkış"),
          content: Text("Çıkmak istediğinize emin misiniz?"),
          actions: <Widget>[
            TextButton(
              child: Text("Hayır"),
              onPressed: () {
                Navigator.of(context).pop(); // Diyalogu kapat
              },
            ),
            TextButton(
              child: Text("Evet"),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false); // isLoggedIn'i false olarak ayarla
                Navigator.of(context).pop(); // Diyalogu kapat
                Navigator.pushReplacement( // LoginPage'e yönlendir
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }



}
