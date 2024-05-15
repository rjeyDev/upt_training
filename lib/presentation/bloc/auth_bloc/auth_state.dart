part of 'auth_bloc.dart';

enum AuthAction {
  usersLoaded,
  loginLoading,
  login,
  loginError,
  registerLoading,
  register,
  registerError,
  createPostLoading,
  createPost,
  createPostError,
  editProfileLoading,
  editProfile,
  editProfileError,
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    AuthAction? action,
    List<User>? users,
    User? user,
  }) = _AuthState;

  factory AuthState.initial() {
    return const AuthState();
  }
}
