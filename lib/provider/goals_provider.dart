import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_tracker/models/goal.dart';
import 'package:study_tracker/provider/user_provider.dart';

final goalsProvider = StreamProvider.autoDispose<List<Goal>>((ref) {
  final user = ref.watch(userProvider).value;
  if (user == null) return Stream.empty();
  return FirebaseFirestore.instance
      .collection('goals')
      .where('user_id', isEqualTo: user.uid)
      .orderBy('due')
      .snapshots()
      .map((data) => data.docs.map((doc) => Goal.fromJson(doc.data())))
      .map((list) => list.toList());
});
