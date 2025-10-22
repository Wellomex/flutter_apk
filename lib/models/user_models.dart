import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_models.freezed.dart';
part 'user_models.g.dart';

@freezed
class UserSettings with _$UserSettings {
  const factory UserSettings({
    required String language,
    required String timezone,
    required NotificationSettings notifications,
    required PrivacySettings privacy,
    @Default(false) bool twoFactorEnabled,
    Map<String, dynamic>? preferences,
  }) = _UserSettings;

  factory UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);
}

@freezed
class NotificationSettings with _$NotificationSettings {
  const factory NotificationSettings({
    @Default(true) bool email,
    @Default(true) bool push,
    @Default(false) bool sms,
  }) = _NotificationSettings;

  factory NotificationSettings.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsFromJson(json);
}

@freezed
class PrivacySettings with _$PrivacySettings {
  const factory PrivacySettings({
    @Default(false) bool isProfilePublic,
    @Default(true) bool showActivity,
    @Default(true) bool showLocation,
    @Default(false) bool showEmail,
    @Default(false) bool showPhone,
  }) = _PrivacySettings;

  factory PrivacySettings.fromJson(Map<String, dynamic> json) =>
      _$PrivacySettingsFromJson(json);
}

@freezed
class Subscription with _$Subscription {
  const factory Subscription({
    required String planId,
    required String status,
    @Default(false) bool isActive,
    @Default(false) bool isPremium,
  }) = _Subscription;

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String name,
    @Default(false) bool isEmailVerified,
    required List<String> roles,
    required DateTime createdAt,
    required DateTime lastLoginAt,
    required UserSettings settings,
    Subscription? subscription,
    String? profilePicture,
    Map<String, dynamic>? metadata,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}