import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_project_food_order/ui/view/details_page.dart';
import 'package:flutter_final_project_food_order/ui/view/home_page.dart';
import 'package:flutter_final_project_food_order/ui/view/register.dart';
import 'package:flutter_final_project_food_order/user_auth_firebase/firebase_auth_methods.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Auth objesi ile login ve register service methodlarına ulaşabiliriz.
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/foodpattern.jpg"),
            fit: BoxFit.cover,
            opacity: 0.20, // Resmi kaplayacak şekilde ayarla ve opaklık
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Welcome başlığı
              Text(
                "Welcome to Mutlu Göbekler \nPlease Login",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(5.0, 5.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              // E-posta giriş alanı
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email, color: Colors.deepPurple),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.9),
                ),
              ),
              SizedBox(height: 20),
              // Şifre giriş alanı
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Colors.deepPurple),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.9),
                ),
              ),
              SizedBox(height: 40),
              // Login butonu
              Container(
                height: 50, // Butonun yüksekliği
                width: 100, // Butonun genişliği
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), // Yuvarlak köşeler
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepPurple, // Gradient'in başlangıç rengi
                      Colors.purple // Gradient'in bitiş rengi
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: InkWell(
                  onTap: login, // Butona tıklandığında çağrılacak fonksiyon
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Kayıt olma sayfasına yönlendirme
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    try {
      User? user = await _auth.signInWithEmailAndPassword(email, password);
      if (user != null) {
        Fluttertoast.showToast(msg: "User logged in successfully.");

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);


        String username = email.split('@').first;
        await prefs.setString('username', username);




        // Kullanıcıyı HomePage'e username ile birlikte yönlendir
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(username)),
        );
      } else {
        Fluttertoast.showToast(msg: "Email or password incorrect.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
