import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

String idFromGoal(DocumentReference goal) {
  return goal.id;
}

bool validateAddGoal(
  String name,
  String description,
  DateTime due,
) {
  return name != null &&
      name.isNotEmpty &&
      description != null &&
      description.isNotEmpty &&
      due != null;
}
