import 'package:flutter/material.dart';
import 'package:gypsybook/homePage.dart';
import 'package:gypsybook/providers/world.dart';
import 'package:gypsybook/screens/add_continent_screen.dart';
import 'package:gypsybook/screens/add_country_screen.dart';
import 'package:gypsybook/screens/continent_description.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Worlds(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        routes: {
       EditCountryScreen.routeName:(context) => EditCountryScreen(),
           ContinentDescription.routeName: (ctx) => ContinentDescription(),
          EditContinentScreen.routeName: (ctx) => EditContinentScreen(),

        },
      ),
    );
  }
}
