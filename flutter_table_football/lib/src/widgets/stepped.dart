import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';

class StepItem {
  Widget title;
  Widget content;

  StepItem({required this.title, required this.content});
}

/// This widget allow to create a stepped form
///
/// [executeOnStepContinue] is a map where you can add custom function to be
/// called before move to the next step
///
/// Map<StepNumber, bool FunctionToBeExecuted> [executeOnStepContinue]
///
/// The form will move to next step if do not exists a
/// function for the current step or if the FunctionToBeExecuted returns the number of steps to move
class Stepped extends StatefulWidget {
  final List<StepItem> steps;
  final Map<int, int Function()?>? executeOnStepContinue;
  final void Function()? done;
  final Widget? title;
  final String textNextButton;
  final String textNextButtonLastStep;
  final String textBackButton;

  const Stepped({
    super.key,
    required this.steps,
    this.executeOnStepContinue,
    this.done,
    this.title,
    this.textNextButton = "Next",
    this.textNextButtonLastStep = "Submit",
    this.textBackButton = "Back",
  });

  @override
  State<Stepped> createState() => _SteppedState();
}

class _SteppedState extends State<Stepped> {
  int _currentStep = 0;
  late int nSteps;
  bool isSubmitting = false;

  @override
  void initState() {
    nSteps = widget.steps.length;
    super.initState();
  }

  void onStepContinue() {
    if (_currentStep < nSteps) {
      setState(() {
        // the function defined for the current step will define the number of steps to move forward
        // like that you can manipulate the progression based on some conditions or user inputs
        _currentStep += widget.executeOnStepContinue?[_currentStep]?.call() ?? 1;
      });
    }
  }

  void onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  // handle the click of next buttons
  void nextStep(ControlsDetails details) {
    if (details.currentStep == nSteps - 1) {
      widget.done?.call();
      setState(() {
        isSubmitting = true;
      });
      return;
    }
    details.onStepContinue?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title,
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: onStepContinue,
        onStepTapped: (value) => setState(() => value < _currentStep ? _currentStep = value : null),
        onStepCancel: onStepCancel,
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Padding(
            padding: const EdgeInsets.only(top: kSpacing),
            child: Row(
              children: <Widget>[_renderNextStepButton(details), _renderBackStepButton(details)],
            ),
          );
        },
        steps: List.generate(widget.steps.length, (index) {
          var item = widget.steps[index];
          return Step(
            title: item.title,
            content: item.content,
            isActive: _currentStep >= index,
            state: _currentStep > index ? StepState.complete : StepState.indexed,
          );
        }),
      ),
    );
  }

  ElevatedButton _renderNextStepButton(ControlsDetails details) {
    return isSubmitting
        ? const ElevatedButton(
            onPressed: null,
            child: CircularProgressIndicator.adaptive(),
          )
        : ElevatedButton(
            onPressed: () => nextStep(details),
            child: Text(details.currentStep == nSteps - 1 ? widget.textNextButtonLastStep : widget.textNextButton),
          );
  }

  Widget _renderBackStepButton(ControlsDetails details) {
    // Only show Back button if not on the first step
    if (_currentStep > 0 && !isSubmitting) {
      return TextButton(
        onPressed: details.onStepCancel,
        child: Text(widget.textBackButton),
      );
    }
    return const SizedBox.shrink();
  }
}
