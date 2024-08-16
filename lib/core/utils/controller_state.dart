sealed class ControllerState<T, E> {
  const ControllerState();
  T? get data => null;
}

final class ControllerStateInitial<T, E> extends ControllerState<T, E> {
  const ControllerStateInitial();
}

final class ControllerStateLoading<T, E> extends ControllerState<T, E> {
  const ControllerStateLoading();
}

final class ControllerStateSuccess<T, E> extends ControllerState<T, E> {
  ControllerStateSuccess(this._data, {required T Function(T e)? transformData})
      : _transformData = transformData;

  final T _data;
  final T Function(T e)? _transformData;

  @override
  T get data => _transformData?.call(_data) ?? _data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ControllerStateSuccess && other.data == data);

  @override
  int get hashCode => data.hashCode;
}

final class ControllerStateError<T, E> extends ControllerState<T, E> {
  ControllerStateError(this.error);
  final E error;
}
