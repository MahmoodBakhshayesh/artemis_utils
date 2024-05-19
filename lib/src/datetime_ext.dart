import 'package:intl/intl.dart';

extension Format on DateTime?
{
  String get format_ddMMMEEE {
    return this == null ? "" : DateFormat("ddMMM, EEE").format(this!);
  }

  String get format_ddMMM {
    return this == null ? "" : DateFormat("dd MMM").format(this!);
  }

  String get format_HHmm {
    return this == null ? "" : DateFormat("HH:mm").format(this!);
  }

  String get format_HHmmss {
    return this == null ? "" : DateFormat("HH:mm:ss").format(this!);
  }

  String get format_yyyyMMdd {
    return this == null ? "" : DateFormat("yyyy-MM-dd").format(this!);
  }
}