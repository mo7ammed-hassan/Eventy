mixin PaginationMixin {
  int page = 1;
  int limit = 15;
  bool hasMore = true;
  bool isLoading = false;

  void resetPagination() {
    page = 1;
    hasMore = true;
  }

  void increasePage() {
    page++;
  }

  bool canLoadMore() {
    return hasMore && !isLoading;
  }
}
