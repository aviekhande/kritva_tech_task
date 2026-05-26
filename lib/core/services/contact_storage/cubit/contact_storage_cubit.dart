// import 'dart:developer';
// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
// import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// part 'contact_storage_state.dart';

// class ContactStorageCubit extends Cubit<ContactStorageState> {
//   ContactStorageCubit() : super(ContactStorageInitial());

//   static const String _boxName = 'contacts_storage';
//   Box<String>? _contactsBox;

//   Future<void> initializeStorage() async {
//     try {
//       _contactsBox = await Hive.openBox<String>(_boxName);
//       emit(ContactStorageInitialized());
//     } catch (e) {
//       emit(ContactStorageError('Failed to initialize storage: $e'));
//     }
//   }

//   Future<void> fetchAndStoreContacts() async {
//     if (isLoading) return;
//     try {
//       emit(ContactStorageLoading());

//       if (!await FlutterContacts.requestPermission()) {
//         emit(ContactStorageError('Contact permission denied'));
//         return;
//       }

//       // 🔄 Everything runs here, on the main isolate (safe for plugins)
//       final Map<String, String> numberNameMap = {};

//       final contacts = await FlutterContacts.getContacts(
//         withProperties: true,
//         withPhoto: false,
//       );
//       // log(" ALl Contacts   ${contacts}");

//       log("Contacts  ${contacts.length.toString()}");
//       CountryWithPhoneCode? indianCountry;
//       try {
//         indianCountry = CountryManager().countries.firstWhere(
//           (country) => country.countryCode == 'IN',
//         );
//       } catch (e) {
//         indianCountry = CountryWithPhoneCode.getCountryDataByPhone('91');
//       }

//       for (final contact in contacts) {
//         if (contact.phones.isNotEmpty && contact.displayName.isNotEmpty) {
//           for (final phone in contact.phones) {
//             String rawNumber = phone.number.trim();
//             if (rawNumber.isNotEmpty) {
//               try {
//                 rawNumber = rawNumber.replaceAll(
//                   RegExp(
//                     r'[\s\-\(\)]+',
//                   ), // removes space, dash, and parentheses
//                   '',
//                 );
//                 // Remove leading '0' if present (e.g., 09876543210 -> 9876543210)
//                 if (rawNumber.startsWith('0') && rawNumber.length == 11) {
//                   rawNumber = rawNumber.substring(1);
//                 }

//                 final isWithCountryCode =
//                     rawNumber.startsWith('+91') || rawNumber.startsWith('91');
//                 String normalizedNumber = rawNumber;

//                 if (!isWithCountryCode &&
//                     RegExp(r'^[6789]\d{9}$').hasMatch(rawNumber)) {
//                   normalizedNumber = '+91$rawNumber';
//                 }

//                 final formattedNumber = formatNumberSync(
//                   normalizedNumber,
//                   country: indianCountry,
//                   phoneNumberType: PhoneNumberType.mobile,
//                   phoneNumberFormat: PhoneNumberFormat.international,
//                   inputContainsCountryCode: true,
//                 );

//                 final parsed = await parse(formattedNumber);

//                 if (parsed['e164'] != null &&
//                     parsed['region_code'] == 'IN' &&
//                     RegExp(r'^\+91[6789]\d{9}$').hasMatch(parsed['e164'])) {
//                   final finalNumber = parsed['e164'];
//                   numberNameMap[finalNumber] = contact.displayName;
//                 }
//               } catch (_) {
//                 // skip invalid
//                 debugPrint("Invalid number: $rawNumber");
//               }
//             }
//           }
//         }
//       }

//       // log('Fetched ${numberNameMap} contacts');

//       // ✅ Store in Hive
//       await _storeContactsInHive(numberNameMap);

//       emit(
//         ContactStorageLoaded(
//           contactsMap: numberNameMap,
//           totalContacts: numberNameMap.length,
//         ),
//       );
//     } catch (e) {
//       emit(ContactStorageError('Error processing contacts: $e'));
//     }
//   }

//   Future<void> _storeContactsInHive(Map<String, String> contactsMap) async {
//     if (_contactsBox == null) {
//       throw Exception('Storage not initialized');
//     }

//     // Clear existing data
//     await _contactsBox!.clear();

//     // Store new data
//     for (final entry in contactsMap.entries) {
//       await _contactsBox!.put(entry.key, entry.value);
//     }
//   }

//   Future<void> loadStoredContacts() async {
//     try {
//       if (_contactsBox == null) {
//         await initializeStorage();
//       }

//       if (_contactsBox != null) {
//         final storedContacts = Map<String, String>.from(_contactsBox!.toMap());
//         emit(
//           ContactStorageLoaded(
//             contactsMap: storedContacts,
//             totalContacts: storedContacts.length,
//           ),
//         );
//       }
//     } catch (e) {
//       emit(ContactStorageError('Error loading stored contacts: $e'));
//     }
//   }

//   String? getContactName(String phoneNumber) {
//     final currentState = state;
//     if (currentState is ContactStorageLoaded) {
//       return currentState.contactsMap[phoneNumber];
//     }

//     // Fallback: try to get from Hive directly
//     if (_contactsBox != null) {
//       return _contactsBox!.get(phoneNumber);
//     }

//     return null;
//   }

//   Future<void> addOrUpdateContact(String phoneNumber, String name) async {
//     try {
//       if (_contactsBox == null) {
//         throw Exception('Storage not initialized');
//       }

//       await _contactsBox!.put(phoneNumber, name);

//       // Update current state if loaded
//       final currentState = state;
//       if (currentState is ContactStorageLoaded) {
//         final updatedMap = Map<String, String>.from(currentState.contactsMap);
//         updatedMap[phoneNumber] = name;
//         emit(
//           ContactStorageLoaded(
//             contactsMap: updatedMap,
//             totalContacts: updatedMap.length,
//           ),
//         );
//       }
//     } catch (e) {
//       emit(ContactStorageError('Error updating contact: $e'));
//     }
//   }

//   Future<void> removeContact(String phoneNumber) async {
//     try {
//       if (_contactsBox == null) {
//         throw Exception('Storage not initialized');
//       }

//       await _contactsBox!.delete(phoneNumber);

//       // Update current state if loaded
//       final currentState = state;
//       if (currentState is ContactStorageLoaded) {
//         final updatedMap = Map<String, String>.from(currentState.contactsMap);
//         updatedMap.remove(phoneNumber);
//         emit(
//           ContactStorageLoaded(
//             contactsMap: updatedMap,
//             totalContacts: updatedMap.length,
//           ),
//         );
//       }
//     } catch (e) {
//       emit(ContactStorageError('Error removing contact: $e'));
//     }
//   }

//   Future<void> refreshContacts() async {
//     await fetchAndStoreContacts();
//   }

//   void resetStorage() {
//     emit(ContactStorageInitial());
//   }

//   Future<void> clearAllContacts() async {
//     try {
//       if (_contactsBox != null) {
//         await _contactsBox!.clear();
//         emit(ContactStorageLoaded(contactsMap: {}, totalContacts: 0));
//       }
//     } catch (e) {
//       emit(ContactStorageError('Error clearing contacts: $e'));
//     }
//   }

//   Future<List<String>> getStoredPhoneNumbers() async {
//     try {
//       if (_contactsBox == null) {
//         await initializeStorage();
//       }

//       if (_contactsBox == null) {
//         throw Exception('Storage not initialized');
//       }

//       // Get all the keys (which are phone numbers)
//       return _contactsBox!.keys.cast<String>().toList();
//     } catch (e) {
//       log('Error getting stored numbers: $e');
//       return [];
//     }
//   }

//   // Getters for easy access
//   Map<String, String> get contactsMap {
//     final currentState = state;
//     if (currentState is ContactStorageLoaded) {
//       return currentState.contactsMap;
//     }
//     return {};
//   }

//   int get totalContacts {
//     final currentState = state;
//     if (currentState is ContactStorageLoaded) {
//       return currentState.totalContacts;
//     }
//     return 0;
//   }

//   bool get isLoading => state is ContactStorageLoading;
//   bool get isInitialized =>
//       state is ContactStorageInitialized || state is ContactStorageLoaded;
//   bool get hasContacts => contactsMap.isNotEmpty;

//   @override
//   Future<void> close() async {
//     await _contactsBox?.close();
//     return super.close();
//   }
// }
