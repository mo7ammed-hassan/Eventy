import 'package:flutter_bloc/flutter_bloc.dart';

mixin SafeEmitMixin<T> on Cubit<T> {
  void safeEmit(T state) {
    if (!isClosed) emit(state);
  }
}
