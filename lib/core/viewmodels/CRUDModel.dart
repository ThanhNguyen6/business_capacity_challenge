import 'dart:async';
import 'package:flutter/material.dart';
import '../../locator.dart';
import '../services/api.dart';
import '../models/businessInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<Business> businesses;

  Future<List<Business>> fetchProducts() async {
    var result = await _api.getDataCollection();
    businesses = result.docs
        .map((doc) => Business.fromMap(doc.data(), doc.id))
        .toList();
    return businesses;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }

  Future<Business> getBusinessById(String id) async {
    var doc = await _api.getDocumentById(id);
    print(doc.data()['name']);
    return  Business.fromMap(doc.data(), doc.id) ;
  }


  Future removeProduct(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateProduct(Business data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addProduct(Business data) async{
    var result  = await _api.addDocument(data.toJson()) ;
    return ;

  }


}