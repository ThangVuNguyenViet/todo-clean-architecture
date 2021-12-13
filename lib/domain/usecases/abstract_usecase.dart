abstract class UseCase<T, P> {
  const UseCase();
  Future<T> call({required P params});
}
