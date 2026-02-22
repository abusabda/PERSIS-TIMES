class QiblaYearlyEvent {
  final int tahun;
  final String event1;
  final String event2;

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
