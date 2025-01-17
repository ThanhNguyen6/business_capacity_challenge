import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opun_challenge/util/app_style.dart';
import 'package:provider/provider.dart';
import '../core/viewmodels/CRUDModel.dart';
import '../core/models/businessInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
// TODO: save these values and use them in the home screen


class SettingsScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  String capacityValidator(String value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    var n = num.tryParse(value);
    if (n < 0) {
      return 'Capacity < 0';
    }
    if (n > 99) {
      return 'Capacity > 99';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    String tempTitle;
    String tempCapacity;
    final crudProvider = Provider.of<CRUDModel>(context);
    return StreamBuilder<DocumentSnapshot>(
        stream: crudProvider.fetchBusinessDocAsStream('test'),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading");
          }
          String title = snapshot.data.data()['name'];
          var capacity = snapshot.data.data()['capacity'];
          var currentCount = snapshot.data.data()['count'];

          return Scaffold(
            backgroundColor: Color.fromARGB(240, 227, 245, 239),
            body: Center(
              child: Form(
                key:_formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                          child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: capacityValidator,
                              onSaved: (value) => tempCapacity = value
                          ),
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
                          child: TextFormField(
                            onSaved: (value) => tempTitle = value,
                          ),
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
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              if (tempTitle != null && tempTitle.isNotEmpty) {
                                title = tempTitle;
                              }
                              if (tempCapacity != null && tempCapacity.isNotEmpty) {
                                capacity = num.tryParse(tempCapacity);
                                if (capacity < currentCount) {
                                  currentCount = 0;
                                }
                              }
                              await crudProvider.updateBusiness(Business(name:title, capacity: capacity, count: currentCount), 'test');
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                text: "Completed successfully! If there is no input information, nothing is changed",
                              );
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });

  }
}
