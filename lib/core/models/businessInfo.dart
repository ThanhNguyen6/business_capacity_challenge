/// Represents the stats from the Firebase service
class Business {
  String id;
  String name;
  int capacity;
  //int count;

  Business({this.id, this.name, this.capacity});

  /*
  Business.fromSnapshot(DocumentSnapshot snapShot) :
        id = id ?? '',
        name = snapShot['name'] ?? 'Capacity Counter',
        capacity = snapShot['capacity'] ?? 20,
        count = snapShot['count'] ?? 0;

   */

  Business.fromMap(Map snapshot, String id):
        id = id ?? '',
        name = snapshot['name'] ?? 'Capacity Counter',
        capacity = snapshot['capacity'] ?? 20;
        //count = snapshot['count'] ?? 0;

  toJson() {
    return {
      "name": name,
      "capacity": capacity,
      //"count": count,
    };
  }
}