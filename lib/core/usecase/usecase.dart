abstract interface class Usecase<ReturnType, Params> {
  ReturnType call({required Params params});
}

class NoParams {}
