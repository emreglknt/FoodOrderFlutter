import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project_food_order/ui/cubits/DetailsPageCubit.dart';
import 'package:flutter_final_project_food_order/ui/cubits/HomePageCubit.dart';
import 'package:flutter_final_project_food_order/ui/cubits/SepetPageCubit.dart';
import 'package:flutter_final_project_food_order/ui/view/home_page.dart';
import 'package:flutter_final_project_food_order/ui/view/splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Flutter binding'lerini başlat.
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers:[
          BlocProvider(create: (context)=>HomePageCubit()),
          BlocProvider(create: (context)=> DetailsPageCubit()),
          BlocProvider(create: (context)=> SepetPageCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(

            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home:  SplashScreen(),
        ),

    );
  }
}