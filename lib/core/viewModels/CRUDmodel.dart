import 'dart:async';
import 'package:flutter/material.dart';
import '../../locator.dart';
import '../services/api.dart';
import '../models/businessModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  late List<Business> _businesses;


  Future<List<Business>> fetchProducts() async {
    var result = await _api.getDataCollection();
    _businesses = result.documents
        .map((doc) => Business.fromMap(doc.data, doc.documentID))
        .toList();
    return _businesses;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }

  Future<Business> getInfoById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  Business.fromMap(doc.data, doc.documentID) ;
  }


  Future removeBusinessInfo(String id) async{
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