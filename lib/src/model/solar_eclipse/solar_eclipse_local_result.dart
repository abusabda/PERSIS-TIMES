import 'package:myhisab/src/model/solar_eclipse/solar_besselian_result.dart';
import 'package:myhisab/src/model/helper_eclipse/helper_eclipse.dart';

class SolarEclipseLocalResult {
  final bool ada;
  final String? keterangan;

  final SolarBesselianResult besselian;

  final EclipseContact? u1;
  final EclipseContact? u2;
  final EclipseContact? mx;
  final EclipseContact? u3;
  final EclipseContact? u4;

  final EclipseEphemeris? ephemerisMaximum;

  final double? magnitude;
  final double? obscuration;
  final String? jenis;

  final double? deltaT; // ← TAMBAHKAN INI

  final double? durasiGerhana;
  final double? durasiTotalitas;

  const SolarEclipseLocalResult({
    required this.ada,
    required this.besselian,
    this.keterangan,
    this.u1,
    this.u2,
    this.mx,
    this.u3,
    this.u4,
    this.ephemerisMaximum,
    this.magnitude,
    this.obscuration,
    this.jenis,
    this.durasiGerhana,
    this.durasiTotalitas,
    this.deltaT,
  });
}

// class EclipseContact {
//   final double? jd;
//   final double? azimuth;
//   final double? altitude;

//   const EclipseContact({this.jd, this.azimuth, this.altitude});
// }

// class EclipseEphemeris {
//   final EclipseEphemerisBody? sun;
//   final EclipseEphemerisBody? moon;

//   const EclipseEphemeris({this.sun, this.moon});
// }

// class EclipseEphemerisBody {
//   final double? ra;
//   final double? dec;
//   final double? sd;
//   final double? hp;

//   const EclipseEphemerisBody({this.ra, this.dec, this.sd, this.hp});
// }

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
