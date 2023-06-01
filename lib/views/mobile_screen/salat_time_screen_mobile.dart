import 'package:flutter/material.dart';

class SalatTimeScreenMobile extends StatefulWidget {
  const SalatTimeScreenMobile({Key? key}) : super(key: key);

  @override
  State<SalatTimeScreenMobile> createState() => _SalatTimeScreenMobileState();
}

class _SalatTimeScreenMobileState extends State<SalatTimeScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Salat Time Screen'),),
    );
  }
}
