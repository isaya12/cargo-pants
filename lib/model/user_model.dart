class User {
  final String fullname;
  final String phone;
  final int role;
  final String roleName;
  final String avatar;
  final String phone1;
  final String username;
  final String branchName;
  final String branchDistrict;
  final String branchImage;
  final String branchLocation;
  final String branchRegion;
  final int branchId;
  final int companyId;
  final String companyName;
  final String companyLabel;
  final String companyLogo;

  User({
    required this.fullname,
    required this.phone,
    required this.role,
    required this.roleName,
    required this.avatar,
    required this.phone1,
    required this.username,
    required this.branchName,
    required this.branchDistrict,
    required this.branchImage,
    required this.branchLocation,
    required this.branchRegion,
    required this.branchId,
    required this.companyId,
    required this.companyName,
    required this.companyLabel,
    required this.companyLogo,
  });

  // Factory constructor to create a User instance from a JSON object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullname: json['fullname'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? 0,
      roleName: json['role_name'] ?? '',
      avatar: json['avator'] ?? '',
      phone1: json['phone1'] ?? '',
      username: json['username'] ?? '',
      branchName: json['branch_name'] ?? '',
      branchDistrict: json['branch_district'] ?? '',
      branchImage: json['branch_image'] ?? '',
      branchLocation: json['branch_location'] ?? '',
      branchRegion: json['branch_region'] ?? '',
      branchId: json['branch_id'] ?? 0,
      companyId: json['company_id'] ?? 0,
      companyName: json['company_name'] ?? '',
      companyLabel: json['company_label'] ?? '',
      companyLogo: json['company_logo'] ?? '',
    );
  }

  // Method to convert User instance to JSON object
  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'phone': phone,
      'role': role,
      'role_name': roleName,
      'avator': avatar,
      'phone1': phone1,
      'username': username,
      'branch_name': branchName,
      'branch_district': branchDistrict,
      'branch_image': branchImage,
      'branch_location': branchLocation,
      'branch_region': branchRegion,
      'branch_id': branchId,
      'company_id': companyId,
      'company_name': companyName,
      'company_label': companyLabel,
      'company_logo': companyLogo,
    };
  }
}
