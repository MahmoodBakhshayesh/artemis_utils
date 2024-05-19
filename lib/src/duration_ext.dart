
extension FormatDuraion on Duration? {
  String? get formatHHMMSS {
    if (this == null) return null;
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(this!.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(this!.inSeconds.remainder(60));
    return "${twoDigits(this!.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String? get formatHHMM {
    if (this == null) return null;
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(this!.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(this!.inSeconds.remainder(60));
    return "${twoDigits(this!.inHours)}:$twoDigitMinutes";
  }

  String? get formatMMSS {
    if (this == null) return null;
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(this!.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(this!.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}