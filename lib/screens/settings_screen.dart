import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opun_challenge/util/app_style.dart';
import 'package:provider/provider.dart';
import '../core/viewmodels/CRUDModel.dart';
import '../core/models/businessInfo.dart';
// TODO: save these values and use them in the home screen


class SettingsScreen extends StatelessWidget {
  //final Business bInfo;
  //SettingsScreen({this.bInfo});
  final _formKey = GlobalKey<FormState>();

  String capacityValidator(String value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    var n = num.tryParse(value);
    if (n < 0) {
      return 'Capacity can be less than 0';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    String tempTitle;
    String tempCapacity;
    final crudProvider = Provider.of<CRUDModel>(context);
    final businessProvider = Provider.of<Business>(context);
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
                        //String title = bInfo.name;
                        //int capacity = bInfo.capacity;
                        String title = businessProvider.name ?? 'Capacity Counter';
                        int capacity = businessProvider.capacity ?? 20;
                        int currentCount = businessProvider.count ?? 0;
                        if (tempTitle != null && tempTitle.isNotEmpty) {
                          title = tempTitle;
                          businessProvider.businessName(tempTitle);
                        }
                        if (tempCapacity != null && tempCapacity.isNotEmpty) {
                          capacity = num.tryParse(tempCapacity);
                          businessProvider.businessCapacity(num.tryParse(tempCapacity));
                          if (capacity < currentCount) {
                            businessProvider.businessCount(0);
                          }
                        }
                        await crudProvider.updateBusiness(Business(name:title, capacity: capacity, count: currentCount), 'test');
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
  }
}
