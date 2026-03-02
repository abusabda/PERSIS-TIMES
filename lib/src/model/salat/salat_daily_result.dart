import 'salat_value.dart';

class SalatDailyResult {
  final SalatValue subuh;
  final SalatValue syuruk;
  final SalatValue duha;
  final SalatValue zuhur;
  final SalatValue asar;
  final SalatValue magrib;
  final SalatValue isya;
  final SalatValue nisfuLail;

  const SalatDailyResult({
    required this.subuh,
    required this.syuruk,
    required this.duha,
    required this.zuhur,
    required this.asar,
    required this.magrib,
    required this.isya,
    required this.nisfuLail,
  });
}
