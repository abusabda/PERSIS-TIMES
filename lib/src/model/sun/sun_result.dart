class SunResult {
  final double jd;
  final double deltaT;

  // ==========================
  // GEOCENTRIC
  // ==========================

  // Longitude & Latitude
  final double geoLongitudeTrue;
  final double geoLongitudeApparent;
  final double geoLatitudeTrue;
  final double geoLatitudeApparent;

  // Distance
  final double geoDistanceKm;
  final double geoDistanceAu;
  final double geoDistanceEr;

  // Equatorial coordinates
  final double geoRightAscensionApparent;
  final double geoDeclinationApparent;

  // Hour angles
  final double geoGreenwichHourAngleApparent;
  final double geoLocalHourAngleApparent;

  // Horizontal coordinates
  final double geoAzimuthApparent;
  final double geoAltitudeApparent;

  // Parallax & semidiameter
  final double geoHorizontalParallax;
  final double geoSemidiameter;

  // ==========================
  // TOPOCENTRIC
  // ==========================
  // === Apparent Topocentric Coordinates ===
  final double topoLongitudeApparent;
  final double topoLatitudeApparent;
  final double topoRightAscensionApparent;
  final double topoDeclinationApparent;
  final double topoGreenwichHourAngleApparent;
  final double topoLocalHourAngleApparent;
  final double topoSemidiameterApparent;
  final double topoAzimuthApparent;

  // === Airless Topocentric Altitude ===
  final double topoAltitudeUpperAirless;
  final double topoAltitudeCenterAirless;
  final double topoAltitudeLowerAirless;

  // === Apparent Topocentric Altitude ===
  final double topoAltitudeUpperApparent;
  final double topoAltitudeCenterApparent;
  final double topoAltitudeLowerApparent;

  // === Observed Topocentric Altitude ===
  final double topoAltitudeUpperObserved;
  final double topoAltitudeCenterObserved;
  final double topoAltitudeLowerObserved;

  // === Sun-Moon Apparent Elongation (Topocentric) ===
  //final double topoSunElongationApparent;

  SunResult({
    required this.jd,
    required this.deltaT,

    required this.geoLongitudeTrue,
    required this.geoLongitudeApparent,
    required this.geoLatitudeTrue,
    required this.geoLatitudeApparent,

    required this.geoDistanceKm,
    required this.geoDistanceAu,
    required this.geoDistanceEr,

    required this.geoRightAscensionApparent,
    required this.geoDeclinationApparent,

    required this.geoGreenwichHourAngleApparent,
    required this.geoLocalHourAngleApparent,

    required this.geoAzimuthApparent,
    required this.geoAltitudeApparent,

    required this.geoHorizontalParallax,
    required this.geoSemidiameter,

    required this.topoLongitudeApparent,
    required this.topoLatitudeApparent,

    required this.topoRightAscensionApparent,
    required this.topoDeclinationApparent,

    required this.topoGreenwichHourAngleApparent,
    required this.topoLocalHourAngleApparent,
    required this.topoSemidiameterApparent,

    required this.topoAzimuthApparent,

    required this.topoAltitudeUpperAirless,
    required this.topoAltitudeCenterAirless,
    required this.topoAltitudeLowerAirless,

    required this.topoAltitudeUpperApparent,
    required this.topoAltitudeCenterApparent,
    required this.topoAltitudeLowerApparent,

    required this.topoAltitudeUpperObserved,
    required this.topoAltitudeCenterObserved,
    required this.topoAltitudeLowerObserved,
  });
}
