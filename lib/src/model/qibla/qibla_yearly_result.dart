import 'qibla_event_result.dart';

class QiblaYearlyEvent {
  final int tahun;
  final QiblaEventResult event1;
  final QiblaEventResult event2;

  QiblaYearlyEvent({
    required this.tahun,
    required this.event1,
    required this.event2,
  });
}

class QiblaYearlyResult {
  final List<QiblaYearlyEvent> data;

  QiblaYearlyResult({required this.data});
}
