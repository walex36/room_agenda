import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  bool isBefore(TimeOfDay time) {
    if (hour <= time.hour) {
      if (minute < time.minute) {
        return true;
      }
    }
    return false;
  }

  bool isAfter(TimeOfDay time) {
    if (hour >= time.hour) {
      if (minute > time.minute) {
        return true;
      }
    }
    return false;
  }
}
