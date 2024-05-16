// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: (json['id'] as num?)?.toInt(),
      media: json['media'] as String?,
      caption: json['caption'] as String?,
      mediaType: json['mediaType'] as String?,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'media': instance.media,
      'caption': instance.caption,
      'mediaType': instance.mediaType,
    };
