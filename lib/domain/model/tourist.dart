class Tourist {
  final int id;
  final bool expanded;
  final String? name;
  final String? surname;
  final DateTime? birthDate;
  final String? citizenship;
  final int? passportNumber;
  final DateTime? passportDate;

  Tourist({
    required this.id,
    required this.expanded,
    this.name,
    this.surname,
    this.birthDate,
    this.citizenship,
    this.passportNumber,
    this.passportDate,
  });

  bool validate() {
    return validateName() &&
        validateBirthDate() &&
        validateSurname() &&
        validateCitizenship() &&
        validatePassportDate() &&
        validatePassportNumber();
  }

  bool validateName() => name != null && name!.isNotEmpty;

  bool validateSurname() => surname != null && surname!.isNotEmpty;

  bool validateBirthDate() => birthDate != null;

  bool validateCitizenship() => citizenship != null && citizenship!.isNotEmpty;

  bool validatePassportNumber() => passportNumber != null;

  bool validatePassportDate() => passportDate != null;

  Tourist toggle() {
    return Tourist(
        id: id,
        expanded: !expanded,
        name: name,
        surname: surname,
        birthDate: birthDate,
        citizenship: citizenship,
        passportDate: passportDate,
        passportNumber: passportNumber);
  }
}
