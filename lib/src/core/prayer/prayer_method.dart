class PrayerMethod {
  final String name;
  final double hmSubuh;
  final double hmIsya;
  final bool isCustom;

  const PrayerMethod._(
    this.name,
    this.hmSubuh,
    this.hmIsya, {
    this.isCustom = false,
  });

  // 🔹 Predefined Methods (sesuai request Anda)
  static const persatuanIslam = PrayerMethod._('Persatuan Islam', -20.0, -18.0);
  static const kemenagRI = PrayerMethod._('Kemenag RI', -20.0, -18.0);
  static const nahdlatulUlama = PrayerMethod._('Nahdlatul Ulama', -20.0, -18.0);
  static const muhammadiyah = PrayerMethod._('Muhammadiyah', -18.0, -18.0);
  static const egyptianGeneralAuthority = PrayerMethod._(
    'Egyptian General Authority of Survey',
    -19.5,
    -17.5,
  );
  static const islamicSocietyNorthAmerica = PrayerMethod._(
    'Islamic Society of North America',
    -18.0,
    -18.0,
  );
  static const muslimWorldLeague = PrayerMethod._(
    'Muslim World League',
    -18.0,
    -17.0,
  );
  static const universityIslamicScienceKarachi = PrayerMethod._(
    'University of Islamic Science, Karachi',
    -18.0,
    -18.0,
  );

  // 🔹 Custom Method Factory
  static PrayerMethod custom(String name, double hmSubuh, double hmIsya) {
    return PrayerMethod._(name, hmSubuh, hmIsya, isCustom: true);
  }

  // 🔹 Helper: Lookup by name (case-insensitive)
  static PrayerMethod? fromName(String name) {
    final lower = name.toLowerCase();
    for (final method in predefined) {
      if (method.name.toLowerCase() == lower) return method;
    }
    return null;
  }

  // 🔹 List semua metode predefined
  static const List<PrayerMethod> predefined = [
    persatuanIslam,
    kemenagRI,
    nahdlatulUlama,
    muhammadiyah,
    egyptianGeneralAuthority,
    islamicSocietyNorthAmerica,
    muslimWorldLeague,
    universityIslamicScienceKarachi,
  ];
}
