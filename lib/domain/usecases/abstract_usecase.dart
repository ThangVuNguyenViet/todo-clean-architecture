abstract class UseCase<T, P> {
  const UseCase();
  T call({required P params});
}
