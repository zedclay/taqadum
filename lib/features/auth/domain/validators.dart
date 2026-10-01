final _emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]{2,}$');

bool isValidEmail(String value) => _emailPattern.hasMatch(value.trim());

bool passwordHasLength(String value) => value.length >= 8;

bool passwordHasMix(String value) =>
    RegExp('[A-Za-z]').hasMatch(value) && RegExp(r'\d').hasMatch(value);

bool isStrongPassword(String value) =>
    passwordHasLength(value) && passwordHasMix(value);
