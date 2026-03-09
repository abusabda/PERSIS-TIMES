class EclipseContact {
  final double? jd;
  final double? azimuth;
  final double? altitude;

  const EclipseContact({this.jd, this.azimuth, this.altitude});
}

class EclipseEphemeris {
  final EclipseEphemerisBody? sun;
  final EclipseEphemerisBody? moon;

  const EclipseEphemeris({this.sun, this.moon});
}

class EclipseEphemerisBody {
  final double? ra;
  final double? dec;
  final double? sd;
  final double? hp;

  const EclipseEphemerisBody({this.ra, this.dec, this.sd, this.hp});
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
