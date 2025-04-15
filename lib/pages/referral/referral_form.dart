import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import 'package:vitas_clone/common/utils/text_input_formatter.dart';

import 'package:vitas_clone/common/widgets/app_textFormFields.dart';
import 'package:vitas_clone/common/widgets/card.dart';
import 'package:vitas_clone/common/widgets/custom_dropdown.dart';
import 'package:vitas_clone/core/constants/app_colors.dart';
import 'package:vitas_clone/core/utils/validators.dart';
import 'package:vitas_clone/models/form_data.dart';
import 'package:vitas_clone/pages/referral/notifier/referral_form_data_notifier.dart';
import 'package:vitas_clone/pages/referral/notifier/referral_form_fields_notifier.dart';
import 'package:vitas_clone/pages/referral/notifier/referral_state_notifier.dart';
import 'package:vitas_clone/pages/referral/referral.dart';

class ReferralForm extends ConsumerStatefulWidget {
  final DynamicForm form;
  const ReferralForm({super.key, required this.form});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ReferralFormState();
  }
}

class ReferralFormState extends ConsumerState<ReferralForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in controllers.entries) {
      controller.value.dispose();
    }
    super.dispose();
  }

  void _validateAndProceed(FormStep formStep) {
    if (_formKey.currentState!.validate()) {
      // ✅ All fields are valid, move to the next page'

      final step1Data = <String, String>{};
      controllers.forEach((key, controller) {
        step1Data[key] = controller.text.trim();
      });

      ref.read(referralFormProvider.notifier).updateStep1(step1Data);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ReferralPersonalInformation(formStep: formStep)));
    } else {
      final snackBar = SnackBar(
        content: Text("Please fill all fields correctly"),
        backgroundColor: purple[400],
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(50),
        action: SnackBarAction(
          label: 'Dismiss',
          disabledTextColor: Colors.white,
          textColor: Colors.white,
          onPressed: () {
            //Do whatever you want
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dynamicForm1 = ref.watch(dynamicFormProvider);
    //FormStep patientInformationForm = dynamicForm1.formSteps[0];
    User? user = FirebaseAuth.instance.currentUser;
    print(user);
    return dynamicForm1.when(
      data: (form) {
        FormStep patientInformationForm = form.formSteps[1];
        print("hi");
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/icon_close.svg'),
              )
            ],
          ),
          body: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(color: purple[50]),
            child: Column(children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(patientInformationForm.title),
                          SizedBox(
                            height: 8,
                          ),
                          Text(patientInformationForm.description),
                          SizedBox(
                            height: 8,
                          ),
                          ...patientInformationForm.formFields
                              .expand((formField) => [
                                    _buildField(formField, controllers, ref,
                                        stepKey: "step1"),
                                    SizedBox(
                                      height: 8.0,
                                    )
                                  ]),
                          SizedBox(
                            height: 16.0,
                          )
                        ]),
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                width: double.infinity,
                constraints: BoxConstraints(minHeight: 48),
                decoration: BoxDecoration(
                  boxShadow: [shadowLowElevation],
                  color: purple[600],
                  borderRadius: BorderRadius.circular(25.0),
                ),
                alignment: Alignment.center,
                child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      _validateAndProceed(form.formSteps[0]);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Continue",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )),
              ),
            ]),
          ),
        );
      },
      loading: () => Container(
          color: Colors.white,
          child: Center(child: CircularProgressIndicator())),
      error: (error, stack) => TextButton(
          onPressed: () {
            setState(() {});
          },
          child: Text(error.toString())),
    );
  }
}

Widget _buildField(CustomFormField formField,
    Map<String, TextEditingController> controllers, WidgetRef ref,
    {required String stepKey}) {
  if (!controllers.containsKey(formField.label)) {
    final formData = ref.read(referralFormProvider);
    final stepData =
        stepKey == 'step1' ? formData.step1Data : formData.step2Data;
    final initialText = stepData[formField.label] ?? '';
    controllers[formField.label] = TextEditingController(text: initialText);
  }
  switch (formField.fieldType) {
    case FieldType.text:
      return AppTextFormField(
        text: formField.label,
        hintText: formField.hintText,
        controller: controllers[formField.label]!,
        isRequired: true,
        validator: Validators.validateRequiredField,
      );
    case FieldType.numeric:
      return AppTextFormField(
        text: formField.label,
        hintText: formField.hintText,
        controller: controllers[formField.label]!,
        isRequired: true,
      );
    case FieldType.email:
      return AppTextFormField(
        text: formField.label,
        hintText: formField.hintText,
        validator: Validators.validateEmail,
        controller: controllers[formField.label]!,
        isRequired: true,
      );
    case FieldType.dropdown:
      return CustomDropdown(
        options: formField.options!,
        label: formField.label,
        hintText: formField.hintText,
      );
    case FieldType.phoneNumber:
      return AppTextFormField(
        text: formField.label,
        hintText: formField.hintText,
        controller: controllers[formField.label]!,
        inputFormatters: [USNumberTextInputFormatter()],
        isRequired: true,
      );
  }
}

class ReferralPersonalInformation extends ConsumerStatefulWidget {
  final FormStep formStep;

  const ReferralPersonalInformation({super.key, required this.formStep});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ReferralPersonalInformationState();
  }
}

class ReferralPersonalInformationState
    extends ConsumerState<ReferralPersonalInformation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, TextEditingController> controllers = {};
  bool? isChecked = true;

  void _validateAndProceed() {
    if (_formKey.currentState!.validate()) {
      if (_formKey.currentState!.validate()) {
        final step2Data = <String, String>{};
        controllers.forEach((key, controller) {
          step2Data[key] = controller.text.trim();
        });

        step2Data["update your information"] = isChecked == true ? "Yes" : "No";

        ref.read(referralFormProvider.notifier).updateStep2(step2Data);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FinalFormSummary(),
          ),
        );

        //  Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) =>
        //       ReferralPersonalInformation(
        //       formStep: widget.formStep.formSteps[1])));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill all fields correctly")),
        );
      }
    }
  }

  void _updateProfile() {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/icon_close.svg'),
            )
          ],
        ),
        body: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(color: purple[50]),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.formStep.title),
                        SizedBox(
                          height: 8,
                        ),
                        Text(widget.formStep.description),
                        SizedBox(
                          height: 8,
                        ),
                        ...widget.formStep.formFields.expand((formField) => [
                              _buildField(formField, controllers, ref,
                                  stepKey: "step2"),
                              SizedBox(
                                height: 8.0,
                              )
                            ]),
                      ],
                    ),
                  )),
                  Column(
                    children: [
                      Row(children: [
                        Expanded(
                          child: Checkbox(
                              value: isChecked,
                              onChanged: (checked) => {
                                    setState(() {
                                      isChecked = checked ?? false;
                                    })
                                  }),
                        ),
                        Expanded(
                          flex: 8,
                          child: Text(
                            "Update your profile with thia contact information to skip this step in the future",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        )
                      ]),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        width: double.infinity,
                        constraints: BoxConstraints(minHeight: 48),
                        decoration: BoxDecoration(
                          boxShadow: [shadowLowElevation],
                          color: purple[600],
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        alignment: Alignment.center,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                            ),
                            onPressed: _validateAndProceed,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "finalize",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}

class FinalFormSummary extends ConsumerWidget {
  const FinalFormSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formData = ref.watch(referralFormProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Summary")),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(color: purple[50]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Step 3 of 3",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              "Confirm Referral",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Patient Information",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                SizedBox(
                  width: 8.0,
                ),
                IconButton(
                    onPressed: () async {
                      final asyncForm =
                          await ref.read(dynamicFormProvider.future);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ReferralForm(form: asyncForm)));
                    },
                    icon: SvgPicture.asset('assets/icons/icon_edit.svg'))
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            ...formData.step1Data.entries
                .map((e) => Text("${e.key}: ${e.value}")),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Your Information",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                SizedBox(
                  width: 8.0,
                ),
                IconButton(
                    onPressed: () async {
                      final asyncForm =
                          await ref.read(dynamicFormProvider.future);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReferralPersonalInformation(
                                  formStep: asyncForm.formSteps[0])));
                    },
                    icon: SvgPicture.asset('assets/icons/icon_edit.svg'))
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            ...formData.step2Data.entries
                .map((e) => Text("${e.key}: ${e.value}")),
            Spacer(),
            Container(
              width: double.infinity,
              constraints: BoxConstraints(minHeight: 48),
              decoration: BoxDecoration(
                boxShadow: [shadowLowElevation],
                color: purple[600],
                borderRadius: BorderRadius.circular(25.0),
              ),
              alignment: Alignment.center,
              child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // ref.read(referralFormProvider.notifier).reset();
                    // Navigator.pushReplacementNamed(context, "Referrals");
                    sendReferral(context, ref);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Confirm and Submit",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class ReferralSendingPage extends ConsumerStatefulWidget {
  final Map<String, String> referralData;

  ReferralSendingPage({required this.referralData});

  static void navigateTo(BuildContext context,
      {required final Map<String, String> referralData}) {
    final PageRouteBuilder builder = PageRouteBuilder<ReferralSendingPage>(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ReferralSendingPage(referralData: referralData),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          child: child,
          position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
              .animate(animation),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    );

    Navigator.of(context).push(builder);
  }

  @override
  ConsumerState<ReferralSendingPage> createState() =>
      _ReferralSendingPageState();
}

class _ReferralSendingPageState extends ConsumerState<ReferralSendingPage> {
  @override
  void initState() {
    super.initState();

    // Trigger referral sending as soon as the page opens
    Future.microtask(() {
      ref
          .read(referralProvider.notifier)
          .sendReferral(widget.referralData); // Send referral data
    });
  }

  @override
  Widget build(BuildContext context) {
    final referralState = ref.watch(referralProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sending Referral'),
        automaticallyImplyLeading: !referralState.isLoading,
      ),
      body: Center(
        child: referralState.isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16.0),
                  Text(
                    "Sending your referral...",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              )
            : referralState.isSuccessful
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle,
                          color: Colors.green, size: 100),
                      SizedBox(height: 16.0),
                      Text(
                        "Referral Sent Successfully",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "Referrals");
                           ref.read(referralFormProvider.notifier).reset();
                        },
                        child: Text("Close"),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, color: Colors.red, size: 100),
                      SizedBox(height: 16.0),
                      Text(
                        referralState.errorMessage ??
                            "Failed to Send Referral",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "Referrals");
                           ref.read(referralFormProvider.notifier).reset();
                        },
                        child: Text("Close"),
                      ),
                    ],
                  ),
      ),
    );
  }
}

// Example Usage
void sendReferral(BuildContext context, WidgetRef ref) {
  final referralData = ref
      .read(referralFormProvider)
      .step1Data; // Collect the actual referral data
  ReferralSendingPage.navigateTo(
    context,
    referralData: referralData,
  );
}
