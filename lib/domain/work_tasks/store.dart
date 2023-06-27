import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hello_ddd/domain/core/value_objects.dart';
import 'package:hello_ddd/domain/work_tasks/value_objects.dart';

part 'store.freezed.dart';

@freezed
class Store with _$Store {
  const Store._();

  const factory Store({
    required UniqueId id,
    required StoreName name,
    required StoreAddress address,
  }) = _Store;

  factory Store.empty() => Store(
        id: UniqueId(),
        name: StoreName(""),
        address: StoreAddress(""),
      );

  factory Store.defaultStore() => Store(
        id: UniqueId(),
        name: StoreName("К11"),
        address: StoreAddress("г. Красноярск, ул. Пушкина, д. 1"),
      );
}
