import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/history_model.dart';

class FirebaseService {
  final FirebaseFirestore _db =
      FirebaseFirestore.instance;

  Future<void> saveHistory(
      HistoryModel model) async {
    await _db
        .collection("age_history")
        .add(model.toMap());
  }

  Future<List<HistoryModel>> getHistory() async {
    final snapshot = await _db
        .collection("age_history")
        .get();

    return snapshot.docs
        .map((e) => HistoryModel.fromMap(e.data()))
        .toList();
  }
}