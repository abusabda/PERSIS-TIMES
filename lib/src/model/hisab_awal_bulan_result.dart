import 'package:myhisab/src/model/sun_data_geo.dart';
import 'package:myhisab/src/model/sun_data_topo.dart';
import 'package:myhisab/src/model/moon_data_geo.dart';
import 'package:myhisab/src/model/moon_data_topo.dart';
import 'package:myhisab/src/model/hilal_data.dart';

class HisabAwalBulanResult {
  final double jd;
  final double deltaT;

  final double geojdIjtimak;
  final double topojdIjtimak;

  final double sunsetJD;
  final double? moonsetJD;

  final double imkanMabimsStatus;
  final double imkanTurkiStatus;
  final double wujudHilalStatus;

  final SunDataGeo sunGeo;
  final SunDataTopo sunTopo;

  final MoonDataGeo moonGeo;
  final MoonDataTopo moonTopo;

  final HilalData hilal;

  HisabAwalBulanResult({
    required this.jd,
    required this.deltaT,
    required this.geojdIjtimak,
    required this.topojdIjtimak,
    required this.sunsetJD,
    this.moonsetJD,
    required this.imkanMabimsStatus,
    required this.imkanTurkiStatus,
    required this.wujudHilalStatus,
    required this.sunGeo,
    required this.sunTopo,
    required this.moonGeo,
    required this.moonTopo,
    required this.hilal,
  });
}
