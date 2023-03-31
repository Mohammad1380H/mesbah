import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrl_(String url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

Center loading() {
  return const Center(
    child: SizedBox(
        width: 100,
        height: 100,
        child: SpinKitSquareCircle(
          color: Colors.blue,
          size: 50.0,
        )),
  );
}
