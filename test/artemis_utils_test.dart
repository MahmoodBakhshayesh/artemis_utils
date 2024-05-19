import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:artemis_utils/artemis_utils.dart';

void main() {
  test('adds one to input values', () {

    ///salt ,	password	 ,   hash256
    // 8D7F670B63AA134    ,	ymaD4GD6SJXzMK5JrFv4d0oATBU=   ,	snO3iSIvG0PZnMNlVlDFn1vJLSAwsJRtKEk/LgiFdqs=
    String a = "0424";
    String salt = "8D7F670B63AA134";
    List<int> aa = a.toUtf16!;
    List<int> bb = salt.toUtf16!;
    // List<int> cc = aa+bb;
    List<int> cc = bb+aa;

    // print(a.toUtf16);
    final sh = sha256.convert(cc);
    // print(base64Encode(sh.bytes));
    final result = base64Encode(sh.bytes);
    // print(utf8.encode(a));
    print("snO3iSIvG0PZnMNlVlDFn1vJLSAwsJRtKEk/LgiFdqs="==result);
    // print("snO3iSIvG0PZnMNlVlDFn1vJLSAwsJRtKEk/LgiFdqs=");
    // print(result);
  });

}
