abstract class AppStatus {
  const AppStatus();
}

class Initial extends AppStatus {
  const Initial();
}

class InProgress extends AppStatus {
  const InProgress();
}

class Success extends AppStatus {
  const Success();
}

class Failure extends AppStatus {
  final Exception exception;
  const Failure(this.exception);
}
