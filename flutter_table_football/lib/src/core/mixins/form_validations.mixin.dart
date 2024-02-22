// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/data/enums/form_states.enum.dart';
import 'package:flutter_table_football/src/core/utils/form_validations.util.dart';

mixin FormHelper<T extends StatefulWidget> on State<T> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _errorsMessages = {};
  FormStates _formState = FormStates.loading;
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, FocusNode> _focusNodes = {};
  bool _formValidatorEnabled = false;

  String? notEmpty(String? value, {String? msg}) {
    return FormValidations.notEmpty(value, msg: msg);
  }

  /// function used to show the errors that are returned from APIs
  String? withErrorMessages(String fieldKey) {
    return FormValidations.withErrorMessages(_errorsMessages, fieldKey);
  }

  /// Method to validate the form
  ///
  /// returns if valid or not
  bool validateForm() {
    return (_formKey.currentState?.validate() ?? false) && _errorsMessages.isEmpty;
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

  String? getErrorFor(String fieldName) => _errorsMessages[fieldName]?[0];

  void requestFocusTo(String fieldName) {
    try {
      _focusNodes[fieldName]!.requestFocus();
    } catch (e) {
      throw "The fieldName that you are requesting focus do not exists on focusNode list";
    }
  }

  void cleanErrorsFromApi() => setState(() => _errorsMessages = {});

  /// Save the Errors from Api to show on the right fields
  ///
  /// [withErrorMessages] must be added to field and fieldName must be equals at key on server responses
  void addErrorMessage(Map<String, dynamic> errors) {
    setState(() => _errorsMessages = errors);
  }

  /// Change the formState to Idle
  void toIdle() => setState(() => _formState = FormStates.idle);

  /// Change the formState to Loading
  void toLoading() => setState(() => _formState = FormStates.loading);

  /// Change the formState to submitting
  void toSubmitting() => setState(() => _formState = FormStates.submitting);

  /// enables the auto validator to always
  void activeAutoValidator() => setState(() => _formValidatorEnabled = true);

  AutovalidateMode get autovalidateMode => _formValidatorEnabled ? AutovalidateMode.always : AutovalidateMode.disabled;

  /// returns is the formState is idle
  bool get isIdle => _formState == FormStates.idle;

  /// returns is the formState is loading
  bool get isLoading => _formState == FormStates.loading;

  /// returns is the formState is submitting
  bool get isSubmitting => _formState == FormStates.submitting;
  GlobalKey<FormState> get formKey => _formKey;

  @override
  void dispose() {
    // Dispose of all the controllers when the state is disposed.
    _controllers.values.forEach((controller) => controller.dispose());
    // Dispose of all the focusNodes when the state is disposed.
    _focusNodes.values.forEach((focus) => focus.dispose());
    formKey.currentState?.dispose();
    super.dispose();
  }

  /// Function that allow to use multiple validators
  /// Usage:
  ///  validator: ((value) => validators([
  ///    () => notEmpty(value, msg: "The nickname is required"),
  ///    () => withErrorMessages('name'),
  /// ])),
  String? validators(List<String? Function()> validators) {
    return FormValidations.validators(validators);
  }
}
