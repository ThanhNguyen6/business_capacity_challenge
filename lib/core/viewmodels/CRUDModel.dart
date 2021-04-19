import 'dart:async';
import 'package:flutter/material.dart';
import '../../locator.dart';
import '../services/api.dart';
import '../models/businessInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<Business> businesses;

  Future<List<Business>> fetchBusinesses() async {
    var result = await _api.getDataCollection();
    businesses = result.docs
        .map((doc) => Business.fromMap(doc.data(), doc.id))
        .toList();
    return businesses;
  }

  Stream<QuerySnapshot> fetchBusinessesAsStream() {
    return _api.streamDataCollection();
  }

  Stream<DocumentSnapshot> fetchBusinessDocAsStream(String id) {
    return _api.streamDocument(id);
  }

  Future<Business> getBusinessById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  Business.fromMap(doc.data(), doc.id) ;
  }


  Future removeBusiness(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateBusiness(Business data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addBusiness(Business data) async{
    await _api.addDocument(data.toJson()) ;
    return ;

  }


}