class ListResponse<T> {
  List<T> data;

  ListResponse({required this.data});

  factory ListResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ListResponse<T>(
      data: (json['data'] as List<dynamic>)
          .map((itemJson) => fromJsonT(itemJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson(Object Function(T) toJsonT) {
    return {
      'data': data.map((item) => toJsonT(item)).toList(),
    };
  }
}
