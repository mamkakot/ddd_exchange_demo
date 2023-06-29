import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_ddd/injection.dart';
import 'package:hello_ddd/domain/core/errors.dart';
import 'package:hello_ddd/domain/auth/i_auth_repository.dart';

extension FirestoreX on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = await getIt<IAuthRepository>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.id.getOrCrash());
  }
}

extension DocumentReferenceX on DocumentReference {
  CollectionReference get workTaskCollection => collection('work_tasks');
}
