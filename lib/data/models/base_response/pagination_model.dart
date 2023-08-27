class PaginationModel {
  int? currentPage;
  int? totalPages;
  int? totalItems;

  PaginationModel({
    this.totalItems,
    this.currentPage,
    this.totalPages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic>? json) =>
      PaginationModel(
        totalItems: json?['total_items'],
        currentPage: json?['current_page'],
        totalPages: json?['total_pages'],
      );
}
