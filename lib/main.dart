import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screen/Splash_Screen.dart';
import 'bloc/event_bloc.dart';
import 'bloc/search_bloc.dart';
import 'bloc/sign_up_bloc.dart';
import 'bloc/theme_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.    
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeBloc>(
            create: (_) => ThemeBloc(),
        child: Consumer<ThemeBloc>(builder: (_, mode, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<SignInBloc>(
                create: (context) => SignInBloc(),
              ),
           
               ChangeNotifierProvider<EventBloc>(
                create: (context) => EventBloc(),
              ), 
              ChangeNotifierProvider<SearchBloc>(
                create: (context) => SearchBloc(),
              ), 
            ],
            child: MaterialApp(
        title: 'Evente Admin',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
          );
        })
    
    );
  }
}