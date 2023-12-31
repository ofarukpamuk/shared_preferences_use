import 'package:flutter/material.dart';


import 'package:shared_preferences_use/services/stroge_service.dart';
import 'package:shared_preferences_use/shared_pref_page.dart';
import 'package:get_it/get_it.dart';
import 'services/secure_storge.dart';
import 'services/shared_pref_services.dart';

final storge = GetIt.instance;

void setup() {
 // storge.registerSingleton<StorgeServices>(SharedPrefService());
  storge.registerLazySingleton<StorgeServices>(()=>SharedPrefService());
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const MyApp());
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ana Sayfa")),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StorgePage(),
              ));
            },
            child: const Text("Shared pref page button"),
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.red.shade400)),
      ),
    );
  }
}
