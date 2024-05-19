import 'dart:convert';
import 'dart:math';

extension Summation on Iterable<num?> {
  num get sum {
    num s = fold(0, (p, n) => p=p+(n??0));
    return s;
  }
  num? get maximum {
    if(isEmpty) return null;
    num s =(toList() as List<num>).reduce(max);
    return s;
  }
  num? get minimum {
    if(isEmpty) return null;
    num s =(toList() as List<num>).reduce(min);
    return s;
  }


  String? get base64 {

    if(any((element) => element == null || element is double)) return null;
    List<int> bytes = toList() as List<int>;
    Map<String,dynamic> data = {
      "data": bytes
    };
    String base64 = base64Encode(bytes);
    return base64;
  }
}