import 'package:flutter/cupertino.dart';

class CHATSCREEN extends StatelessWidget {
  const CHATSCREEN({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'chat',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
