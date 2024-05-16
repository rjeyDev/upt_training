import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../../../data/datasource/local/service_locator/service_locator.dart';
import '../../../data/datasource/remote/jwt.dart';
import '../../../domain/models/post.dart';
import '../../../domain/models/user.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.when(
        start: () => _start(emit),
        register: (email, password, photo, fullName, description, country, age, language, experience, workingDays) =>
            _register(emit, email, password, photo, fullName, description, country, age, language, experience, workingDays),
        login: (email, password) => _login(emit, email, password),
        createPost: (media, mediaType, caption) => _createPost(emit, media, mediaType, caption),
        editProfile: (photo, fullName, description, country, age, language, experience, workingDays) =>
            _editProfile(emit, photo, fullName, description, country, age, language, experience, workingDays),
      );
    });
    add(const AuthEvent.start());
  }

  _start(Emitter emit) async {
    final usersBox = await Hive.openBox('usersBox');
    List<dynamic> users = usersBox.get('users') ?? [];
    List<User> newUsers = [];
    users.forEach((element) {
      Map<String, dynamic> castedElement = element.cast<String, dynamic>();
      newUsers.add(User.fromJson(castedElement));
    });
    User? user;
    if (sl.get<JwtBox>().authenticated) {
      user = newUsers.firstWhere((element) => element.id == sl.get<JwtBox>().id);
    }
    emit(state.copyWith(user: user, users: newUsers, action: AuthAction.usersLoaded));
  }

  _register(
    Emitter emit,
    String email,
    String password,
    String photo,
    String fullName,
    String description,
    String country,
    String age,
    String language,
    String experience,
    List<String?> workingDays,
  ) async {
    emit(state.copyWith(action: AuthAction.registerLoading));
    int lastId = state.users != null && state.users!.isNotEmpty ? state.users!.last.id ?? 0 : 0;
    List<User> users = state.users?.map((e) => e).toList() ?? [];
    users.add(User(
      id: lastId + 1,
      email: email,
      password: password,
      photo: photo,
      fullName: fullName,
      description: description,
      country: country,
      age: age,
      language: language,
      experience: experience,
      workingDays: workingDays,
      posts: [],
    ));
    await saveData();
    sl.get<JwtBox>().authenticated = true;
    sl.get<JwtBox>().id = users.last.id;
    emit(state.copyWith(user: users.last, users: users, action: AuthAction.register));
  }

  _login(Emitter emit, String email, String password) async {
    emit(state.copyWith(action: AuthAction.loginLoading));
    if (state.users != null && state.users!.isNotEmpty) {
      state.users!.forEach((element) {
        if (element.email == email) {
          if (element.password == password) {
            sl.get<JwtBox>().authenticated = true;
            sl.get<JwtBox>().id = element.id;
            emit(state.copyWith(user: element, action: AuthAction.login));
            return;
          } else {
            emit(state.copyWith(action: AuthAction.loginError));
          }
        }
      });
    }

    emit(state.copyWith(action: AuthAction.loginError));
  }

  _createPost(Emitter emit, String media, String mediaType, String caption) async {
    emit(state.copyWith(action: AuthAction.loginLoading));
    int lastPostId = 0;
    if (state.user?.posts != null && state.user!.posts!.isNotEmpty) {
      lastPostId = state.user?.posts?.last?.id ?? 0;
    }
    Post post = Post(id: lastPostId + 1, media: media, mediaType: mediaType, caption: caption);
    User user = state.user!;
    user.posts?.add(post);
    state.users?.forEach((element) {
      if (element.id == user.id) {
        element = user;
      }
    });

    await saveData();
    emit(state.copyWith(user: user, users: state.users, action: AuthAction.createPost));
  }

  _editProfile(
    Emitter emit,
    String photo,
    String fullName,
    String description,
    String country,
    String age,
    String language,
    String experience,
    List<String?> workingDays,
  ) async {
    User? user;
    emit(state.copyWith(action: AuthAction.editProfileLoading));
    state.users?.forEach((element) {
      if (element.id == state.user?.id) {
        element = User(
          id: element.id,
          email: element.email,
          password: element.password,
          photo: photo,
          fullName: fullName,
          description: description,
          country: country,
          age: age,
          language: language,
          experience: experience,
          workingDays: workingDays,
        );
        user = element;
      }
    });
    await saveData();
    emit(state.copyWith(user: user ?? state.user, users: state.users, action: AuthAction.editProfile));
  }

  saveData() async {
    List<Map<String, dynamic>> users = state.users?.map((e) => e.toJson()).toList() ?? [];
    final usersBox = await Hive.openBox('usersBox');
    await usersBox.put('users', users);
  }
}
