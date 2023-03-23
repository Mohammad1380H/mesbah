import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mesbah/view/splash_screen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'component/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = 'NM4UoblcwHGZJtm0JHGl1FetaNh3nEJlD13A3obm';
  const keyClientKey = 'Dc5l6sIaGkQJCIMe2nsehHvxTIRVNBDW7jnljVEW';
  const keyParseServerUrl = 'https://parseapi.back4app.com';
  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;
  // This widget is the root of your application.
  toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mesbah',
      locale: const Locale('fa'),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: SplashScreen(
        toggleTheme: toggleTheme,
      ),
    );
  }
}
