import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/tasks.dart';

class TaskService {
  late final FirebaseFirestore _firestore;
  late final CollectionReference _ref;

  String host = defaultTargetPlatform == TargetPlatform.android
      ? '10.0.2.2:9055'
      : 'localhost:9055';

  TaskService() {
    FirebaseFirestore.instance.settings =
        Settings(host: host, sslEnabled: false);
    _firestore = FirebaseFirestore.instance;

    _ref = _firestore.collection('Tasks');
  }

  Stream<List<Task>> getTasks() {
    Stream<QuerySnapshot> snap = _ref.snapshots(
      includeMetadataChanges: false,
    );

    return snap.map(
      (list) => list.docs.map((doc) => Task.fromFirestore(doc)).toList(),
    );
  }

  Future<void> addTask(Task task) {
    return _ref.add(task.toMap());
  }

  Future<void> deleteTask(String id) {
    return _ref.doc(id).delete();
  }

  Future updateTask(Task task) {
    return _ref.doc(task.id).set(task.toMap());
  }
}
