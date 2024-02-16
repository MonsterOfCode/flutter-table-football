class FormValidations {
  static String? notEmpty(String? value, {String? msg}) {
    if (value == null || value.isEmpty) return msg ?? "The field is required";
    return null;
  }
}
