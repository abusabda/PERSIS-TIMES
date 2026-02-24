enum SalatStatus { normal, up, down, bright, dark, invalid }

extension SalatStatusExtension on SalatStatus {
  String get label => name; // hanya ambil nama enum saja
}
