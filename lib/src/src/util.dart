// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library utf.util;

import 'constants.dart';
import 'list_range.dart';
import 'utf_16_code_unit_decoder.dart';

/// Decodes the utf16 codeunits to codepoints.
List<int> utf16CodeUnitsToCodepoints(List<int> utf16CodeUnits,
    [int offset = 0,
    int length = 0,
    int replacementCodepoint = UNICODE_REPLACEMENT_CHARACTER_CODEPOINT]) {
  var source = (ListRange(utf16CodeUnits, offset, length)).iterator;
  var decoder =
      Utf16CodeUnitDecoder.fromListRangeIterator(source, replacementCodepoint);
  // var codepoints = List<int>(source.remaining);
  var codepoints = List<int>.generate(source.remaining,(e)=>0);
  var i = 0;
  while (decoder.moveNext()) {
    codepoints[i++] = decoder.current;
  }
  if (i == codepoints.length) {
    return codepoints;
  } else {
    // var codepointTrunc = List<int>(i);
    var codepointTrunc = List<int>.generate(i,(e)=>0);
    codepointTrunc.setRange(0, i, codepoints);
    return codepointTrunc;
  }
}

/// Encode code points as UTF16 code units.
List<int> codepointsToUtf16CodeUnits(List<int> codepoints,int length,
    [int offset = 0,

    int replacementCodepoint = UNICODE_REPLACEMENT_CHARACTER_CODEPOINT]) {
  var listRange = ListRange(codepoints, offset, length);
  var encodedLength = 0;
  for (var value in listRange) {
    if ((value >= 0 && value < UNICODE_UTF16_RESERVED_LO) ||
        (value > UNICODE_UTF16_RESERVED_HI && value <= UNICODE_PLANE_ONE_MAX)) {
      encodedLength++;
    } else if (value > UNICODE_PLANE_ONE_MAX &&
        value <= UNICODE_VALID_RANGE_MAX) {
      encodedLength += 2;
    } else {
      encodedLength++;
    }
  }

  // var codeUnitsBuffer = List<int>(encodedLength);
  var codeUnitsBuffer = List<int>.generate(encodedLength,(e)=>0);
  var j = 0;
  for (var value in listRange) {
    if ((value >= 0 && value < UNICODE_UTF16_RESERVED_LO) ||
        (value > UNICODE_UTF16_RESERVED_HI && value <= UNICODE_PLANE_ONE_MAX)) {
      codeUnitsBuffer[j++] = value;
    } else if (value > UNICODE_PLANE_ONE_MAX &&
        value <= UNICODE_VALID_RANGE_MAX) {
      var base = value - UNICODE_UTF16_OFFSET;
      codeUnitsBuffer[j++] = UNICODE_UTF16_SURROGATE_UNIT_0_BASE +
          ((base & UNICODE_UTF16_HI_MASK) >> 10);
      codeUnitsBuffer[j++] =
          UNICODE_UTF16_SURROGATE_UNIT_1_BASE + (base & UNICODE_UTF16_LO_MASK);
    } else if (replacementCodepoint != null) {
      codeUnitsBuffer[j++] = replacementCodepoint;
    } else {
      throw ArgumentError('Invalid encoding');
    }
  }
  return codeUnitsBuffer;
}
