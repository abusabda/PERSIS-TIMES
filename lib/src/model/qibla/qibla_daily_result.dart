class QiblaDailyShadow {
  final String tanggal;
  final double bayangan1;
  final double bayangan2;

  QiblaDailyShadow({
    required this.tanggal,
    required this.bayangan1,
    required this.bayangan2,
  });
}

class QiblaDailyResult {
  final List<QiblaDailyShadow> data;

  QiblaDailyResult({required this.data});
}
