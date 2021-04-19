import 'package:flutter/foundation.dart';
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
  }


  toJson() {
    return {
      "name": name,
      "capacity": capacity,
      "count": count,
    };
  }

}