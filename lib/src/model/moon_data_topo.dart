class MoonDataTopo {
  final double longitudeApparent;
  final double latitudeApparent;

  final double rightAscension;
  final double declination;

  final double greenwichHourAngle;
  final double localHourAngle;
  final double horizontalParallax;
  final double semidiameter;

  final double azimuth;

  final double altitudeAirlessUpper;
  final double altitudeAirlessCenter;
  final double altitudeAirlessLower;

  final double altitudeApparentUpper;
  final double altitudeApparentCenter;
  final double altitudeApparentLower;

  final double altitudeObservedUpper;
  final double altitudeObservedCenter;
  final double altitudeObservedLower;

  final double phaseAngle;
  final double diskIlluminationFraction;
  final double brightLimbAngle;

  MoonDataTopo({
    required this.longitudeApparent,
    required this.latitudeApparent,

    required this.rightAscension,
    required this.declination,

    required this.greenwichHourAngle,
    required this.localHourAngle,
    required this.horizontalParallax,
    required this.semidiameter,

    required this.azimuth,
    required this.altitudeAirlessUpper,
    required this.altitudeAirlessCenter,
    required this.altitudeAirlessLower,
    required this.altitudeApparentUpper,
    required this.altitudeApparentCenter,
    required this.altitudeApparentLower,
    required this.altitudeObservedUpper,
    required this.altitudeObservedCenter,
    required this.altitudeObservedLower,

    required this.phaseAngle,
    required this.diskIlluminationFraction,
    required this.brightLimbAngle,
  });
}
