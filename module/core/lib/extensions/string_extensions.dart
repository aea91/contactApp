extension StringValidation on String {
  String? isValidEmail(String validationEmailError) =>
      contains(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
          ? null
          : validationEmailError;

  String? isValidPassword(String validationPasswordError) =>
      contains(RegExp(r'^.{6,}$')) ? null : '$validationPasswordError Harf ve rakam içermelidir';

  String? isValidPhoneNumber(String validationPhonenumberError) =>
      contains(RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$'))
          ? null
          : validationPhonenumberError;

  String? isValidLicencePlate(String validationLicencePlateError) => contains(RegExp(
          r'^(0[1-9]|[1-7][0-9]|8[01])((\s?[a-zA-Z]\s?)(\d{4,5})|(\s?[a-zA-Z]{2}\s?)(\d{3,4})|(\s?[a-zA-Z]{3}\s?)(\d{2,3}))$'))
      ? null
      : validationLicencePlateError;
}
