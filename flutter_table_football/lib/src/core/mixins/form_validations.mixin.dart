import 'package:flutter_table_football/src/core/utils/form_validations.util.dart';

mixin FormValidators {
  String? notEmpty(String? value, {String? msg}) {
    return FormValidations.notEmpty(value, msg: msg);
  }
}
