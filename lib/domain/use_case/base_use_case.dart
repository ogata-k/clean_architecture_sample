abstract class BaseUseCase<Arg, Data> {
  const BaseUseCase();

  Data call(Arg arg);
}
