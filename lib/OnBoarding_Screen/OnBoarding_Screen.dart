import 'package:app/Login_Pages/main.dart';
import 'package:app/login_options.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  final bool showHome;

  const MyApp({
    Key? key,
    required this.showHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Voting System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: showHome ? MyHomePage(title: '') : OnBoardingScreen(showHome: showHome),
    );
  }
}

class OnBoardingScreen extends StatefulWidget {
  // for one time
  final bool showHome;
  const OnBoardingScreen({
    Key? key,
    required this.showHome,
}): super(key : key );
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 70),
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() => isLastPage = index == 2);
            },
            children: [
              Container(
                color: Colors.white,
             child:   Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/animations/P.json', height: 300),
                      Text('LOGIN PAKISTAN KI KHATIR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26,fontFamily: 'Mainn',),),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 350,
                        child: Text(
                             "Casting Your Digital Ballot for the Betterment of Our Nation's Future", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14), textAlign: TextAlign.center,),
                      ),

                    ],
                  ),
             ),

              Container(
                color: Colors.white,
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/animations/ID.json'),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text('KHIDMAT-E-MULK', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26,fontFamily: 'Mainn',),),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Strengthening Pakistan Through Digital Democracy", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14,),)
                  ],
                ),
              ),
              Container( child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Lottie.
                    asset('assets/animations/8.json', height: 200),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('ROSHAN-E-PAKISTAN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26,fontFamily: 'Mainn',),),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 350,
                    child: Text(
                      "Illuminating the Path to Progress Through E-Voting Solutions", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14,), textAlign: TextAlign.center,),
                  )
                ],
              ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: isLastPage
        ? TextButton(style: TextButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.blueAccent, minimumSize: Size.fromHeight(80)), child: Text('Get Started', style: TextStyle(fontSize: 24),),
      onPressed:() async {

          // for one time
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('showHome', true);
          // get started navigate to Home
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginOptionsPage()),);
      },
      )
      : Container(

        padding: const EdgeInsets.symmetric(horizontal: 0),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => controller.jumpToPage(2),
              child: Text(
                'SKIP',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: WormEffect(
                  spacing: 16,
                  dotColor: Colors.black,
                  activeDotColor: Colors.blueAccent,
                ),
                onDotClicked: (index) => controller.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeIn),
              ),
            ),
            TextButton(
              onPressed: () => controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut),
              child: Text(
                'NEXT',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
