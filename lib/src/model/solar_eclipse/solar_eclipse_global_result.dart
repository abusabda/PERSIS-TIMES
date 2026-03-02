import 'package:myhisab/src/model/solar_eclipse/solar_besselian_result.dart';

class SolarEclipseGlobalResult {
  final bool ada;
  final String? keterangan;

  final SolarBesselianResult besselian;
  final EclipseContactGlobal? p1;
  final EclipseContactGlobal? u1;
  final EclipseContactGlobal? c1;
  final EclipseContactGlobal? u2;
  final EclipseContactGlobal? p2;
  final EclipseContactGlobal? mx;
  final EclipseContactGlobal? p3;
  final EclipseContactGlobal? u3;
  final EclipseContactGlobal? c2;
  final EclipseContactGlobal? u4;
  final EclipseContactGlobal? p4;

  final EclipseEphemerisGlobal? ephemerisMaximum;

  final double? magnitude;
  final String? jenis;

  final double? durasiGerhana;
  final double? durasiTotalitas;
  final double? lebar;

  const SolarEclipseGlobalResult({
    required this.ada,
    required this.besselian,
    this.keterangan,
    this.p1,
    this.u1,
    this.c1,
    this.u2,
    this.p2,
    this.mx,
    this.p3,
    this.u3,
    this.c2,
    this.u4,
    this.p4,
    this.ephemerisMaximum,
    this.magnitude,
    this.jenis,
    this.durasiGerhana,
    this.durasiTotalitas,
    this.lebar,
  });
}

class EclipseContactGlobal {
  final double? jd;
  final double? jd2;
  final double? longitude;
  final double? latitude;
  final double? azimuth;
  final double? altitude;

  const EclipseContactGlobal({
    this.jd,
    this.jd2,
    this.longitude,
    this.latitude,
    this.azimuth,
    this.altitude,
  });
}

class EclipseEphemerisGlobal {
  final EclipseEphemerisBodyGlobal? sun;
  final EclipseEphemerisBodyGlobal? moon;

  const EclipseEphemerisGlobal({this.sun, this.moon});
}

class EclipseEphemerisBodyGlobal {
  final double? ra;
  final double? dec;
  final double? sd;
  final double? hp;

  const EclipseEphemerisBodyGlobal({this.ra, this.dec, this.sd, this.hp});
}

// class BesselianElement {
//   final List<double>? x;
//   final List<double>? y;
//   final List<double>? d;
//   final List<double>? mu;
//   final List<double>? l1;
//   final List<double>? l2;
//   final double? tanf1;
//   final double? tanf2;

//   const BesselianElement({
//     this.x,
//     this.y,
//     this.d,
//     this.mu,
//     this.l1,
//     this.l2,
//     this.tanf1,
//     this.tanf2,
//   });
//}
