import 'package:myhisab/src/core/astronomy/dynamical_time.dart';
import 'package:myhisab/src/core/astronomy/julian_day.dart';
import 'package:myhisab/src/core/astronomy/sun_function.dart';
import 'package:myhisab/src/model/sun_result.dart';

class SunService {
  final JulianDay _julianDay = JulianDay();
  final DynamicalTime _dynamicalTime = DynamicalTime();
  final SunFunction _sunData = SunFunction();

  SunResult calculate({
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

    return SunResult(
      jd: jd,
      deltaT: dt,

      // ==========================
      // GEOCENTRIC
      // ==========================
      geoLongitudeTrue: _sunData.sunGeocentricLongitude(jd, dt, "True"),

      geoLongitudeApparent: _sunData.sunGeocentricLongitude(jd, dt, "Appa"),

      geoLatitudeTrue: _sunData.sunGeocentricLatitude(jd, dt),

      geoLatitudeApparent: _sunData.sunGeocentricLatitude(jd, dt),

      geoDistanceKm: _sunData.sunGeocentricDistance(jd, dt, "KM"),

      geoDistanceAu: _sunData.sunGeocentricDistance(jd, dt, "AU"),

      geoDistanceEr: _sunData.sunGeocentricDistance(jd, dt, "ER"),

      geoRightAscensionApparent: _sunData.sunGeocentricRightAscension(jd, dt),

      geoDeclinationApparent: _sunData.sunGeocentricDeclination(jd, dt),

      geoGreenwichHourAngleApparent: _sunData.sunGeocentricGreenwichHourAngle(
        jd,
        dt,
      ),

      geoLocalHourAngleApparent: _sunData.sunGeocentricLocalHourAngle(
        jd,
        dt,
        gLon,
      ),

      geoAzimuthApparent: _sunData.sunGeocentricAzimuth(jd, dt, gLon, gLat),

      geoAltitudeApparent: _sunData.sunGeocentricAltitude(jd, dt, gLon, gLat),

      geoHorizontalParallax: _sunData.sunEquatorialHorizontalParallax(jd, dt),

      geoSemidiameter: _sunData.sunGeocentricSemidiameter(jd, dt),

      // ==========================
      // TOPOCENTRIC
      // ==========================
      topoLongitudeApparent: _sunData.sunTopocentricLongitude(
        jd,
        dt,
        gLon,
        gLat,
        elev,
      ),

      topoLatitudeApparent: _sunData.sunTopocentricLatitude(
        jd,
        dt,
        gLon,
        gLat,
        elev,
      ),

      topoRightAscensionApparent: _sunData.sunTopocentricRightAscension(
        jd,
        dt,
        gLon,
        gLat,
        elev,
      ),

      topoDeclinationApparent: _sunData.sunTopocentricDeclination(
        jd,
        dt,
        gLon,
        gLat,
        elev,
      ),

      topoGreenwichHourAngleApparent: _sunData.sunTopocentricGreenwichHourAngle(
        jd,
        dt,
        gLon,
        gLat,
        elev,
      ),

      topoLocalHourAngleApparent: _sunData.sunTopocentricLocalHourAngel(
        jd,
        dt,
        gLon,
        gLat,
        elev,
      ),

      topoSemidiameterApparent: _sunData.sunTopocentricSemidiameter(
        jd,
        dt,
        gLon,
        gLat,
        elev,
      ),

      topoAzimuthApparent: _sunData.sunTopocentricAzimuth(
        jd,
        dt,
        gLon,
        gLat,
        elev,
      ),

      // === Airless ===
      topoAltitudeUpperAirless: _sunData.sunTopocentricAltitude(
        jd,
        dt,
        gLon,
        gLat,
        elev,
        pres,
        temp,
        "htu",
      ),

      topoAltitudeCenterAirless: _sunData.sunTopocentricAltitude(
        jd,
        dt,
        gLon,
        gLat,
        elev,
        pres,
        temp,
        "htc",
      ),

      topoAltitudeLowerAirless: _sunData.sunTopocentricAltitude(
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
      topoAltitudeUpperApparent: _sunData.sunTopocentricAltitude(
        jd,
        dt,
        gLon,
        gLat,
        elev,
        pres,
        temp,
        "htau",
      ),

      topoAltitudeCenterApparent: _sunData.sunTopocentricAltitude(
        jd,
        dt,
        gLon,
        gLat,
        elev,
        pres,
        temp,
        "htac",
      ),

      topoAltitudeLowerApparent: _sunData.sunTopocentricAltitude(
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
      topoAltitudeUpperObserved: _sunData.sunTopocentricAltitude(
        jd,
        dt,
        gLon,
        gLat,
        elev,
        pres,
        temp,
        "htou",
      ),

      topoAltitudeCenterObserved: _sunData.sunTopocentricAltitude(
        jd,
        dt,
        gLon,
        gLat,
        elev,
        pres,
        temp,
        "htoc",
      ),

      topoAltitudeLowerObserved: _sunData.sunTopocentricAltitude(
        jd,
        dt,
        gLon,
        gLat,
        elev,
        pres,
        temp,
        "htol",
      ),
    );
  }
}
