part of 'add_permissions_bloc.dart';

@freezed
class AddPermissionsEvent with _$AddPermissionsEvent {
  const factory AddPermissionsEvent.started() = _Started;
  const factory AddPermissionsEvent.addPermission({
    required String date,
    required String reason,
    required XFile? image,
  }) = _AddPermission;
}