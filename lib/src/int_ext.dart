import 'package:intl/intl.dart';

extension FormatDuration on num? {
  String get formattedStr {
    return double.tryParse("${this ?? ""}") == null
        ? "${this ?? ""}"
        : NumberFormat.decimalPattern().format(double.tryParse("${this ?? ""}"));
  }
  String get str {
    return "${this ?? ""}";
  }
}