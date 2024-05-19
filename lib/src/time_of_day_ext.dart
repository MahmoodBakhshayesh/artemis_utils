import 'package:flutter/material.dart';

extension FormatTime on TimeOfDay? {
  DateTime? toDateTime({int? year, int? month, int? day}) {
    if (this == null) return null;
    DateTime n = DateTime.now();
    return DateTime(year ?? n.year, month ?? n.month, day ?? n.day, this!.hour, this!.minute, 0);
  }

  String get format_HHmm {
    return this == null ? "" : "${this!.hour.toString().padLeft(2, "0")}:${this!.minute.toString().padLeft(2, "0")}";
  }

  Duration? difference(TimeOfDay t) {
    return toDateTime()?.difference(t.toDateTime()!);
  }

  TimeOfDay? subtract(Duration t) {
    if (toDateTime()?.subtract(t) == null) return null;
    DateTime? dt = toDateTime()?.subtract(t);
    if (dt == null) return null;
    return TimeOfDay.fromDateTime(dt);
  }

  TimeOfDay? add(Duration t) {
    if (toDateTime()?.add(t) == null) return null;
    DateTime? dt = toDateTime()?.add(t);
    if (dt == null) return null;
    return TimeOfDay.fromDateTime(dt);
  }
}
