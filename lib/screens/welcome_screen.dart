import 'package:flutter/material.dart';
import 'package:opun_challenge/util/app_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../core/viewmodels/CRUDModel.dart';

//TODO: improve design of the welcome screen

class WelcomeScreen extends StatelessWidget {
  final String title;
  WelcomeScreen({this.title});

  static const double IMAGE_WIDTH = 350;
  static const double IMAGE_HEIGHT = 230;

  @override
  Widget build(BuildContext context) {
    //final businessProvider = Provider.of<CRUDModel>(context);
    //final business = await businessProvider.getBusinessById('test');
    return Scaffold(
      backgroundColor: Color.fromARGB(240, 227, 245, 239),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image(
                    image: AssetImage('assets/opun_rectangle.png'),
                    width: IMAGE_WIDTH,
                    height: IMAGE_HEIGHT,
                    fit: BoxFit.cover),
                Positioned(
                  // The Positioned widget is used to position the text inside the Stack widget
                  bottom: 95,
                  left: 120,

                  child: Container(
                    child: Text(
                      'Welcome',
                      style: GoogleFonts.yesevaOne(
                        textStyle: TextStyle(color: Color(0xFF650C2A), fontWeight: FontWeight.bold, fontSize: 40.0),
                      ), // style
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text('To $title', style: GoogleFonts.yesevaOne(
              textStyle: TextStyle(color: Color(0xFF650C2A), fontWeight: FontWeight.bold, fontSize: 30.0),
            ), //child
            ),
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'The CDC recommends businesses operate at a reduced capacity during the pandemic to minimize the risk of transmitting Covid-19. '
                    'Please exercise caution and wait to enter if you are asked.',
                style: GoogleFonts.yanoneKaffeesatz(
                  textStyle: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
                ), //google.fonts
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'By working together we can keep our communities healthy, happy, and safe!',
                style: GoogleFonts.yanoneKaffeesatz(
                  textStyle: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
                ), //google.fonts
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Thank you!',
                style: GoogleFonts.yanoneKaffeesatz(
                  textStyle: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
                ), //google.fonts
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              child: Text('continue'),
              onPressed: () => Navigator.pushNamed(context, '/home'),
            )
          ],
        ),
      ),
    );
  }
}
