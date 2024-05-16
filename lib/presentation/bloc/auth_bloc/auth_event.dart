part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.start() = _AuthInit;
  const factory AuthEvent.register(String email, String password, String photo, String fullName, String description, String country, String age,
      String language, String experience, List<String?> workingDays) = _AuthRegister;
  const factory AuthEvent.login(String email, String password) = _AuthLogin;
  const factory AuthEvent.createPost(String media, String mediaType, String caption) = _AuthCreatePost;
  const factory AuthEvent.editProfile(String photo, String fullName, String description, String country, String age, String language,
      String experience, List<String?> workingDays) = _ProfileEdit;
}
