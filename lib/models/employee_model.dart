class Employee {
  String name;
  String status;
  String time;
  String address;
  double speed;
  int battery;
  double latitude;
  double longitude;

  Employee({
    required this.name,
    required this.status,
    required this.time,
    required this.address,
    required this.speed,
    required this.battery,
    required this.latitude,
    required this.longitude,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['name'] ?? '',
      status: json['status'] ?? 'Offline',
      time: json['time'] ?? '',
      address: json['address'] ?? '',
      speed: (json['speed'] ?? 0).toDouble(),
      battery: json['battery'] ?? 0,
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status,
      'time': time,
      'address': address,
      'speed': speed,
      'battery': battery,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
