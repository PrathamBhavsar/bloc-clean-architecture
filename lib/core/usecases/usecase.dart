abstract class UseCase<Type, Params> {
  /// we get the data we need from the repo from here
  Future<Type> call({Params params});
}
