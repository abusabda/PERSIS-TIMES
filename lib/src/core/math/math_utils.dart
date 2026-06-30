import 'dart:math';
import '../math/safe_math.dart';

class MathFunction {
  // Konversi sudut
  double deg(double x) => x * 180.0 / pi;
  double rad(double x) => x * pi / 180.0;

  // Modulus
  double mod(double a, double m) {
    // 🔴 GUARD: NaN/Infinity check
    if (!SafeMath.isValid(a) || !SafeMath.isValid(m) || m == 0) {
      return 0.0;
    }

    // Original logic dengan SafeMath
    final quotient = SafeMath.safeDiv(a, m);
    return a - m * quotient.floor();
  }

  //double floor(double x) => (x).floorToDouble();
  double floor(double value) {
    if (!SafeMath.isValid(value)) return 0.0;
    return value.floorToDouble();
  }

  double abs(double x) => (x).abs();

  // Sign
  int sign(double x) => (x > 0) ? 1 : (x < 0 ? -1 : 0);

  // Pembulatan umum (seperti extension round di Kotlin)
  String roundDouble(double value, int decimals) {
    return value.toStringAsFixed(decimals);
  }

  double trunc(double value, [int decimals = 2]) {
    final num mod = pow(10.0, decimals);
    return (value * mod).truncateToDouble() / mod;
  }

  // Pembulatan manual ala RoundTo
  String roundTo(double xDec, {int place = 2}) {
    final A = pow(10.0, place.toDouble());
    final H = (xDec >= 0)
        ? floor(xDec * A + 0.5) / A
        : -floor(abs(xDec) * A + 0.5) / A;
    return H.toString();
  }

  double roundUp(double value, int decimals) {
    final mod = pow(10.0, decimals);
    return (value * mod).ceil() / mod;
  }

  // Format jam HH:MM:SS
  String dhhms(
    double dHrs, {
    String optResult = "HH:MM:SS",
    int secDecPlaces = 2,
    String posNegSign = "",
  }) {
    final uDHrs = abs(dHrs);
    double uHrs = floor(uDHrs);
    final uDMin = (uDHrs - uHrs) * 60.0;
    double uMin = floor(uDMin);
    final uDSec = (uDMin - uMin) * 60.0;

    // format detik dengan jumlah desimal sesuai
    String uSec = uDSec.toStringAsFixed(secDecPlaces);

    // koreksi jika detik = 60.0
    if (double.parse(uSec) == 60.0) {
      uSec = 0.0.toStringAsFixed(secDecPlaces);
      uMin += 1.0;
    }

    // koreksi jika menit = 60
    if (uMin == 60.0) {
      uMin = 0.0;
      uHrs += 1.0;
    }

    final sHrs = uHrs.toInt() < 10 ? "0${uHrs.toInt()}" : "${uHrs.toInt()}";
    final sMin = uMin.toInt() < 10 ? "0${uMin.toInt()}" : "${uMin.toInt()}";
    final sSec = double.parse(uSec) < 10.0 ? "0$uSec" : uSec;

    // tanda positif/negatif
    String pns;
    if (posNegSign == "+-") {
      if (dHrs > 0.0) {
        pns = "+";
      } else if (dHrs < 0.0) {
        pns = "-";
      } else {
        pns = "";
      }
    } else {
      if (dHrs < 0.0) {
        pns = "-";
      } else {
        pns = "";
      }
    }

    switch (optResult) {
      case "HH:MM:SS":
        return "$pns$sHrs:$sMin:$sSec";
      case "HHMMSS":
        return "$pns${sHrs}h ${sMin}m ${sSec}s";
      case "MMSS":
        return "$pns${sMin}m ${sSec}s";
      case "HH:MM":
        return "$pns$sHrs:$sMin";
      default:
        return "$pns$sHrs:$sMin:$sSec";
    }
  }

  String dhhm(
    double dHrs, {
    String optResult = "HH:MM",
    int minDecPlaces = 0,
    String posNegSign = "",
  }) {
    final isNeg = dHrs < 0;
    final uDHrs = dHrs.abs();

    int hrs = uDHrs.floor();
    final decMin = (uDHrs - hrs) * 60.0;

    final double minsRounded = minDecPlaces == 0
        ? decMin.round().toDouble()
        : double.parse(decMin.toStringAsFixed(minDecPlaces));

    int hrs2 = hrs;
    double mins = minsRounded;
    if (mins >= 60) {
      mins -= 60;
      hrs2 += 1;
    }

    final sHrs = hrs2.toString().padLeft(2, '0');
    final sMin = minDecPlaces == 0
        ? mins.toInt().toString().padLeft(2, '0')
        : mins.toStringAsFixed(minDecPlaces).padLeft(2 + 1 + minDecPlaces, '0');

    String pns = "";
    if (posNegSign == "+-") {
      if (dHrs > 0) pns = "+";
      if (dHrs < 0) pns = "-";
    } else {
      if (isNeg) pns = "-";
    }

    switch (optResult) {
      case "HH:MM":
        return "$pns$sHrs:$sMin";
      case "HHMM":
        return "$pns${sHrs}h ${sMin}m";
      default:
        return "$pns$sHrs:$sMin";
    }
  }

  // // Format derajat DD°MM'SS"
  // String dddms(
  //   double dDeg, {
  //   String optResult = "DDMMSS",
  //   int sdp = 2,
  //   String posNegSign = "+-",
  // }) {
  //   final double uDDeg = abs(dDeg);
  //   double uDeg = floor(uDDeg);
  //   final double uDMin = (uDDeg - uDeg) * 60.0;
  //   double uMin = floor(uDMin);
  //   final double uDSec = (uDMin - uMin) * 60.0;
  //   String uSec = uDSec.toStringAsFixed(sdp);

  //   if (double.parse(uSec) == 60.0) {
  //     uSec = 0.0.toStringAsFixed(sdp);
  //     uMin = uMin + 1.0;
  //   }

  //   if (uMin == 60.0) {
  //     uMin = 0.0;
  //     uDeg = uDeg + 1.0;
  //   }

  //   final String sDeg = (uDeg.toInt() < 10)
  //       ? "00${uDeg.toInt()}"
  //       : (uDeg.toInt() < 100)
  //       ? "0${uDeg.toInt()}"
  //       : "${uDeg.toInt()}";

  //   final String sMin = (uMin.toInt() < 10)
  //       ? "0${uMin.toInt()}"
  //       : "${uMin.toInt()}";

  //   final String sSec = (double.parse(uSec) < 10.0) ? "0$uSec" : uSec;

  //   // --- PNS sesuai aturan PosNegSign ---
  //   final String pns;
  //   if (posNegSign == "+-") {
  //     if (dDeg > 0.0) {
  //       pns = "+";
  //     } else if (dDeg < 0.0) {
  //       pns = "-";
  //     } else {
  //       pns = "";
  //     }
  //   } else {
  //     if (dDeg > 0.0) {
  //       pns = "";
  //     } else if (dDeg < 0.0) {
  //       pns = "-";
  //     } else {
  //       pns = "";
  //     }
  //   }

  //   final String bbbt;
  //   final String luls;

  //   if (dDeg > 0.0) {
  //     bbbt = "BT";
  //     luls = "LU";
  //   } else {
  //     bbbt = "BB";
  //     luls = "LS";
  //   }

  //   switch (optResult) {
  //     case "DDMMSS":
  //       return "$pns$sDeg° $sMin’ $sSec”";
  //     case "MMSS":
  //       return "$pns$sMin’ $sSec”";
  //     case "SS":
  //       return "$pns$sSec”";
  //     case "BBBT":
  //       return "$pns$sDeg° $sMin’ $sSec” $bbbt";
  //     case "LULS":
  //       return "$pns$sDeg° $sMin’ $sSec” $luls";
  //     default:
  //       return "$pns$sDeg° $sMin’ $sSec”";
  //   }
  // }

  /// Mengonversi Desimal Derajat (Decimal Degrees) ke format Derajat, Menit, Detik (DMS).
  ///
  /// [xDecDeg] Nilai desimal derajat (misal: -106.8456).
  /// [optResult] Format keluaran (contoh: 'DMMSS', '[D]', 'DMS', dll). Default: 'DMMSS'.
  /// [secDetPlaces] Jumlah desimal untuk detik. Default: 3.
  /// [posNegSign] Penanda arah/tanda (contoh: 'LON', 'LAT', 'B', '+/-', dll). Default: ''.
  ///
  /// Memerlukan Dart 3.0+ untuk sintaks Switch Expression.
  String dddms(
    double xDecDeg, {
    String optResult = '',
    int? sdp,
    String posNegSign = '',
  }) {
    // 1. Hitung komponen absolut
    final absDecDeg = xDecDeg.abs();
    double absDeg = absDecDeg.floorToDouble();
    double absDecMin = (absDecDeg - absDeg) * 60.0;
    double absMin = absDecMin.floorToDouble();
    double absDecSec = (absDecMin - absMin) * 60.0;

    // 2. Validasi jumlah desimal detik
    int places = sdp ?? 3;
    if (places.abs() > 16) places = 3;
    places = places.abs();

    // 3. Format & bulatkan detik
    final secStrFixed = absDecSec.toStringAsFixed(places);
    double absSec = double.parse(secStrFixed);

    // 4. Koreksi rollover
    if (absSec == 60.0) {
      absSec = 0.0;
      absMin += 1;
    }
    if (absMin == 60.0) {
      absMin = 0.0;
      absDeg += 1;
    }

    // 5. Tentukan prefix & suffix
    String pns = '';
    String lls = '';
    final cleanPosNeg = posNegSign.replaceAll(' ', '').toUpperCase();

    switch (cleanPosNeg) {
      case '':
        pns = xDecDeg >= 0 ? '' : '-';
      case '+/-' || '-/+' || '+-' || '-+':
        pns = xDecDeg >= 0 ? '+' : '-';
      case 'B' || 'BUJUR':
        lls = xDecDeg >= 0 ? ' BT' : ' BB';
      case 'L' || 'LINTANG':
        lls = xDecDeg >= 0 ? ' LU' : ' LS';
      case 'LON' || 'LONG' || 'LONGITUDE':
        lls = xDecDeg >= 0 ? 'E' : 'W';
      case 'LAT' || 'LATITUDE':
        lls = xDecDeg >= 0 ? 'N' : 'S';
      default:
        pns = xDecDeg >= 0 ? '' : '-';
    }

    // Pre-compute formatting
    final deg0 = absDeg.toInt().toString();
    final deg00 = deg0.padLeft(2, '0');
    final deg000 = deg0.padLeft(3, '0');
    final min0 = absMin.toInt().toString();
    final min00 = min0.padLeft(2, '0');

    //lebar padding dinamis
    final secWidth = places == 0 ? 2 : places + 3;
    final sec00x = secStrFixed.padLeft(secWidth, '0');

    // 6. Mapping format hasil
    final cleanOpt = optResult.replaceAll(' ', '').toUpperCase();

    final result = switch (cleanOpt) {
      '' || 'DMMSS' => '$pns$deg0° $min00’ $sec00x”$lls',
      'DDMMSS' => '$pns$deg00° $min00’ $sec00x”$lls',
      'DDDMMSS' => '$pns$deg000° $min00’ $sec00x”$lls',
      '[D]' => '$pns$deg0',
      '[M]' => '$pns$min0',
      '[S]' => '$pns$secStrFixed',
      'D' => '$pns$deg0° $lls',
      'M' => '$pns$min0’ $lls',
      'S' => '$pns$secStrFixed”$lls',
      'MSS' => '$pns$min0’ $sec00x”$lls',
      'DMM' => '$pns$deg0° $min00’ $lls',
      'DDMM' => '$pns$deg00° $min00’ $lls',
      'DDDMM' => '$pns$deg000° $min00’ $lls',
      'DD' => '$pns$deg00° $lls',
      'DDD' => '$pns$deg000° $lls',
      'MM' => '$pns$min00’ $lls',
      'MMSS' => '$pns$min00’ $sec00x”$lls',
      'MS' => '$pns$min0’ $secStrFixed”$lls',
      'SS' => '$pns$sec00x”$lls',
      'DM' => '$pns$deg0° $min0’ $lls',
      'DMS' => '$pns$deg0° $min0’ $secStrFixed”$lls',
      _ => '$pns$deg0° $min00’ $sec00x”$lls',
    };

    return result;
  }

  // Format derajat versi 2 (DDDMS2)
  String dddms2(
    double dDeg, {
    String optResult = "DDMMSS",
    int sdp = 2,
    String posNegSign = "", // "" atau "+-"
  }) {
    // Nilai absolut untuk dihitung
    final double uDDeg = abs(dDeg);

    // Derajat
    String uDeg = floor(uDDeg).toStringAsFixed(0);

    // Menit
    double uDMin = (uDDeg - double.parse(uDeg)) * 60.0;
    String uMin = floor(uDMin).toStringAsFixed(0);

    // Detik
    double uDSec = (uDMin - double.parse(uMin)) * 60.0;
    String uSec = uDSec.toStringAsFixed(sdp);

    // Koreksi pembulatan detik -> menit
    if (double.parse(uSec) == 60.0) {
      uSec = 0.0.toStringAsFixed(sdp);
      uMin = (double.parse(uMin) + 1.0).toStringAsFixed(0);
    }

    // Koreksi pembulatan menit -> derajat
    if (double.parse(uMin) == 60.0) {
      uMin = "0";
      uDeg = (double.parse(uDeg) + 1.0).toStringAsFixed(0);
    }

    // Tanda Positif/Negatif sesuai pilihan
    final String pns;
    if (posNegSign == "+-") {
      if (dDeg > 0.0) {
        pns = "+";
      } else if (dDeg < 0.0) {
        pns = "-";
      } else {
        pns = "";
      }
    } else {
      if (dDeg > 0.0) {
        pns = "";
      } else if (dDeg < 0.0) {
        pns = "-";
      } else {
        pns = "";
      }
    }

    // BT/BB dan LU/LS
    final String bbbt = (dDeg > 0.0) ? "BT" : "BB";
    final String luls = (dDeg > 0.0) ? "LU" : "LS";

    // Hasil sesuai OptResult
    switch (optResult) {
      case "DDMMSS":
        return "$pns$uDeg° $uMin’ $uSec”";
      case "MMSS":
        return "$pns$uMin’ $uSec”";
      case "SS":
        return "$pns$uSec”";
      case "BBBT":
        return "$pns$uDeg° $uMin’ $uSec” $bbbt";
      case "LULS":
        return "$pns$uDeg° $uMin’ $uSec” $luls";
      default:
        return "$pns$uDeg° $uMin’ $uSec”";
    }
  }

  // interpolation From Five Tabular Values
  double interp5(
    double xM2,
    double xM1,
    double x00,
    double xP1,
    double xP2,
    int optResult,
  ) {
    final A = xM1 - xM2;
    final B = x00 - xM1;
    final C = xP1 - x00;
    final D = xP2 - xP1;

    final E = B - A;
    final F = C - B;
    final G = D - C;
    final H = F - E;
    final J = G - F;
    final K = J - H;

    switch (optResult) {
      case 0:
        return x00;
      case 1:
        return ((B + C) / 2 - (H + J) / 12);
      case 2:
        return (F / 2 - K / 24);
      case 3:
        return ((H + J) / 12);
      case 4:
        return (K / 24);
      default:
        return x00;
    }
  }

  // interpolation From Five Tabular Values
  double interp5Angle(
    double xM2,
    double xM1,
    double x00,
    double xP1,
    double xP2,
    int optResult,
  ) {
    final A = mod(xM1 - xM2, 360);
    final B = mod(x00 - xM1, 360);
    final C = mod(xP1 - x00, 360);
    final D = mod(xP2 - xP1, 360);

    final E = B - A;
    final F = C - B;
    final G = D - C;
    final H = F - E;
    final J = G - F;
    final K = J - H;

    switch (optResult) {
      case 0:
        return x00;
      case 1:
        return ((B + C) / 2 - (H + J) / 12);
      case 2:
        return (F / 2 - K / 24);
      case 3:
        return ((H + J) / 12);
      case 4:
        return (K / 24);
      default:
        return x00;
    }
  }

  double? safeNum(dynamic v) {
    if (v == null) return null;
    if (v is num) {
      if (v.isNaN || v.isInfinite) return null;
      return v.toDouble();
    }
    return null;
  }
}
