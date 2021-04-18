import 'package:flutter/material.dart';
import 'package:opun_challenge/util/app_style.dart';

// TODO: save these values and use them in the home screen

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Settings', style: AppStyle.TITLE_TEXTSTYLE),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Max Capacity:',
                  style: AppStyle.BOLD_TEXTSTYLE,
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 100,
                  child: TextField(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Business Name:',
                  style: AppStyle.BOLD_TEXTSTYLE,
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 100,
                  child: TextField(),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('back'),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  child: Text('save'),
                  onPressed: () => print('save pressed'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
