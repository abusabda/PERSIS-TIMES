import 'package:myhisab/src/model/lunar_eclipse/lunar_besselian_result.dart';
import 'package:myhisab/src/model/helper_eclipse/helper_eclipse.dart';

class LunarEclipseGlobalResult {
  final bool isValid;

  final double? p1;
  final double? u1;
  final double? u2;
  final double? mx;
  final double? u3;
  final double? u4;
  final double? p4;

  final double? durasiPenumbral;
  final double? durasiUmbral;
  final double? durasiTotal;

  final double? magnitudePenumbral;
  final double? magnitudeUmbral;

  final double? radiusPenumbral;
  final double? radiusUmbral;

  final LunarBesselianResult? besselian;

  final EclipseEphemerisBody? sun; // ⬅️ WAJIB nullable
  final EclipseEphemerisBody? moon; // ⬅️ WAJIB nullable

  final String jenis;

  const LunarEclipseGlobalResult({
    required this.isValid,

    required this.p1,
    required this.u1,
    required this.u2,
    required this.mx,
    required this.u3,
    required this.u4,
    required this.p4,

    required this.durasiPenumbral,
    required this.durasiUmbral,
    required this.durasiTotal,
    required this.magnitudePenumbral,
    required this.magnitudeUmbral,
    required this.radiusPenumbral,
    required this.radiusUmbral,

    this.besselian,

    this.sun,
    this.moon,

    required this.jenis,
  });
}
