import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../gen/assets.gen.dart';
import 'main_screen.dart';


class SplashScreen extends StatefulWidget {
  final Function toggleTheme;
  const SplashScreen({super.key, required this.toggleTheme});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000)).then(
      (value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => MainScreen(
                toggleTheme: widget.toggleTheme,
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: Assets.images.poster.provider()),
            SizedBox(
              height: size.height / 19,
            ),
            const SpinKitCircle(
              color: Colors.blue,
              size: 50.0,
            )
          ],
        ),
      )),
    );
  }
}
