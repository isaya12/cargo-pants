class EValidator {

  // Validation for empty text fields
  static String? validateEmptyText(String fieldname, String? value) {
    if (value == null || value.isEmpty) return '$fieldname is required';
    return null;
  }

  // Validation for email field
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  // Validation for password field
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  // Validation for phone number
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    final phoneRegExp = RegExp(r'^\d{10}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (10 digits required)';
    }
    return null;
  }

  // Validation for parcel weight
  static String? validateParcelWeight(String? value) {
    if (value == null || value.isEmpty) return 'Parcel weight is required';
    final weightRegExp = RegExp(r'^\d+(\.\d{1,2})?$'); // To allow decimal values
    if (!weightRegExp.hasMatch(value)) {
      return 'Invalid weight format';
    }
    return null;
  }

  // Validation for parcel value
  static String? validateParcelValue(String? value) {
    if (value == null || value.isEmpty) return 'Parcel value is required';
    final valueRegExp = RegExp(r'^\d+(\.\d{1,2})?$'); // To allow decimal values
    if (!valueRegExp.hasMatch(value)) {
      return 'Invalid value format';
    }
    return null;
  }

  // Validation for required fields with custom messages
  static String? validateRequiredField(String fieldname, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldname is required';
    }
    return null;
  }

  // Validation for parcel type selection
  static String? validateParcelType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a package type';
    }
    return null;
  }

  // Validation for destination branch
  static String? validateBranch(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a destination';
    }
    return null;
  }

  // Validation for parcel size
  static String? validateParcelSize(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a parcel size';
    }
    return null;
  }

  // Validation for description (optional but no empty space allowed)
  static String? validateDescription(String? value) {
    if (value != null && value.isEmpty) {
      return 'Description cannot be empty';
    }
    return null;
  }
}
