// import 'package:caesar_cipher/core/services/contact_storage/cubit/contact_storage_cubit.dart';
// import 'package:caesar_cipher/init_dependencies.dart';

// class ContactService {
//   static ContactStorageCubit get contactStorage =>
//       serviceLocator<ContactStorageCubit>();

//   // Helper method to get contact name by phone number from anywhere in the app
//   static String? getContactName(String phoneNumber) {
//     return contactStorage.getContactName(phoneNumber);
//   }

//   // Helper method to get formatted display name (returns phone number if name not found)
//   static String getDisplayName(String phoneNumber) {
//     final name = getContactName(phoneNumber);
//     return name ?? phoneNumber;
//   }

//   // Check if contact exists
//   static bool hasContact(String phoneNumber) {
//     return getContactName(phoneNumber) != null;
//   }

//   // Get total contacts count
//   static int get totalContacts => contactStorage.totalContacts;

//   // Check if contacts are loaded
//   static bool get hasContacts => contactStorage.hasContacts;

//   // Check if storage is initialized
//   static bool get isInitialized => contactStorage.isInitialized;

//   // Check if currently loading
//   static bool get isLoading => contactStorage.isLoading;

//   // Get all contacts map
//   static Map<String, String> get allContacts => contactStorage.contactsMap;

//   // Refresh contacts manually
//   static Future<void> refreshContacts() async {
//     await contactStorage.refreshContacts();
//   }

//   // Add or update a contact manually
//   static Future<void> addOrUpdateContact(
//     String phoneNumber,
//     String name,
//   ) async {
//     await contactStorage.addOrUpdateContact(phoneNumber, name);
//   }

//   // Remove a contact
//   static Future<void> removeContact(String phoneNumber) async {
//     await contactStorage.removeContact(phoneNumber);
//   }

//   // Initialize storage if not already done
//   static Future<void> initializeIfNeeded() async {
//     if (!isInitialized) {
//       await contactStorage.initializeStorage();
//     }
//   }

//   // Load stored contacts
//   static Future<void> loadStoredContacts() async {
//     await contactStorage.loadStoredContacts();
//   }

//   // Format phone number for display (you can customize this based on your needs)
//   static String formatPhoneForDisplay(String phoneNumber) {
//     // Remove +91 prefix for Indian numbers for display
//     if (phoneNumber.startsWith('+91')) {
//       return phoneNumber.substring(3);
//     }
//     return phoneNumber;
//   }

//   // Get display name with formatted phone number
//   static String getDisplayNameWithFormattedPhone(String phoneNumber) {
//     final name = getContactName(phoneNumber);
//     if (name != null) {
//       return name;
//     }
//     return formatPhoneForDisplay(phoneNumber);
//   }

//   // Search contacts by name or phone number
//   static List<MapEntry<String, String>> searchContacts(String query) {
//     if (query.isEmpty) return [];

//     final lowercaseQuery = query.toLowerCase();
//     return allContacts.entries.where((entry) {
//       final phone = entry.key.toLowerCase();
//       final name = entry.value.toLowerCase();
//       return phone.contains(lowercaseQuery) || name.contains(lowercaseQuery);
//     }).toList();
//   }

//   // Get contacts starting with specific name letter
//   static List<MapEntry<String, String>> getContactsByFirstLetter(
//     String letter,
//   ) {
//     return allContacts.entries.where((entry) {
//       return entry.value.toLowerCase().startsWith(letter.toLowerCase());
//     }).toList();
//   }
// }
