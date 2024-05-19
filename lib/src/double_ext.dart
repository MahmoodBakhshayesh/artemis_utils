
extension Parse on double? {
  int? get tryInt {
    if(this==null) return null;
    return this!.floor();
  }

  double? get sixFractionRounded {
    if (this==null) return null;
    return double.parse(this!.toStringAsFixed(6));
  }

  double? get sixFractionCut {
    if (this==null) return null;
    String tenDigit = this!.toStringAsFixed(10);
    String sixDigitStr = tenDigit.substring(0,tenDigit.length-4);
    return double.parse(sixDigitStr);
  }
  double? get twoFractionCut {
    if (this==null) return null;
    String tenDigit = this!.toStringAsFixed(10);
    String twoDigitStr = tenDigit.substring(0,tenDigit.length-8);
    return double.parse(twoDigitStr);
  }

}