import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitas_clone/models/form_data.dart';

final dynamicFormProvider = FutureProvider<DynamicForm>((ref) async {
  final firestore = FirebaseFirestore.instance;

  // Assuming you only have ONE document inside config
  final configSnap = await firestore.collection('config').get();
  final configDocId = configSnap.docs.first.id;

  final referralFormSnap = await firestore
      .collection('config')
      .doc(configDocId)
      .collection('Referral_Form')
      
      .get();

  final formSteps = referralFormSnap.docs.map((doc) {
    return FormStep.fromMap(doc.data());
  }).toList();

  
  return DynamicForm(formSteps: formSteps);
});
