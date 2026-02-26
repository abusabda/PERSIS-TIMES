class SunDataTopo {
  final double longitudeApparent;
  final double latitudeApparent;

  final double rightAscension;
  final double declination;

  final double azimuth;

  final double altitudeAirlessUpper;
  final double altitudeAirlessCenter;
  final double altitudeAirlessLower;

  final double altitudeApparentUpper;
  final double altitudeApparentCenter;
  final double altitudeApparentLower;

  final double altitudeObserveredUpper;
  final double altitudeObserveredCenter;
  final double altitudeObserveredLower;

  final double semidiameter;

  final double greenwichHourAngle;
  final double localHourAngle;

  SunDataTopo({
    required this.longitudeApparent,
    required this.latitudeApparent,
    required this.rightAscension,
    required this.declination,
    required this.azimuth,

    required this.altitudeAirlessUpper,
    required this.altitudeAirlessCenter,
    required this.altitudeAirlessLower,

    required this.altitudeApparentUpper,
    required this.altitudeApparentCenter,
    required this.altitudeApparentLower,

    required this.altitudeObserveredUpper,
    required this.altitudeObserveredCenter,
    required this.altitudeObserveredLower,

    required this.semidiameter,
    required this.greenwichHourAngle,
    required this.localHourAngle,
  });
}
