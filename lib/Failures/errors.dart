abstract class Errors {
  final String error;

  Errors(this.error);
}

class ServerFailure extends Errors {
  ServerFailure(super.error);
}
