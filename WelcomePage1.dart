import 'package:flutter/material.dart';


class WelcomePage1 extends StatelessWidget {
  String province;
    WelcomePage1({ Key? key, required this.province }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(

      child: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Province_id: $province'),
          ],
        ),
      ),
    ),
    );
  }
}
