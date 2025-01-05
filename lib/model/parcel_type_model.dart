class ParcelType {
  final int id;
  final String name;

  ParcelType({required this.id, required this.name});

  factory ParcelType.fromJson(Map<String, dynamic> json) {
    return ParcelType(
      id: json['id'],
      name: json['name'],
    );
  }
}
