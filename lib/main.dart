import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleproject/Auth/authFetch.dart';
import 'package:sampleproject/getScreen.dart';
import 'package:sampleproject/screen/startScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences s1 = await SharedPreferences.getInstance();
  bool? getBage = s1.getBool('fetch') == null ? false : s1.getBool('fetch');
  String? idKey = s1.getString('key');
  // print('idkey ------------- ${idKey}');
  runApp(mainPage(
    bage: getBage == false
        ? StartScreen()
        : getScreen(
            idKey: idKey,
          ),
  ));
}

class mainPage extends StatefulWidget {
  Widget bage;
  mainPage({required this.bage});
  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: ((context) => Auth()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.red,
          ),
          scaffoldBackgroundColor: Colors.red[25],
        ),
        debugShowCheckedModeBanner: false,
        home: widget.bage,
      ),
    );
  }
}
