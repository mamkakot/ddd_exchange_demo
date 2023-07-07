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

  // TODO: убрать хардкод
  static List<Store> predefinedStores = [
    Store.defaultStore().copyWith(name: StoreName("К1")),
    Store.defaultStore().copyWith(name: StoreName("К2")),
    Store.defaultStore().copyWith(name: StoreName("К3")),
    Store.defaultStore().copyWith(name: StoreName("К4")),
    Store.defaultStore().copyWith(name: StoreName("К5")),
    Store.defaultStore().copyWith(name: StoreName("К6")),
  ];
}
