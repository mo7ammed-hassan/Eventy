import 'package:flutter/material.dart';

class RetryManger {
  static final List<Function> _retryQueue = [];

  static void addToQueue(Function retryFunction) {
    _retryQueue.add(retryFunction);
  }

  static void retryAll() {
    final queueSnapshot = List.of(_retryQueue); // create a copy
    _retryQueue.clear(); // clear original before retrying

    for (var retryFunction in queueSnapshot) {
      try {
        retryFunction();
      } catch (e) {
        debugPrint("Failed to retry request: $e");
        _retryQueue.add(retryFunction); // re-add if still fails
      }
    }
  }

  static void clearQueue() {
    _retryQueue.clear();
  }

  static bool isQueueEmpty() {
    return _retryQueue.isEmpty;
  }
}
