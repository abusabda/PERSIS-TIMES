import 'dart:math' as math;
import 'package:myhisab/src/core/astronomy/dynamical_time.dart';
import 'package:myhisab/src/core/astronomy/moon_function.dart';
import 'package:myhisab/src/core/astronomy/moon_longitude.dart';
import 'package:myhisab/src/core/astronomy/moon_latitude.dart';
import 'package:myhisab/src/core/astronomy/moon_distance.dart';

import 'package:myhisab/src/core/astronomy/sun_function.dart';
import 'package:myhisab/src/core/astronomy/julian_day.dart';

import 'package:myhisab/src/model/sun_data_geo.dart';
import 'package:myhisab/src/model/sun_data_topo.dart';
import 'package:myhisab/src/model/moon_data_geo.dart';
import 'package:myhisab/src/model/moon_data_topo.dart';
import 'package:myhisab/src/model/hilal_data.dart';
import '../model/hisab_awal_bulan_result.dart';

class HisabAwalBulanService {
  HisabAwalBulanResult hitung({
    required int blnH,
    required int thnH,
    required double gLon,
    required double gLat,
    required double tmZn,
    required double elev,
    required double pres,
    required double temp,
    required int tbhHari,
    required int optKriteria,
    // required dynamic mo,
    // required dynamic sn,
    // required dynamic dyTme,
  }) {
    final mo = MoonFunction();
    final ml = MoonLongitude();
    final mb = MoonLatitude();
    final md = MoonDistance();
    final sn = SunFunction();
    final dt = DynamicalTime();
    final jd = JulianDay();

    final double geojdIjtimak = mo.geocentricConjunction(
      blnH,
      thnH,
      0.0,
      "Ijtima",
    );

    final double deltaT = dt.deltaT(geojdIjtimak.floorToDouble() + 0.5);

    final double topojdIjtimak = mo.topocentricConjunction(
      blnH,
      thnH,
      deltaT,
      gLon,
      gLat,
      0.0,
      "Ijtima",
    );

    final double sunsetJD = sn.jdGhurubSyams(
      geojdIjtimak + tbhHari,
      gLat,
      gLon,
      elev,
      tmZn,
    );

    final int tglM = int.parse(jd.jdkm(sunsetJD, tmZn, "TglM").toString());
    final int blnM = int.parse(jd.jdkm(sunsetJD, tmZn, "BlnM").toString());
    final int thnM = int.parse(jd.jdkm(sunsetJD, tmZn, "ThnM").toString());

    double? mSet = mo.moonTransitRiseSet(
      tglM,
      blnM,
      thnM,
      gLon,
      gLat,
      elev,
      tmZn,
      "SET",
      2,
    );

    final double? moonsetJD = (mSet != 0.0)
        ? jd.kmjd(tglM, blnM, thnM, 0.0, 0.0) + (mSet - tmZn) / 24.0
        : null;

    //Data Matahari Geosentris
    final double sunGeocentricLongitudeTrue = sn.sunGeocentricLongitude(
      sunsetJD,
      deltaT,
      "True",
    );
    final double sunGeocentricLongitudeApparent = sn.sunGeocentricLongitude(
      sunsetJD,
      deltaT,
      "Appa",
    );
    final double sunGeocentricLatitudeTrue = sn.sunGeocentricLatitude(
      sunsetJD,
      deltaT,
    );
    final double sunGeocentricLatitudeApparent = sn.sunGeocentricLatitude(
      sunsetJD,
      deltaT,
    );

    final double sunGeocentricRightAscension = sn.sunGeocentricRightAscension(
      sunsetJD,
      deltaT,
    );
    final double sunGeocentricDeclination = sn.sunGeocentricDeclination(
      sunsetJD,
      deltaT,
    );

    final double sunGeocentricAzimuth = sn.sunGeocentricAzimuth(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
    );
    final double sunGeocentricAltitude = sn.sunGeocentricAltitude(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
    );

    final double sunGeocentricSemidiameter = sn.sunGeocentricSemidiameter(
      sunsetJD,
      deltaT,
    );
    final double sunEquatorialHorizontalParallax = sn
        .sunEquatorialHorizontalParallax(sunsetJD, deltaT);

    final double sunGeocentricDistanceAU = sn.sunGeocentricDistance(
      sunsetJD,
      deltaT,
      "AU",
    );
    final double sunGeocentricDistanceKM = sn.sunGeocentricDistance(
      sunsetJD,
      deltaT,
      "KM",
    );
    final double sunGeocentricDistanceER = sn.sunGeocentricDistance(
      sunsetJD,
      deltaT,
      "ER",
    );

    final double sunGeocentricGreenwichHourAngle = sn
        .sunGeocentricGreenwichHourAngle(sunsetJD, deltaT);
    final double sunGeocentricLocalHourAngle = sn.sunGeocentricLocalHourAngle(
      sunsetJD,
      deltaT,
      gLon,
    );

    //Data Matahari Toposentris
    final double sunTopocentricLongitudeApparent = sn.sunTopocentricLongitude(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
      elev,
    );
    final double sunTopocentricLatitudeTrue = sn.sunTopocentricLatitude(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
      elev,
    );

    final double sunTopocentricRightAscension = sn.sunTopocentricRightAscension(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
      elev,
    );
    final double sunTopocentricDeclination = sn.sunTopocentricDeclination(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
      elev,
    );

    final double sunTopocentricAzimuth = sn.sunTopocentricAzimuth(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
      elev,
    );

    final double sunTopocentricAltitudeAirlessUpper = sn.sunTopocentricAltitude(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
      elev,
      pres,
      temp,
      "htu",
    );

    final double sunTopocentricAltitudeAirlessCenter = sn
        .sunTopocentricAltitude(
          sunsetJD,
          deltaT,
          gLon,
          gLat,
          elev,
          pres,
          temp,
          "htc",
        );

    final double sunTopocentricAltitudeAirlessLower = sn.sunTopocentricAltitude(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
      elev,
      pres,
      temp,
      "htl",
    );

    final double sunTopocentricAltitudeApparentsUpper = sn
        .sunTopocentricAltitude(
          sunsetJD,
          deltaT,
          gLon,
          gLat,
          elev,
          pres,
          temp,
          "htau",
        );

    final double sunTopocentricAltitudeApparentCenter = sn
        .sunTopocentricAltitude(
          sunsetJD,
          deltaT,
          gLon,
          gLat,
          elev,
          pres,
          temp,
          "htac",
        );

    final double sunTopocentricAltitudeApparentLower = sn
        .sunTopocentricAltitude(
          sunsetJD,
          deltaT,
          gLon,
          gLat,
          elev,
          pres,
          temp,
          "htal",
        );

    final double sunTopocentricAltitudeObserveredUpper = sn
        .sunTopocentricAltitude(
          sunsetJD,
          deltaT,
          gLon,
          gLat,
          elev,
          pres,
          temp,
          "htou",
        );

    final double sunTopocentricAltitudeObserveredCenter = sn
        .sunTopocentricAltitude(
          sunsetJD,
          deltaT,
          gLon,
          gLat,
          elev,
          pres,
          temp,
          "htoc",
        );

    final double sunTopocentricAltitudeObserveredLower = sn
        .sunTopocentricAltitude(
          sunsetJD,
          deltaT,
          gLon,
          gLat,
          elev,
          pres,
          temp,
          "htol",
        );

    final double sunTopocentricSemidiameter = sn.sunTopocentricSemidiameter(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
      elev,
    );

    final double sunTopocentricGreenwichHourAngle = sn
        .sunTopocentricGreenwichHourAngle(sunsetJD, deltaT, gLon, gLat, elev);
    final double sunTopocentricLocalHourAngle = sn.sunTopocentricLocalHourAngel(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
      elev,
    );

    //Data Bulan Geosentris
    final double moonGeocentricLongitudeTrue = ml.moonGeocentricLongitude(
      sunsetJD,
      deltaT,
      "true",
    );
    final double moonGeocentricLongitudeApparent = ml.moonGeocentricLongitude(
      sunsetJD,
      deltaT,
      "apparent",
    );
    final double moonGeocentricLatitudeTrue = mb.moonGeocentricLatitude(
      sunsetJD,
      deltaT,
      "true",
    );
    final double moonGeocentricLatitudeApparent = mb.moonGeocentricLatitude(
      sunsetJD,
      deltaT,
      "apparent",
    );

    final double moonGeocentricRightAscension = mo.moonGeocentricRightAscension(
      sunsetJD,
      deltaT,
    );
    final double moonGeocentricDeclination = mo.moonGeocentricDeclination(
      sunsetJD,
      deltaT,
    );

    final double moonGeocentricGreenwichHourAngle = mo
        .moonGeocentricGreenwichHourAngle(sunsetJD, deltaT);

    final double moonGeocentricLocalHourAngle = mo.moonGeocentricLocalHourAngel(
      sunsetJD,
      deltaT,
      gLon,
    );

    final double moonGeocentricAzimuth = mo.moonGeocentricAzimuth(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
    );
    final double moonGeocentricAltitude = mo.moonGeocentricAltitude(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
    );

    final double moonGeocentricDistanceAU = md.moonGeocentricDistance(
      sunsetJD,
      deltaT,
      "AU",
    );
    final double moonGeocentricDistanceKM = md.moonGeocentricDistance(
      sunsetJD,
      deltaT,
      "KM",
    );
    final double moonGeocentricDistanceER = md.moonGeocentricDistance(
      sunsetJD,
      deltaT,
      "ER",
    );

    final double moonGeocentricSemidiameter = mo.moonGeocentricSemidiameter(
      sunsetJD,
      deltaT,
    );
    final double moonEquatorialHorizontalParallax = mo
        .moonEquatorialHorizontalParallax(sunsetJD, deltaT);

    final double moonGeocentricPhaseAngle = mo.moonGeocentricPhaseAngle(
      sunsetJD,
      deltaT,
    );
    final double moonGeocentricDiskIlluminatedFraction = mo
        .moonGeocentricDiskIlluminatedFraction(sunsetJD, deltaT);
    final double moonGeocentricBrightLimbAngle = mo
        .moonGeocentricBrightLimbAngle(sunsetJD, deltaT);

    //Data Bulan Toposentris
    final double moonTopocentricLongitudeApparent = mo.moonTopocentricLongitude(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
      elev,
    );
    final double moonTopocentricLatitudeApparent = mo.moonTopocentricLatitude(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
      elev,
    );

    final double moonTopocentricRightAscension = mo
        .moonTopocentricRightAscension(sunsetJD, deltaT, gLon, gLat, elev);

    final double moonTopocentricDeclination = mo.moonTopocentricDeclination(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
      elev,
    );

    final double moonTopocentricGreenwichHourAngle = mo
        .moonTopocentricGreenwichHourAngle(sunsetJD, deltaT, gLon, gLat, elev);

    final double moonTopocentricLocalHourAngle = mo
        .moonTopocentricLocalHourAngel(sunsetJD, deltaT, gLon, gLat, elev);

    final double moonTopocentricSemidiameter = mo.moonTopocentricSemidiameter(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
      elev,
    );

    final double moonTopocentricPhaseAngle = mo.moonTopocentricPhaseAngle(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
      elev,
    );
    final double moonTopocentricDiskIlluminatedFraction = mo
        .moonTopocentricDiskIlluminatedFraction(
          sunsetJD,
          deltaT,
          gLon,
          gLat,
          elev,
        );
    final double moonTopocentricBrightLimbAngle = mo
        .moonTopocentricBrightLimbAngle(sunsetJD, deltaT, gLon, gLat, elev);

    final double moonTopocentricAzimuth = mo.moonTopocentricAzimuth(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
      elev,
    );

    final double moonTopocentricAltitudeAirlessUpper = mo
        .moonTopocentricAltitude(
          sunsetJD,
          deltaT,
          gLon,
          gLat,
          elev,
          pres,
          temp,
          "htu",
        );

    final double moonTopocentricAltitudeAirlessCenter = mo
        .moonTopocentricAltitude(
          sunsetJD,
          deltaT,
          gLon,
          gLat,
          elev,
          pres,
          temp,
          "htc",
        );

    final double moonTopocentricAltitudeAirlessLower = mo
        .moonTopocentricAltitude(
          sunsetJD,
          deltaT,
          gLon,
          gLat,
          elev,
          pres,
          temp,
          "htl",
        );

    final double moonTopocentricAltitudeApparentsUpper = mo
        .moonTopocentricAltitude(
          sunsetJD,
          deltaT,
          gLon,
          gLat,
          elev,
          pres,
          temp,
          "htau",
        );

    final double moonTopocentricAltitudeApparentCenter = mo
        .moonTopocentricAltitude(
          sunsetJD,
          deltaT,
          gLon,
          gLat,
          elev,
          pres,
          temp,
          "htac",
        );

    final double moonTopocentricAltitudeApparentLower = mo
        .moonTopocentricAltitude(
          sunsetJD,
          deltaT,
          gLon,
          gLat,
          elev,
          pres,
          temp,
          "htal",
        );

    final double moonTopocentricAltitudeObserveredUpper = mo
        .moonTopocentricAltitude(
          sunsetJD,
          deltaT,
          gLon,
          gLat,
          elev,
          pres,
          temp,
          "htou",
        );

    final double moonTopocentricAltitudeObserveredCenter = mo
        .moonTopocentricAltitude(
          sunsetJD,
          deltaT,
          gLon,
          gLat,
          elev,
          pres,
          temp,
          "htoc",
        );

    final double moonTopocentricAltitudeObserveredLower = mo
        .moonTopocentricAltitude(
          sunsetJD,
          deltaT,
          gLon,
          gLat,
          elev,
          pres,
          temp,
          "htol",
        );

    final double elongGeo = mo.moonSunGeocentricElongation(sunsetJD, deltaT);

    final double elongTopo = mo.moonSunTopocentricElongation(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
      elev,
    );

    final double relAltGeo =
        moonGeocentricAltitude + sunGeocentricAltitude.abs();

    final double relAltTopo =
        moonTopocentricAltitudeAirlessCenter +
        sunTopocentricAltitudeAirlessCenter.abs();

    final double crescentGeo =
        mo.moonGeocentricSemidiameter(sunsetJD, deltaT) *
        (1 - math.cos(elongGeo));

    final double crescentTopo =
        mo.moonTopocentricSemidiameter(sunsetJD, deltaT, gLon, gLat, elev) *
        (1 - math.cos(elongTopo));

    final double qOdeh =
        relAltTopo -
        (-0.1018 * math.pow((crescentTopo * 60), 3) +
            0.7319 * math.pow((crescentTopo * 60), 2) -
            6.3226 * (crescentTopo * 60) +
            7.1651);

    final double bestTime = sunsetJD + (4 / 9.0);

    // ===================
    // KRITERIA
    // ===================

    final double imkanMabimsStatus =
        (moonTopocentricAltitudeObserveredCenter >= 3.0 && elongGeo >= 6.4)
        ? 1.0
        : 2.0;

    final double imkanTurkiStatus =
        (moonGeocentricAltitude >= 5.0 && elongGeo >= 8) ? 1.0 : 2.0;

    final double wujudHilalStatus =
        (moonTopocentricAltitudeObserveredUpper > 0.0) ? 1.0 : 2.0;

    // final double awalBulanJD =
    //     ((geojdIjtimak + 0.5 + tmZn / 24).floor() - tmZn / 24.0) +
    //     (optKriteria == 1 ? imkanStatus : wujudStatus);

    return HisabAwalBulanResult(
      jd: sunsetJD,
      deltaT: deltaT,
      geojdIjtimak: geojdIjtimak,
      topojdIjtimak: topojdIjtimak,
      sunsetJD: sunsetJD,
      moonsetJD: moonsetJD,
      imkanMabimsStatus: imkanMabimsStatus,
      imkanTurkiStatus: imkanTurkiStatus,
      wujudHilalStatus: wujudHilalStatus,

      // =====================
      // SUN GEO
      // =====================
      sunGeo: SunDataGeo(
        longitudeTrue: sunGeocentricLongitudeTrue,
        longitudeApparent: sunGeocentricLongitudeApparent,
        latitudeTrue: sunGeocentricLatitudeTrue,
        latitudeApparent: sunGeocentricLatitudeApparent,

        rightAscension: sunGeocentricRightAscension,
        declination: sunGeocentricDeclination,

        greenwichHourAngle: sunGeocentricGreenwichHourAngle,
        localHourAngle: sunGeocentricLocalHourAngle,

        distanceAU: sunGeocentricDistanceAU,
        distanceKm: sunGeocentricDistanceKM,
        distanceER: sunGeocentricDistanceER,
        semidiameter: sunGeocentricSemidiameter,
        horizontalParallax: sunEquatorialHorizontalParallax,

        azimuth: sunGeocentricAzimuth,
        altitude: sunGeocentricAltitude,
      ),

      // =====================
      // SUN TOPO
      // =====================
      sunTopo: SunDataTopo(
        longitudeApparent: sunTopocentricLongitudeApparent,
        latitudeApparent: sunTopocentricLatitudeTrue,

        rightAscension: sunTopocentricRightAscension,
        declination: sunTopocentricDeclination,

        semidiameter: sunTopocentricSemidiameter,
        greenwichHourAngle: sunTopocentricGreenwichHourAngle,
        localHourAngle: sunTopocentricLocalHourAngle,

        azimuth: sunTopocentricAzimuth,
        altitudeAirlessUpper: sunTopocentricAltitudeAirlessUpper,
        altitudeAirlessCenter: sunTopocentricAltitudeAirlessCenter,
        altitudeAirlessLower: sunTopocentricAltitudeAirlessLower,

        altitudeApparentUpper: sunTopocentricAltitudeAirlessUpper,
        altitudeApparentCenter: sunTopocentricAltitudeAirlessCenter,
        altitudeApparentLower: sunTopocentricAltitudeAirlessLower,

        altitudeObserveredUpper: sunTopocentricAltitudeAirlessUpper,
        altitudeObserveredCenter: sunTopocentricAltitudeAirlessCenter,
        altitudeObserveredLower: sunTopocentricAltitudeAirlessLower,
      ),

      // =====================
      // MOON GEO
      // =====================
      moonGeo: MoonDataGeo(
        longitudeTrue: moonGeocentricLongitudeTrue,
        longitudeApparent: moonGeocentricLongitudeApparent,
        latitudeTrue: moonGeocentricLatitudeTrue,
        latitudeApparent: moonGeocentricLatitudeApparent,

        rightAscension: moonGeocentricRightAscension,
        declination: moonGeocentricDeclination,

        distanceAU: moonGeocentricDistanceAU,
        distanceKm: moonGeocentricDistanceKM,
        distanceER: moonGeocentricDistanceER,

        greenwichHourAngle: moonGeocentricGreenwichHourAngle,
        localHourAngle: moonTopocentricLocalHourAngle,
        horizontalParallax: moonEquatorialHorizontalParallax,
        semidiameter: moonGeocentricSemidiameter,

        azimuth: moonGeocentricAzimuth,
        altitude: moonGeocentricAltitude,

        phaseAngle: moonGeocentricPhaseAngle,
        diskIlluminationFraction: moonGeocentricDiskIlluminatedFraction,
        brightLimbAngle: moonGeocentricBrightLimbAngle,
      ),

      // =====================
      // MOON TOPO
      // =====================
      moonTopo: MoonDataTopo(
        longitudeApparent: moonTopocentricLongitudeApparent,
        latitudeApparent: moonTopocentricLatitudeApparent,

        rightAscension: moonTopocentricRightAscension,
        declination: moonTopocentricDeclination,

        greenwichHourAngle: moonGeocentricGreenwichHourAngle,
        localHourAngle: moonTopocentricLocalHourAngle,
        horizontalParallax: moonEquatorialHorizontalParallax,
        semidiameter: moonGeocentricSemidiameter,

        azimuth: moonTopocentricAzimuth,

        altitudeAirlessUpper: moonTopocentricAltitudeAirlessUpper,
        altitudeAirlessCenter: moonTopocentricAltitudeAirlessCenter,
        altitudeAirlessLower: moonTopocentricAltitudeAirlessLower,

        altitudeApparentUpper: moonTopocentricAltitudeApparentsUpper,
        altitudeApparentCenter: moonTopocentricAltitudeApparentCenter,
        altitudeApparentLower: moonTopocentricAltitudeApparentLower,

        altitudeObservedUpper: moonTopocentricAltitudeObserveredUpper,
        altitudeObservedCenter: moonTopocentricAltitudeObserveredCenter,
        altitudeObservedLower: moonTopocentricAltitudeObserveredLower,

        phaseAngle: moonTopocentricPhaseAngle,
        diskIlluminationFraction: moonTopocentricDiskIlluminatedFraction,
        brightLimbAngle: moonTopocentricBrightLimbAngle,
      ),

      // =====================
      // HILAL DATA
      // =====================
      hilal: HilalData(
        elongationGeo: elongGeo,
        elongationTopo: elongTopo,
        crescentWidthGeo: crescentGeo,
        crescentWidthTopo: crescentTopo,
        relativeAltitudeGeo: relAltGeo,
        relativeAltitudeTopo: relAltTopo,
        qOdeh: qOdeh,
        bestTime: bestTime,
        imkanMabimsStatus: imkanMabimsStatus,
        imkanTurkiStatus: imkanTurkiStatus,
        wujudHilalStatus: wujudHilalStatus,
        //awalBulanJD: awalBulanJD,
      ),
    );
  }
}
