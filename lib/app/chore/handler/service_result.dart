class ServiceResult<T> {
  final T? data;
  final String? error;

  ServiceResult({this.data, this.error});

  bool get isSuccess => error == null;
}
