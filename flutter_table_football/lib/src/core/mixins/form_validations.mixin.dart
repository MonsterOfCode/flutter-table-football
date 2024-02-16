import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/enums/form_states.enum.dart';
import 'package:flutter_table_football/src/core/utils/form_validations.util.dart';

mixin FormHelper<T extends StatefulWidget> on State<T> {
  final GlobalKey<FormState> formKey = GlobalKey();
  FormStates _formState = FormStates.loading;
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, FocusNode> _focusNodes = {};
  bool _formValidatorEnabled = false;

  String? notEmpty(String? value, {String? msg}) {
    return FormValidations.notEmpty(value, msg: msg);
  }

  /// Method to validate the form
  ///
  /// returns if valid or not
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  TextEditingController getController(String fieldName) {
    // Check if a controller with the given name already exists.
    // If not, create it and add it to the map.
    return _controllers.putIfAbsent(fieldName, () => TextEditingController());
  }

  String getControllerValue(String fieldName) {
    try {
      return _controllers[fieldName]!.text;
    } catch (e) {
      throw "The fieldName that you are requesting a value do not exists on controller list";
    }
  }

  FocusNode getNodeFocus(String fieldName) {
    // Check if a focusNode with the given name already exists.
    // If not, create it and add it to the map.
    return _focusNodes.putIfAbsent(fieldName, () => FocusNode());
  }

  void requestFocusTo(String fieldName) {
    try {
      _focusNodes[fieldName]!.requestFocus();
    } catch (e) {
      throw "The fieldName that you are requesting focus do not exists on focusNode list";
    }
  }

  void toIdle() => setState(() => _formState = FormStates.idle);
  void toLoading() => setState(() => _formState = FormStates.loading);
  void toSubmitting() => setState(() => _formState = FormStates.submitting);

  void activeAutoValidator() => setState(() => _formValidatorEnabled = true);

  AutovalidateMode get autovalidateMode => _formValidatorEnabled ? AutovalidateMode.always : AutovalidateMode.disabled;
  bool get isIdle => _formState == FormStates.idle;
  bool get isLoading => _formState == FormStates.loading;
  bool get isSubmitting => _formState == FormStates.submitting;

  @override
  void dispose() {
    // Dispose of all the controllers when the state is disposed.
    _controllers.values.forEach((controller) => controller.dispose());
    // Dispose of all the focusNodes when the state is disposed.
    _focusNodes.values.forEach((focus) => focus.dispose());
    super.dispose();
  }
}
