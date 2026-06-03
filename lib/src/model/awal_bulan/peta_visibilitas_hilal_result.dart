class PetaVisibilitasHilalResult {
  final double geojdIjtimak;
  final double sunsetJD;

  // Parameter dasar
  final double elongGeo;
  final double elongasi;
  final double arcv;
  final double daz;
  final double crescentWidth;
  final double moonAltitude;
  final double moonTopoAltitudeObsCenter;
  final double moonGeoAltitude;
  final double moonLowerLimbAltitude;

  // Kriteria Odeh
  final double qOdeh;
  final String zonaOdeh;

  // Kriteria Yallop
  final double wPrime;
  final double qYallop;
  final String zonaYallop;

  // Kriteria SAAO
  final double dalt1;
  final double dalt2;
  final String saaoStatus;

  // Kriteria Maunder
  final double maunderMinimum;
  final bool maunderVisible;

  // Kriteria Bruin
  final double bruinMinimum;
  final bool bruinVisible;

  // Kriteria IR MABIMS
  final bool mabimsVisible;
  final String mabimsStatus;

  // Kriteria Turki/KHGT
  final bool turkiVisible;
  final String turkiStatus;

  PetaVisibilitasHilalResult({
    required this.geojdIjtimak,
    required this.sunsetJD,
    required this.elongGeo,
    required this.elongasi,
    required this.arcv,
    required this.daz,
    required this.crescentWidth,
    required this.moonAltitude,
    required this.moonTopoAltitudeObsCenter,
    required this.moonGeoAltitude,
    required this.moonLowerLimbAltitude,
    required this.qOdeh,
    required this.zonaOdeh,
    required this.wPrime,
    required this.qYallop,
    required this.zonaYallop,
    required this.dalt1,
    required this.dalt2,
    required this.saaoStatus,
    required this.maunderMinimum,
    required this.maunderVisible,
    required this.bruinMinimum,
    required this.bruinVisible,
    required this.mabimsVisible,
    required this.mabimsStatus,
    required this.turkiVisible,
    required this.turkiStatus,
  });
}
