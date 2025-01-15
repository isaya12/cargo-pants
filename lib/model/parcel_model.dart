class Parcel {
  int id;
  String senderName;
  String fullName;
  String phone1;
  String shippingat;
  String ariveat;
  String bbtoname;
  String bbfromname;
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
  String? packageTypePrint;
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
   int branchTo;
  // String bid;
  String branchimage;
  // int incomingParcel;
  // int outgoing;
  // int received_30;
  // int sent_30;

  Parcel({
    required this.id,
    required this.fullName,
    required this.phone1,
    required this.shippingat,
    required this.ariveat,
    required this.bbtoname,
    required this.bbfromname,
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
    required this.packageTypePrint,
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
    // required this.bid,
    required this.branchimage,
    required this.branchTo,
    // required this.incomingParcel,
    // required this.outgoing,
    // required this.received_30,
    // required this.sent_30,
  });

  // Convert Parcel object to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'sender_name': senderName,
      'sender_phone': senderPhone,
      'receiver_name': receiverName,
      'receiver_phone': receiverPhone,
      'transporter_name': transporterName,
      'transpoerter_phone': transporterPhone,
      'name': packageName,
      'branch_to': branchTo,
      'package_size': packageSize,
      'package_tag': packageType,
      'package_value': parcelValue,
      'package_weight': parcelWeight,
      'destination': destination,
      'price': transportationPrice,
      'specific_location': specifyLocation,
      'description': description,
    };
  }

  // Create Parcel object from JSON response
  factory Parcel.fromJson(Map<String, dynamic> json) {
  return Parcel(
    id: json['id'] ?? 0, // Default to 0 for IDs
    fullName: json['fulname'] ?? '',
    phone1: json['phone1'] ?? '',
    shippingat: json['shipping_at'] ?? '',
    ariveat: json['arive_at'] ?? '',
    bbtoname: json['bb_to_name'] ?? '',
    bbfromname: json['bb_from_name'] ?? '',
    bbfromcontact: json['bb_from_contact'] ?? '',
    bbtocontact: json['bb_to_contact'] ?? '',
    codedata: json['code_data'] ?? '',
    senderName: json['sender_name'] ?? '',
    senderPhone: json['sender_phone'] ?? '',
    receiverName: json['receiver_name'] ?? '',
    barcodeId: json['barcode_id'] ?? '',
    receiverPhone: json['receiver_phone'] ?? '',
    transporterName: json['transporter_name'] ?? 'No transporter',
    transporterPhone: json['transporter_phone'] ?? 'No phone',
    packageName: json['name'] ?? '',
    packageSize: json['package_size'] ?? '',
    packageType: (json['tag_name'] ?? '').toString(),
    packageTypePrint: (json['package_tag'] ?? '').toString(),
    parcelValue: (json['package_value'] ?? '').toString(),
    parcelWeight: (json['package_weight'] ?? '').toString(),
    destination: json['destination'] ?? '',
    transportationPrice: json['price'] ?? '',
    specifyLocation: json['specific_location'] ?? 'Not specified',
    description: json['description'] ?? 'No comment',
    branchCreated: json['bname'] ?? '',
    createdat: json['created_at'] ?? '',
    closedDescription: json['closed_description'] ?? '',
    fromRegion: json['from_region'] ?? '',
    toRegion: json['to_region'] ?? '',
    branchTo: int.tryParse(json['branch_to']?.toString() ?? '0') ?? 0,

    // bid: json['bid'] ?? '',
    branchimage: json['branch_image'] ?? '',
    // branchTo: json['branch_to'] ?? '',
  );
}

}
