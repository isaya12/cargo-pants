class ParcelBranch {
  final int id;
  final String name;

  ParcelBranch({required this.id, required this.name});

  factory ParcelBranch.fromJson(Map<String, dynamic> json) {
    return ParcelBranch(
      id: json['id'],
      name: json['name'],
    );
  }
}
