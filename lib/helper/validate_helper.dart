import 'package:localization/localization.dart';

String? globalValidate(
    String value, int min, int max, bool isEmail, String fieldName) {
  if (value.isEmpty) {
    return "field_empty_error_message".i18n([fieldName]);
  }
  if (value.length < min && min != 0) {
    return "set_min_characters".i18n([fieldName,"$min"]);
  }
  if (value.length > max && max != 0) {
    return "set_max_characters".i18n([fieldName,"$max"]);
  }
  if (isEmail && !emailValidate(value)) {
    return "valid_email".i18n();
  }
  return null;
}

bool emailValidate(String email) {
  // Regular expression to validate email addresses
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}
