import 'package:myhisab/src/model/lunar_eclipse/lunar_besselian_result.dart';
import 'package:myhisab/src/model/helper_eclipse/helper_eclipse.dart';

class LunarEclipseLocalResult {
  final bool isValid;
  final bool ada;

  final double? p1;
  final double? u1;
  final double? u2;
  final double? mx;
  final double? u3;
  final double? u4;
  final double? p4;

  final double? azmP1;
  final double? azmU1;
  final double? azmU2;
  final double? azmMx;
  final double? azmU3;
  final double? azmU4;
  final double? azmP4;

  final double? altP1;
  final double? altU1;
  final double? altU2;
  final double? altMx;
  final double? altU3;
  final double? altU4;
  final double? altP4;

  final double? durasiPenumbral;
  final double? durasiUmbral;
  final double? durasiTotal;
  final double? magnitudePenumbral;
  final double? magnitudeUmbral;
  final double? radiusPenumbral;
  final double? radiusUmbral;

  final double? deltaT;

  final LunarBesselianResult? besselian;

  final EclipseEphemerisBody? sun; // ⬅️ WAJIB nullable
  final EclipseEphemerisBody? moon; // ⬅️ WAJIB nullable

  final String jenis;

  const LunarEclipseLocalResult({
    required this.isValid,
    required this.ada,

    this.p1,
    this.u1,
    this.u2,
    this.mx,
    this.u3,
    this.u4,
    this.p4,

    this.azmP1,
    this.azmU1,
    this.azmU2,
    this.azmMx,
    this.azmU3,
    this.azmU4,
    this.azmP4,

    this.altP1,
    this.altU1,
    this.altU2,
    this.altMx,
    this.altU3,
    this.altU4,
    this.altP4,

    this.durasiPenumbral,
    this.durasiUmbral,
    this.durasiTotal,
    this.magnitudePenumbral,
    this.magnitudeUmbral,
    this.radiusPenumbral,
    this.radiusUmbral,

    this.besselian,
    this.deltaT,

    this.sun,
    this.moon,

    required this.jenis,
  });
}
