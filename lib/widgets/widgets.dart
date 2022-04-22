import 'package:flutter/material.dart';

class FondoApp extends StatelessWidget {
  const FondoApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/fondo.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
