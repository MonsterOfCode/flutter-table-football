class FormValidations {
  static String? notEmpty(String? value, {String? msg}) {
    if (value == null || value.isEmpty) return msg ?? "The field is required";
    return null;
  }

  /// function used to show the errors that are returned from APIs
  static String? withErrorMessages(Map<String, dynamic> validationErrors, String fieldKey) {
    if (validationErrors.isEmpty) return null;
    if (validationErrors.containsKey(fieldKey)) {
      var error = validationErrors[fieldKey];
      return error is String ? error : error[0];
    }
    return null;
  }

  /// Function that allow to use multiple validators
  /// Usage:
  ///  validator: ((value) => validators([
  ///    () => notEmpty(value, msg: "The nickname is required"),
  ///    () => withErrorMessages('name'),
  /// ])),
  static String? validators(List<String? Function()> validators) {
    for (final func in validators) {
      final result = func();
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}
