class HilalData {
  final double elongationGeo;
  final double elongationTopo;

  final double crescentWidthGeo;
  final double crescentWidthTopo;

  final double relativeAltitudeGeo;
  final double relativeAltitudeTopo;

  final double qOdeh;
  final double bestTime;

  final double imkanMabimsStatus;
  final double imkanTurkiStatus;
  final double wujudHilalStatus;

  //final double awalBulanJD;

  HilalData({
    required this.elongationGeo,
    required this.elongationTopo,
    required this.crescentWidthGeo,
    required this.crescentWidthTopo,
    required this.relativeAltitudeGeo,
    required this.relativeAltitudeTopo,
    required this.qOdeh,
    required this.bestTime,
    required this.imkanMabimsStatus,
    required this.imkanTurkiStatus,
    required this.wujudHilalStatus,
    //required this.awalBulanJD,
  });
}
