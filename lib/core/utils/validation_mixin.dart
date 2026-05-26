
mixin ValidationsMixin {
  // String? validatedPassword(String? value) {
  //   if (value == null || value.isEmpty || value.contains(' ')) {
  //     // return 'Ensure passwords are identical.';
  //     return 'Passwords fields should not be empty';
  //   } else if (value.length < 8) {
  //     return 'Password must be at least 8 characters';
  //   } else {
  //     return null;
  //   }
  // }

  // String? validatedPhoneNumber(String? value) {
  //   if (value == null ||
  //       value.length > 10 ||
  //       value.isEmpty ||
  //       value.length < 10) {
  //     return 'Please enter valid phone number';
  //   } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
  //     return 'Please enter valid phone number';
  //   } else {
  //     return null;
  //   }
  // }

  // String? validatedAddContactPhoneNumber(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter a phone number';
  //   }

  //   // Allow digits, +, *, #, (, ), -
  //   final validCharsPattern = RegExp(r'^[0-9+#*()\-\s]+$');
  //   if (!validCharsPattern.hasMatch(value)) {
  //     return 'Phone number can only contain digits, +, *, #, (, ), and -';
  //   }

  //   // Count only digits
  //   final digitCount = RegExp(r'\d').allMatches(value).length;
  //   if (digitCount < 3 || digitCount > 15) {
  //     return 'Phone number must have between 3 and 15 digits';
  //   }

  //   return null;
  // }

  // String? validatedContactName(String? value) {
  //   // Check for empty/null
  //   if (value == null || value.trim().isEmpty) {
  //     return 'Please enter a valid name';
  //   }

  //   // Check length
  //   if (value.length >= 52) {
  //     return 'Name must be less than 52 characters';
  //   }

  //   // Allow letters, digits, and spaces
  //   RegExp regex = RegExp(r'^[A-Za-z0-9 ]+$');
  //   if (!regex.hasMatch(value)) {
  //     return 'Name should only contain letters, numbers, and spaces';
  //   }

  //   return null;
  // }

  // String? validatedName(String? value) {
  //   // Check for empty/null
  //   if (value == null || value.trim().isEmpty) {
  //     return 'Please enter valid name';
  //   }

  //   // Check length
  //   if (value.length >= 52) {
  //     return 'Name must be less than 52 characters';
  //   }

  //   // Check characters
  //   RegExp regex = RegExp(r'^[A-Za-z\ ]+$');
  //   if (!regex.hasMatch(value)) {
  //     return 'Name should only contain alphabets';
  //   }

  //   return null;
  // }

  // String? validatedGroupName(String? value) {
  //   // Check for empty/null
  //   if (value == null || value.trim().isEmpty) {
  //     return 'Please enter valid name';
  //   }

  //   // Check length
  //   if (value.length >= 52) {
  //     return 'Name must be less than 52 characters';
  //   }

  //   // Check characters
  //   RegExp regex = RegExp(r'^[A-Za-z\ ]+$');
  //   if (!regex.hasMatch(value)) {
  //     return 'Name should only contain alphabets';
  //   }

  //   return null;
  // }

  // String? validateBio(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return "Please enter valid bio";
  //   }
  //   return null;
  // }

  // String? validatedMessage(String? value) {
  //   if (value == null || value.isEmpty || value.trim().isEmpty) {
  //     return 'Please enter valid message';
  //   } else if (value.length < 10) {
  //     return 'Please enter minimum 10 characters';
  //   } else {
  //     return null;
  //   }
  // }

  // String? validatedAddress(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter valid address';
  //   } else {
  //     return null;
  //   }
  // }

  // String? validatedDob(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter valid dob';
  //   } else {
  //     return null;
  //   }
  // }

  // String? validatedDate(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter a valid date';
  //   }

  //   try {
  //     // Regular expression to match the format "17th Feb 2001"
  //     RegExp regExp = RegExp(r'^\d{1,2}(st|nd|rd|th) [A-Za-z]+ \d{4}$');

  //     if (!regExp.hasMatch(value)) {
  //       return 'Enter date in "17th Feb 2001" format';
  //     }
  //   } catch (e) {
  //     return 'Enter a valid date in "17th Feb 2001" format';
  //   }

  //   return null;
  // }

  // String? validatedState(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Add a valid pincode to fetch state';
  //   } else {
  //     return null;
  //   }
  // }

  // String? validatedCity(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Add a valid pincode to fetch city';
  //   } else {
  //     return null;
  //   }
  // }

  // String? validatedPincode(String? value) {
  //   if (value == null || value.isEmpty || value.length < 6) {
  //     return 'Please enter valid pincode';
  //   } else {
  //     return null;
  //   }
  // }

  // String? validateOtp(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Security pin should not be empty';
  //   } else if (!RegExp(r'^\d+$').hasMatch(value)) {
  //     return 'Security pin  should contain only numbers';
  //   } else if (value.length < 6) {
  //     return 'Security pin must be at least 6 digits long';
  //   } else {
  //     return null;
  //   }
  // }

  // String? validateConfirmOtp(String? confirmPinValue, String pinValue) {
  //   if (confirmPinValue == null ||
  //       confirmPinValue.isEmpty ||
  //       confirmPinValue != pinValue) {
  //     return 'The confirm security pin does not match the new security pin';
  //   } else if (!RegExp(r'^\d+$').hasMatch(confirmPinValue)) {
  //     return 'Security pin  should contain only numbers';
  //   } else {
  //     return null;
  //   }
  // }

  // String? validateEmail(String? value) {
  //   final RegExp emailRegExp = RegExp(
  //     r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  //   );

  //   if (value == null || value.isEmpty || value.length > 150) {
  //     return 'Please enter an email address';
  //   } else if (!emailRegExp.hasMatch(value)) {
  //     return 'Please enter a valid email address';
  //   } else {
  //     return null;
  //   }
  // }
}
