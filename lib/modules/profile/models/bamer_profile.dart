import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BamerProfile {
  BamerProfile({
    required this.name,
    required this.githubHandle,
    required this.phoneNumber,
    required this.email,
  });

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  String name;

  @JsonKey(name: r'githubHandle', required: true, includeIfNull: false)
  String githubHandle;

  @JsonKey(name: r'phoneNumber', required: true, includeIfNull: false)
  String phoneNumber;

  @JsonKey(name: r'email', required: true, includeIfNull: false)
  String email;

  factory BamerProfile.fromJson(Map<String, dynamic> json) =>
      _$BamerProfileFromJson(json);
}

BamerProfile _$BamerProfileFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'LiftDto',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['name', 'githubHandle', 'phoneNumber', 'email'],
        );
        final val = BamerProfile(
          name: $checkedConvert('name', (v) => v as String),
          githubHandle: $checkedConvert('githubHandle', (v) => v as String),
          phoneNumber: $checkedConvert('phoneNumber', (v) => v as String),
          email: $checkedConvert('email', (v) => v as String),
        );
        return val;
      },
    );
