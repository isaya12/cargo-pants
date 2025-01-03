class Parcel {
  int id;
  String senderName;
  String fullName;
  String phone1;
  String shippingat;
  String ariveat;
  String bbtoname;
  String bbfromname;
  String bbtoregion;
  String bbfromregion;
  String bbfromcontact;
  String bbtocontact;
  String codedata;
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
  String closedDescription;
  String fromRegion;
  String toRegion;
  String thumbnail;

  Parcel({
    required this.id,
    required this.fullName,
    required this.phone1,
    required this.shippingat,
    required this.ariveat,
    required this.bbtoname,
    required this.bbfromname,
    required this.bbtoregion,
    required this.bbfromregion,
    required this.bbfromcontact,
    required this.bbtocontact,
    required this.codedata,
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
    required this.closedDescription,
    required this.fromRegion,
    required this.toRegion,
    required this.thumbnail,
  });

  // Convert Parcel object to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender_name': senderName,
      'sender_phone': senderPhone,
      'receiver_name': receiverName,
      'barcode_id': barcodeId,
      'receiver_phone': receiverPhone,
      'transporter_name': transporterName,
      'transpoerter_phone': transporterPhone,
      'name': packageName,
      'package_size': packageSize,
      'package_tag': packageType,
      'package_value': parcelValue,
      'package_weight': parcelWeight,
      'destination': destination,
      'price': transportationPrice,
      'specific_location': specifyLocation,
      'description': description,
      'closed_description': closedDescription,
    
    };
  }

  // Create Parcel object from JSON response
  factory Parcel.fromJson(Map<String, dynamic> json) {
  return Parcel(
    id: json['id'] ?? 0, // Default to 0 for IDs
    fullName: json['fullName'] ?? '',
    phone1: json['phone1'] ?? '',
    shippingat: json['shipping_at'] ?? '',
    ariveat: json['arive_at'] ?? '',
    bbtoname: json['bb_to_name'] ?? '',
    bbfromname: json['bb_from_name'] ?? '',
    bbtoregion: json['bb_to_region'] ?? '',
    bbfromregion: json['bb_from_region'] ?? '',
    bbfromcontact: json['bb_from_contact'] ?? '',
    bbtocontact: json['bb_to_contact'] ?? '',
    codedata: json['code_data'] ?? '',
    senderName: json['sender_name'] ?? '',
    senderPhone: json['sender_phone'] ?? '',
    receiverName: json['receiver_name'] ?? '',
    barcodeId: json['barcode_id'] ?? '',
    receiverPhone: json['receiver_phone'] ?? '',
    transporterName: json['transporter_name'] ?? '',
    transporterPhone: json['transporter_phone'] ?? '',
    packageName: json['name'] ?? '',
    packageSize: json['package_size'] ?? '',
    packageType: json['package_type'] ?? '',
    parcelValue: json['parcel_value'] ?? '',
    parcelWeight: json['parcel_weight'] ?? '',
    destination: json['destination'] ?? '',
    transportationPrice: json['price'] ?? '',
    specifyLocation: json['specify_location'] ?? '',
    description: json['description'] ?? '',
    branchCreated: json['bname'] ?? '',
    createdat: json['created_at'] ?? '',
    closedDescription: json['closed_description'] ?? '',
    fromRegion: json['from_region'] ?? '',
    toRegion: json['to_region'] ?? '',
    thumbnail: json['thumbnail'] ?? '',
  );
}

}
