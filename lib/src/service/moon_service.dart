import 'package:myhisab/src/core/astronomy/dynamical_time.dart';
import 'package:myhisab/src/core/astronomy/julian_day.dart';
import 'package:myhisab/src/core/astronomy/moon_function.dart';
import 'package:myhisab/src/core/astronomy/moon_longitude.dart';
import 'package:myhisab/src/core/astronomy/moon_latitude.dart';
import 'package:myhisab/src/core/astronomy/moon_distance.dart';
import 'package:myhisab/src/model/moon_result.dart';

class MoonService {
  final JulianDay _julianDay = JulianDay();
  final DynamicalTime _dynamicalTime = DynamicalTime();
  final MoonLongitude _moonLon = MoonLongitude();
  final MoonLatitude _moonLat = MoonLatitude();
  final MoonDistance _moonDis = MoonDistance();
  final MoonFunction _moonData = MoonFunction();

  MoonResult calculate({
    required int tglM,
    required int blnM,
    required int thnM,
    required int jam,
    required int menit,
    required int detik,
    required double gLon,
    required double gLat,
    required double elev,
    required double tmZn,
    required double temp,
    required double pres,
  }) {
    final jamDes = jam + (menit / 60.0) + (detik / 3600.0);

    final jd = _julianDay.kmjd(tglM, blnM, thnM, jamDes, tmZn);
    final dt = _dynamicalTime.deltaT(jd);

    return MoonResult(
      jd: jd,
      deltaT: dt,

      // ==========================
      // GEOCENTRIC
      // ==========================
      geoLongitudeTrue: _moonLon.moonGeocentricLongitude(jd, dt, "True"),

      geoLongitudeApparent: _moonLon.moonGeocentricLongitude(jd, dt, "Appa"),

      geoLatitudeTrue: _moonLat.moonGeocentricLatitude(jd, dt, "True"),

      geoLatitudeApparent: _moonLat.moonGeocentricLatitude(jd, dt, "Appa"),

      geoDistanceKm: _moonDis.moonGeocentricDistance(jd, dt, "KM"),

      geoDistanceAu: _moonDis.moonGeocentricDistance(jd, dt, "AU"),

      geoDistanceEr: _moonDis.moonGeocentricDistance(jd, dt, "ER"),

      geoRightAscensionApparent: _moonData.moonGeocentricRightAscension(jd, dt),

      geoDeclinationApparent: _moonData.moonGeocentricDeclination(jd, dt),

      geoGreenwichHourAngleApparent: _moonData.moonGeocentricGreenwichHourAngle(
        jd,
        dt,
      ),

      geoLocalHourAngleApparent: _moonData.moonGeocentricLocalHourAngel(
        jd,
        dt,
        gLon,
      ),

      geoAzimuthApparent: _moonData.moonGeocentricAzimuth(jd, dt, gLon, gLat),

      geoAltitudeApparent: _moonData.moonGeocentricAltitude(jd, dt, gLon, gLat),

      geoHorizontalParallax: _moonData.moonEquatorialHorizontalParallax(jd, dt),

      geoSemidiameter: _moonData.moonGeocentricSemidiameter(jd, dt),

      geoPhaseAngle: _moonData.moonGeocentricPhaseAngle(jd, dt),

      geoIlluminatedFraction: _moonData.moonGeocentricDiskIlluminatedFraction(
        jd,
        dt,
      ),

      geoBrightLimbAngle: _moonData.moonGeocentricBrightLimbAngle(jd, dt),

      geoSunElongation: _moonData.moonSunGeocentricElongation(jd, dt),

      // ==========================
      // TOPOCENTRIC
      // ==========================
      topoLongitudeApparent: _moonData.moonTopocentricLongitude(
        jd,
        dt,
        gLon,
        gLat,
        elev,
      ),

      topoLatitudeApparent: _moonData.moonTopocentricLatitude(
        jd,
        dt,
        gLon,
        gLat,
        elev,
      ),

      topoRightAscensionApparent: _moonData.moonTopocentricRightAscension(
        jd,
        dt,
        gLon,
        gLat,
        elev,
      ),

      topoDeclinationApparent: _moonData.moonTopocentricDeclination(
        jd,
        dt,
        gLon,
        gLat,
        elev,
      ),

      topoGreenwichHourAngleApparent: _moonData
          .moonTopocentricGreenwichHourAngle(jd, dt, gLon, gLat, elev),

      topoLocalHourAngleApparent: _moonData.moonTopocentricLocalHourAngel(
        jd,
        dt,
        gLon,
        gLat,
        elev,
      ),

      topoSemidiameterApparent: _moonData.moonTopocentricSemidiameter(
        jd,
        dt,
        gLon,
        gLat,
        elev,
      ),

      topoPhaseAngleApparent: _moonData.moonTopocentricPhaseAngle(
        jd,
        dt,
        gLon,
        gLat,
        elev,
      ),

      topoIlluminatedFractionApparent: _moonData
          .moonTopocentricDiskIlluminatedFraction(jd, dt, gLon, gLat, elev),

      topoBrightLimbAngleApparent: _moonData.moonTopocentricBrightLimbAngle(
        jd,
        dt,
        gLon,
        gLat,
        elev,
      ),

      topoAzimuthApparent: _moonData.moonTopocentricAzimuth(
        jd,
        dt,
        gLon,
        gLat,
        elev,
      ),

      // === Airless ===
      topoAltitudeUpperAirless: _moonData.moonTopocentricAltitude(
        jd,
        dt,
        gLon,
        gLat,
        elev,
        pres,
        temp,
        "htu",
      ),

      topoAltitudeCenterAirless: _moonData.moonTopocentricAltitude(
        jd,
        dt,
        gLon,
        gLat,
        elev,
        pres,
        temp,
        "htc",
      ),

      topoAltitudeLowerAirless: _moonData.moonTopocentricAltitude(
        jd,
        dt,
        gLon,
        gLat,
        elev,
        pres,
        temp,
        "htl",
      ),

      // === Apparent ===
      topoAltitudeUpperApparent: _moonData.moonTopocentricAltitude(
        jd,
        dt,
        gLon,
        gLat,
        elev,
        pres,
        temp,
        "htau",
      ),

      topoAltitudeCenterApparent: _moonData.moonTopocentricAltitude(
        jd,
        dt,
        gLon,
        gLat,
        elev,
        pres,
        temp,
        "htac",
      ),

      topoAltitudeLowerApparent: _moonData.moonTopocentricAltitude(
        jd,
        dt,
        gLon,
        gLat,
        elev,
        pres,
        temp,
        "htal",
      ),

      // === Observed ===
      topoAltitudeUpperObserved: _moonData.moonTopocentricAltitude(
        jd,
        dt,
        gLon,
        gLat,
        elev,
        pres,
        temp,
        "htou",
      ),

      topoAltitudeCenterObserved: _moonData.moonTopocentricAltitude(
        jd,
        dt,
        gLon,
        gLat,
        elev,
        pres,
        temp,
        "htoc",
      ),

      topoAltitudeLowerObserved: _moonData.moonTopocentricAltitude(
        jd,
        dt,
        gLon,
        gLat,
        elev,
        pres,
        temp,
        "htol",
      ),

      topoSunElongationApparent: _moonData.moonSunTopocentricElongation(
        jd,
        dt,
        gLon,
        gLat,
        elev,
      ),
    );
  }
}
