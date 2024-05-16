import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  int? id;
  String? media;
  String? caption;
  String? mediaType;

  Post({
    this.id,
    this.media,
    this.caption,
    this.mediaType,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
