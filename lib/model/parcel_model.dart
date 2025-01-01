class Parcel {
  String senderName;
  String senderPhone;
  String receiverName;
  String barcodeId;
  String receiverPhone;
  String transporterName;
  String transporterPhone;
  String packageName;
  String packageSize;
  String packageType;
  String parcelValue;
  String parcelWeight;
  String destination;
  String transportationPrice;
  String specifyLocation;
  String description;
  String branchCreated;
  String createdat;

  Parcel({
    required this.senderName,
    required this.senderPhone,
    required this.receiverName,
    required this.barcodeId,
    required this.receiverPhone,
    required this.transporterName,
    required this.transporterPhone,
    required this.packageName,
    required this.packageSize,
    required this.packageType,
    required this.parcelValue,
    required this.parcelWeight,
    required this.destination,
    required this.transportationPrice,
    required this.specifyLocation,
    required this.description,
    required this.branchCreated,
    required this.createdat,
  });

  // Convert Parcel object to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'sender_name': senderName,
      'sender_phone': senderPhone,
      'receiver_name': receiverName,
      'barcode_id': barcodeId,
      'receiver_phone': receiverPhone,
      'transporter_name': transporterName,
      'transpoerter_phone': transporterPhone,
      'name': packageName,
      'package_size': packageSize,
      'package_type': packageType,
      'package_value': parcelValue,
      'package_weight': parcelWeight,
      'destination': destination,
      'price': transportationPrice,
      'specific_location': specifyLocation,
      'description': description,
      // 'bname': branchCreated,
    
    };
                           	
                           	// "branch_to":"3",
                           	// "package_tag":"10",
  }

  // Create Parcel object from JSON response
  factory Parcel.fromJson(Map<String, dynamic> json) {
    return Parcel(
      senderName: json['sender_name'] ?? 'Not specified',
      senderPhone: json['sender_phone'] ?? 'Not specified',
      receiverName: json['receiver_name']?? 'Not specified',
      barcodeId: json['barcode_id'],
      receiverPhone: json['receiver_phone'] ?? 'Not specified',
      transporterName: json['transporter_name']  ?? 'Not specified',
      transporterPhone: json['transpoerter_phone']  ?? 'Not specified',
      packageName: json['name'],
      packageSize: json['package_size'] ?? 'Not specified',
      packageType: json['package_type'] ?? 'Not Specified',
      parcelValue: json['parcel_value'] ?? 'Not Specified',
      parcelWeight: json['parcel_weight']?? 'Not Specified',
      destination: json['destination'] ?? 'Unknown Destination',
      transportationPrice: json['price'] ?? 'Unknown Destination',
      specifyLocation: json['specify_location'] ?? 'Not specified',
      description: json['description'] ?? 'Not specified' ,
      branchCreated: json['bname'] ?? 'Not specified' ,
      createdat: json['created_at'] ?? 'Not specified' ,
    );
  }
}
