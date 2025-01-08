part of 'add_permissions_bloc.dart';

@freezed
class AddPermissionsState with _$AddPermissionsState {
  const factory AddPermissionsState.initial() = _Initial;
  const factory AddPermissionsState.loading() = _Loading;
  const factory AddPermissionsState.success() = _Success;
  const factory AddPermissionsState.error(String message) = _Error;
}
