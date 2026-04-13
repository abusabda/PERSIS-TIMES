import 'qibla_event_result.dart';

class QiblaMoonYearlyEvent {
  final int tahun;
  final List<QiblaEventResult> events;

  QiblaMoonYearlyEvent({required this.tahun, required this.events});
}

class QiblaMoonYearlyResult {
  final List<QiblaMoonYearlyEvent> data;

  QiblaMoonYearlyResult({required this.data});
}
