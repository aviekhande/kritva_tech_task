part of 'contact_storage_cubit.dart';

abstract class ContactStorageState {}

class ContactStorageInitial extends ContactStorageState {}

class ContactStorageInitialized extends ContactStorageState {}

class ContactStorageLoading extends ContactStorageState {}

class ContactStorageLoaded extends ContactStorageState {
  final Map<String, String> contactsMap;
  final int totalContacts;

  ContactStorageLoaded({
    required this.contactsMap,
    required this.totalContacts,
  });
}

class ContactStorageError extends ContactStorageState {
  final String message;

  ContactStorageError(this.message);
}
