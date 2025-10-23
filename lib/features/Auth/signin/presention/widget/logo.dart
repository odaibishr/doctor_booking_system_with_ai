import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icons/logo-transparent.png',
      width: 180,
      height: 180,
    );
  }
}

