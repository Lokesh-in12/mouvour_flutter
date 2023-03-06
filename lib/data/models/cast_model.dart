class CastModel {
  String? name;
  String? profilePath;

  CastModel({this.name, this.profilePath});

  factory CastModel.fromJson(Map<String, dynamic> json) => CastModel(
        name: json['name'] as String?,
        profilePath: json['profile_path'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'profile_path': profilePath,
      };
}
