import 'package:flutter/material.dart';

class NeatCleanCalendarEvent {
  String summary;
  String description;
  String location;
  DateTime startTime;
  DateTime endTime;
  Color? color;
  bool isDone;
  Map<String, dynamic>? metadata;
  Function? onTap;

  NeatCleanCalendarEvent(
    this.summary, {
    this.description = '',
    this.location = '',
    required this.startTime,
    required this.endTime,
    this.color = Colors.blue,
    this.isDone = false,
    multiDaySegement,
    this.metadata,
    this.onTap,
  });
}
