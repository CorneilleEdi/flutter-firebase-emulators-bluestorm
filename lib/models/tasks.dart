import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String? id;
  String title;

  Task({
    this.id,
    required this.title,
  });

  factory Task.fromFirestore(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic>? data = documentSnapshot.data();

    return Task(
      id: documentSnapshot.id,
      title: data?['title'] ?? "",
    );
  }

  Task copyWith({
    String? id,
    String? title,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() => 'Task(id: $id, title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Task && other.id == id && other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}
