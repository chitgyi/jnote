import 'package:freezed_annotation/freezed_annotation.dart';
part 'view_state.freezed.dart';

@Freezed(copyWith: true)
class ViewState<T> with _$ViewState<T> {
  const factory ViewState.failed(String message) = Failed;
  const factory ViewState.success(T data) = Success;
  const factory ViewState.loading() = Loading;
}
