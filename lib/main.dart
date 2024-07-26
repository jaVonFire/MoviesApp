import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/screens/screens.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => MoviesProvider(), lazy: false ) // Create the provider with LazyLoad, if without a instance, this will never be created 
      ],
      child: MyApp(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false, 
      title: 'Movies App',
      initialRoute: 'home',
      routes: {
        'home' : ( _ ) => const HomeScreen(),
        'details' : ( _ ) => const DetailsScreen(),
        'settings' : ( _ ) => const SettingsScreen(),
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme( 
          color: Colors.green, 
        ),
      )

    );
  }
}