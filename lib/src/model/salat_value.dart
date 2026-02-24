import 'salat_status.dart';

class SalatValue {
  final double? time; // null kalau tidak ada waktu
  final SalatStatus status;

  const SalatValue({required this.time, required this.status});

  bool get isNormal => status == SalatStatus.normal;
}
