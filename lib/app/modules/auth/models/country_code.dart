class CountryCode {
  final String name;
  final String dialCode;
  final String flag;
  final String code;

  CountryCode({
    required this.name,
    required this.dialCode,
    required this.flag,
    required this.code,
  });

  factory CountryCode.fromJson(Map<String, dynamic> json) {
    return CountryCode(
      name: json['name'] as String? ?? 'Unknown',
      dialCode: json['dialCode'] as String? ?? 'Unknown',
      flag: json['flag'] as String? ?? 'Unknown',
      code: json['code'] as String? ?? 'Unknown',
    );
  }
}
