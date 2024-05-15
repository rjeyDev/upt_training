import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:upt_training/domain/models/post.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  int? id;
  String? email;
  String? password;
  String? photo;
  String? fullName;
  String? description;
  String? country;
  String? age;
  String? language;
  String? experience;
  List<String?>? workingDays;
  List<Post?>? posts;
  User({
    this.id,
    this.email,
    this.password,
    this.photo,
    this.fullName,
    this.description,
    this.country,
    this.age,
    this.language,
    this.experience,
    this.workingDays,
    this.posts,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
