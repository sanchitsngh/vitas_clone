enum FieldType { email, phoneNumber, text, numeric, dropdown }

class CustomFormField {
  final FieldType fieldType;
  final String label;
  final String? hintText;
  final List<String>? options; // For dropdowns
  final bool isRequired;

  CustomFormField({
    required this.fieldType,
    required this.label,
    this.hintText,
    this.options,
    this.isRequired = false,
  });

  factory CustomFormField.fromMap(Map<String, dynamic> map) {
    return CustomFormField(
      fieldType: parseFieldType(map['fieldType']),
      label: map['label'] ?? '',
      hintText: map['hintText'] ?? '',
      isRequired: map['isRequired'] ?? false,
      options:
          map['options'] != null ? List<String>.from(map['options']) : null,
    );
  }
}

class FormStep {
  final String title;
  final String description;
  final List<CustomFormField> formFields;

  FormStep({
    required this.title,
    required this.description,
    required this.formFields,
  });

  factory FormStep.fromMap(Map<String, dynamic> map) {
    return FormStep(
      title: map['Title']??'',
      description: map['description']??'',
      formFields: List<Map<String, dynamic>>.from(map['custom_form_field'])
          .map((fieldMap) => CustomFormField.fromMap(fieldMap))
          .toList(),
    );
  }
}

class DynamicForm {
  final List<FormStep> formSteps;

  DynamicForm({required this.formSteps});
}

List<CustomFormField> formFields1 = [
  CustomFormField(
      fieldType: FieldType.text, label: "First Name", isRequired: true),
  CustomFormField(
      fieldType: FieldType.text, label: "Last Name", isRequired: true),
  CustomFormField(
      fieldType: FieldType.phoneNumber,
      label: "Patient or Caregiver Phone Number",
      isRequired: true),
  CustomFormField(
      fieldType: FieldType.numeric, label: "Zip Code", isRequired: true),
  CustomFormField(
      fieldType: FieldType.dropdown,
      label: "Diagnosis",
      isRequired: true,
      hintText: "Choose a Diagnosis",
      options: <String>[
        "ALS",
        "Alzheimer's",
        "Cancer",
        "Heart Diseases",
        "HIV and AIds"
      ])
];

List<CustomFormField> formFields2 = [
  CustomFormField(
      fieldType: FieldType.text, label: "First Name", isRequired: true),
  CustomFormField(
      fieldType: FieldType.text, label: "Last Name", isRequired: true),
  CustomFormField(
      fieldType: FieldType.phoneNumber,
      label: "Phone Number",
      isRequired: true),
  CustomFormField(fieldType: FieldType.email, label: "Email", isRequired: true),
];

List<FormStep> formSteps = [
  FormStep(
      title: "Step 1 of 3",
      description: "Patient Information",
      formFields: formFields1),
  FormStep(
      title: "Step 2 of 3",
      description: "Your Information",
      formFields: formFields2),
];

DynamicForm dynamicForm = DynamicForm(formSteps: formSteps);

FieldType parseFieldType(String value) {
  switch (value.toLowerCase()) {
    case 'email':
      return FieldType.email;
    case 'phonenumber':
      return FieldType.phoneNumber;
    case 'text':
      return FieldType.text;
    case 'numeric':
      return FieldType.numeric;
    case 'dropdown':
      return FieldType.dropdown;
    default:
      throw Exception('Unknown FieldType: $value');
  }
}
