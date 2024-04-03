import 'package:flutter/material.dart';
import 'package:flutter_final_project_food_order/ui/view/home_page.dart';
import 'package:flutter_final_project_food_order/ui/view/login.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Eğer kullanıcı giriş yapmışsa HomePage'e, yapmamışsa LoginPage'e yönlendir
    if (isLoggedIn) {
      // Kullanıcı adını almak için ekstra bir adım
      final username = prefs.getString('username') ?? '';
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(username)),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      checkLoginStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Lottie.asset(
          'assets/animations/deliveranimation.json', // Animasyonunuzun yolu
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );

  }
}
