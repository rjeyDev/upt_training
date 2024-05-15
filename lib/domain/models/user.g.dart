// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      email: json['email'] as String?,
      password: json['password'] as String?,
      photo: json['photo'] as String?,
      fullName: json['fullName'] as String?,
      description: json['description'] as String?,
      country: json['country'] as String?,
      age: json['age'] as String?,
      language: json['language'] as String?,
      experience: json['experience'] as String?,
      workingDays: (json['workingDays'] as List<dynamic>?)?.map((e) => e as String?).toList(),
      posts: (json['posts'] as List<dynamic>?)?.map((e) {
        if (e == null) return null;
        var castedE = e.cast<String, dynamic>();
        return Post.fromJson(castedE);
      }).toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'photo': instance.photo,
      'fullName': instance.fullName,
      'description': instance.description,
      'country': instance.country,
      'age': instance.age,
      'language': instance.language,
      'experience': instance.experience,
      'workingDays': instance.workingDays,
      'posts': instance.posts?.map((e) => e?.toJson()).toList(),
    };
