class ServiceResult<T> {
  final T? data;
  final bool status;
  final String? message;

  ServiceResult._({this.data, this.message, required this.status});

  factory ServiceResult.success({T? data, String? message}) =>
      ServiceResult._(status: true, data: data, message: message);

  factory ServiceResult.failure(String message) =>
      ServiceResult._(status: false, message: message);

  factory ServiceResult.empty() => ServiceResult._(
      status: true,
      message: 'Data masih kosong!\nScroll kebawah untuk refresh');

  bool get isSuccess => status == true;
  bool get isError => status == false && message != null;
  bool get isEmpty => data == null;
  bool get isNotEmpty => data != null;
}
