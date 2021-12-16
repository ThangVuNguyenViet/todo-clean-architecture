abstract class Usecase<T, P> {
  const Usecase();
  T call({required P params});
}

abstract class UsecaseNoParam<T> {
  const UsecaseNoParam();
  T call();
}
