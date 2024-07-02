import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import 'package:provider/provider.dart';
import '/flutter_flow/flutter_flow_util.dart';

List<String>? mathprobgen() {
  final random = math.Random();
  var range;
  var level = FFAppState().level;
  if (level == 'beginner') {
    range = 10;
  } else if (level == 'intermediate') {
    range = 20;
  } else if (level == 'advanced') {
    range = 30;
  } else {
    // Handle any other cases or set a default value for range
    range = 10; // Default to beginner level if level is not recognized
  }
  final num1 = random.nextInt(range) + 1;
  final num2 = random.nextInt(range) + 1;
  final sum = num1 + num2;
  String qstn = '$num1 + $num2';
  return [qstn, sum.toString()];
}
