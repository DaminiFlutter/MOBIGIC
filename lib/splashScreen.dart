import 'package:clubhouse/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
            }, child: Text("CLick Me"))
          ],
        ),
      ),
    );
  }
}
