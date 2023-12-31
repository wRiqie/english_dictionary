class PaginableModel<T> {
  List<T> items;
  int totalItemsCount;

  PaginableModel({
    required this.items,
    required this.totalItemsCount,
  });

  factory PaginableModel.clean() => PaginableModel(
        items: [],
        totalItemsCount: 0,
      );

  factory PaginableModel.fromJson(
      Map<String, dynamic> map, T Function(Map<String, dynamic>) fromJson) {
    return PaginableModel(
      items: map['items'],
      totalItemsCount: map['totalItemsCount'],
    );
  }

  bool get isEnd {
    return items.length >= totalItemsCount;
  }

  int get length => items.length;

  bool get isNotEmpty => items.isNotEmpty;

  bool get isEmpty => items.isEmpty;

  void remove(T data) {
    var result = items.remove(data);
    if (result) totalItemsCount--;
  }

  void clear() {
    items.clear();
    totalItemsCount = 0;
  }

  PaginableModel<T> copyWith({
    List<T>? items,
    int? totalItemsCount,
  }) {
    return PaginableModel<T>(
      items: items ?? this.items,
      totalItemsCount: totalItemsCount ?? this.totalItemsCount,
    );
  }
}
