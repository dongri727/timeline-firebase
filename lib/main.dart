import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:timeline_firebase/timeline/timeline.dart';
import 'bloc_provider.dart';
import 'menu/menu.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      platform: Theme.of(context).platform,
      t: Timeline(Theme.of(context).platform),
      child: MaterialApp(
        title: 'Timeline-Firebase',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const MenuPage(),
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: null,
      body: MainMenuWidget());
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}
