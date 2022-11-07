import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with TickerProviderStateMixin  {

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stopAnimation();

  }
  stopAnimation()async{
    await Future.delayed(Duration(seconds: 4)).then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (Context) => LoginPage())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: FadeTransition(opacity: _animation,
              child: SvgPicture.network("https://mobigic.com/img/mobigic_logo.svg",width: 200,height: 200,))
            ),
          ],
        ),
      ),
    );
  }
}

