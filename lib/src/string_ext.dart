import 'package:artemis_utils/src/utf.dart';
import 'package:flutter/material.dart';
import 'int_ext.dart';
import 'package:intl/intl.dart';
import '../classes/hex_color.dart';

extension ParseStr on String? {
  int? get tryInt {
    return int.tryParse((this ?? "").replaceAll(",", ""));
  }

  double? get tryDouble {
    return double.tryParse((this ?? "").replaceAll(",", ""));
  }

  String? get tryFormattedInt {
    return tryInt == null ? this : tryInt.formattedStr;
  }

  Duration? get tryDuration {
    if (this == null || !this!.contains(":")) {
      return null;
    } else {
      List<String> split = this!.split(":");
      if (split.any((element) => int.tryParse(element) == null)) {
        return null;
      } else {
        if (split.length == 2) {
          return Duration(hours: int.tryParse(split[0])!, minutes: int.tryParse(split[1])!);
        } else if (split.length == 3) {
          return Duration(hours: int.tryParse(split[0])!, minutes: int.tryParse(split[1])!, seconds: int.tryParse(split[2])!);
        } else {
          return null;
        }
      }
    }
  }

  DateTime? get tryDateTime {
    if (this == null) {
      return null;
    } else {
      if (DateTime.tryParse(this!) != null) {
        return DateTime.tryParse(this!)!;
      } else {
        RegExp reg1 = RegExp(r'(\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d)');
        RegExp reg2 = RegExp(r'(\d\d:\d\d:\d\d)');
        RegExp reg3 = RegExp(r'(\d\d\d\d-\d\d-\d\d)');
        RegExp reg4 = RegExp(r'(\d\d:\d\d)');

        if (reg1.hasMatch(this!)) {
          String a = reg1.firstMatch(this!)!.group(1)!;
          return DateFormat("yyyy-MM-dd HH:mm:ss").parse(a);
        } else if (reg2.hasMatch(this!)) {
          String a = reg2.firstMatch(this!)!.group(1)!;
          return DateFormat("HH:mm:ss").parse(a);
        } else if (reg3.hasMatch(this!)) {
          String a = reg3.firstMatch(this!)!.group(1)!;
          return DateFormat("yyyy-MM-dd").parse(a);
        } else if (reg4.hasMatch(this!)) {
          String a = reg4.firstMatch(this!)!.group(1)!;
          return DateFormat("HH:mm").parse(a);
        } else {
          return null;
        }

        // if(this!.contains(" ")){
        //   String datePart = this!.split(" ")[0];
        //   if(datePart.)
        // }
      }
    }
  }

  DateTime? get tryDateTimeUTC {
    if (this == null) {
      return null;
    } else {
      if (DateTime.tryParse(this!) != null) {
        return DateFormat("yyyy-MM-dd HH:mm:ss").parse("${DateTime.tryParse(this!)!}", true);
      } else {
        RegExp reg1 = RegExp(r'(\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d)');
        RegExp reg2 = RegExp(r'(\d\d:\d\d:\d\d)');
        RegExp reg3 = RegExp(r'(\d\d\d\d-\d\d-\d\d)');
        RegExp reg4 = RegExp(r'(\d\d:\d\d)');

        if (reg1.hasMatch(this!)) {
          String a = reg1.firstMatch(this!)!.group(1)!;
          return DateFormat("yyyy-MM-dd HH:mm:ss").parse(a, true);
        } else if (reg2.hasMatch(this!)) {
          String a = reg2.firstMatch(this!)!.group(1)!;
          return DateFormat("HH:mm:ss").parse(a, true);
        } else if (reg3.hasMatch(this!)) {
          String a = reg3.firstMatch(this!)!.group(1)!;
          return DateFormat("yyyy-MM-dd").parse(a, true);
        } else if (reg4.hasMatch(this!)) {
          String a = reg4.firstMatch(this!)!.group(1)!;
          return DateFormat("HH:mm").parse(a, true);
        } else {
          return null;
        }
      }
    }
  }

  TimeOfDay? get tryTimeOfDay {
    if (tryDateTime == null) {
      return null;
    } else {
      return TimeOfDay.fromDateTime(tryDateTime!);
    }
  }

  TimeOfDay? get tryTimeOfDayUTC {
    if (tryDateTimeUTC == null) {
      return null;
    } else {
      return TimeOfDay.fromDateTime(tryDateTimeUTC!);
    }
  }

  Color? get tryColor {
    if (this == null) return null;
    String hex = this!.toUpperCase().replaceAll("#", "");
    if (hex.length == 6) {
      hex = "FF" + hex;
    }
    if (int.tryParse(hex, radix: 16) == null) return null;
    return HexColor(hex);
  }

  List<int>? get toUtf16 {
    if(this==null) return null;
    return encodeUtf16(this!);
  }
}
