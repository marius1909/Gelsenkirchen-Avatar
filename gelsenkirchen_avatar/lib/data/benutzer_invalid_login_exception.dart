class InvalidLoginException implements Exception {
  InvalidLoginExceptionCause cause;
  InvalidLoginException(this.cause);
}

enum InvalidLoginExceptionCause { emailNotFound, passwordIncorrect }

extension InvalidLoginExceptionCauseExtension on InvalidLoginExceptionCause {
  String get message {
    switch (this) {
      case InvalidLoginExceptionCause.emailNotFound:
        return "Account existiert nicht";
      case InvalidLoginExceptionCause.passwordIncorrect:
        return "Falsches Passwort";
      default:
        return null;
    }
  }
}
