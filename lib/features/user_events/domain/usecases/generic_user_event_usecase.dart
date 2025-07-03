abstract class GenericUserEventUsecase<Type, Params> {
  Future<Type> call(Params params);
}


