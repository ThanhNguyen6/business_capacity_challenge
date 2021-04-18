import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

/// Represents the stats from the Firebase service
class Business extends ChangeNotifier {
  String id;
  String name;
  int capacity;
  int count;

  Business({this.id, this.name, this.capacity, this.count});

  Business.fromMap(Map snapshot, String id) {
    this.id = id ?? '';
    name = snapshot['name'] ?? 'Capacity Counter';
    capacity = snapshot['capacity'] ?? 20;
    count = snapshot['count'] ?? 0;
    //notifyListeners();
  }


  void businessCapacity(int cap) {
    capacity = cap;
    notifyListeners();
  }

  //String get businessName => name;
  //int get businessCapacity => capacity;

  toJson() {
    return {
      "name": name,
      "capacity": capacity,
      "count": count,
    };
  }

  void businessName(String title) {
    name = title;
    notifyListeners();
  }

  void businessCount(int c) {
    count = c;
    notifyListeners();
  }
}