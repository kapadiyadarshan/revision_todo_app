import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_rev_todo_app/models/todo_model.dart';

class FbHelper {
  FbHelper._();
  static final FbHelper fbHelper = FbHelper._();

  String collectionPath = "ToDos";

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  addTodo({required ToDo data}) async {
    await fireStore.collection(collectionPath).doc(data.id).set(data.toMap);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getData() {
    return fireStore.collection(collectionPath).snapshots();
  }

  taskDone({required ToDo data}) async {
    await fireStore.collection(collectionPath).doc(data.id).update(data.toMap);
  }

  deleteTask({required String id}) async {
    await fireStore.collection(collectionPath).doc(id).delete();
  }
}
