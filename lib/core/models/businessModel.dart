class Business{
  String name;
  int capacity;
  Business({this.id, this.name, this.capacity});

  Business.fromMap(Map snapshot, String id):
      name = snapshot['name'] ?? 'Capacity Counter',
      capacity = snapshot['capacity'] ?? 10;
  toJson() {
    return {
      "name": name,
      "capacity": capacity,
    };
  }

}