import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/data/db_helper.dart';
import 'package:todo/ui/home_page.dart';
import 'package:todo/ui/splash.dart';

void main() {
  runApp(BlocProvider(create: (context)=>TodoCubit(dbHelper: DbHelper.getInstance()),child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

