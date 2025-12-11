abstract class UseCase<T, Parameters>  { // Parameters here is just a name for what class or type we set to the usecase.
  Future<T> call(Parameters params);
}

abstract class UseCaseNoParams<T>  { // Parameters here is just a name for what class or type we set to the usecase.
  Future<T> call();
}

abstract class Parameters {
  Parameters();
}

class NoParams implements Parameters {
  const NoParams();
}