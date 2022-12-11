import 'package:common/common.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin LoadMoreController<T> on GetxController {
  final ScrollController scrollController = ScrollController();
  final RxBool _loading = true.obs;
  final RxList<T> _data = RxList([]);
  final RxBool _retry = false.obs;

  bool get retry => _retry.value;

  List<T> get data => _data;

  bool get loading => _loading.value;

  bool _canLoadMore = true;

  Future<AppResult<List<T>>> loadData([int skip = 0, int limit = pageSize]);

  @override
  void onInit() {
    super.onInit();
    _init();
    doRefreshData();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _init() {
    _loading(false);
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (!scrollController.hasClients || _loading.value || !_canLoadMore) {
      return;
    }
    final thresholdReached = scrollController.position.extentAfter < 200;

    if (thresholdReached) {
      _loadData(_data.length);
    }
  }

  Future<void> doRefreshData() async {
    await _loadData(0);
  }

  void retryFirstPage() {
    _loadData(0);
  }

  Future<void> _loadData(int skip, [int limit = pageSize]) async {
    _loading.value = true;
    final res = await loadData(skip, limit);
    if (res.success) {
      _retry.value = false;
      _canLoadMore = (res.data?.length ?? 0) >= pageSize;
      if (skip == 0 && _data.isNotEmpty) {
        _data.assignAll(res.data ?? []);
      } else {
        _data.addAll(res.data ?? []);
      }
    }
    if (res.error != null) {
      if (_data.isEmpty) {
        _retry.value = true;
      }
    }
    _loading.value = false;
  }

  void insert(T data, [int index = 0]) {
    _data.insert(0, data);
  }

  T getItem(int index) => _data[index];

  void updateItem(int index, T data) {
    _data.replaceRange(index, index + 1, [data]);
  }

  void remove(T data) {
    _data.remove(data);
  }
}
