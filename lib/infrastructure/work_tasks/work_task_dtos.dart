import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hello_ddd/domain/core/value_objects.dart';
import 'package:hello_ddd/domain/work_tasks/store.dart';
import 'package:hello_ddd/domain/work_tasks/value_objects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/work_tasks/work_task.dart';

part 'work_task_dtos.freezed.dart';

part 'work_task_dtos.g.dart';

@freezed
abstract class WorkTaskDTO implements _$WorkTaskDTO {
  const WorkTaskDTO._();

  const factory WorkTaskDTO({
    @JsonKey(includeToJson: false) required String id,
    required String name,
    required String description,
    required String type,
    required double hours,
    required DateTime startDate,
    required DateTime endDate,
    required StoreDTO store,
    required bool completed,
    @ServerTimestampConverter() required FieldValue serverTimeStamp,
  }) = _WorkTaskDTO;

  factory WorkTaskDTO.fromDomain(WorkTask workTask) {
    return WorkTaskDTO(
      id: workTask.id.getOrCrash(),
      name: workTask.name.getOrCrash(),
      description: workTask.description.getOrCrash(),
      type: workTask.type.getOrCrash(),
      hours: workTask.hours.getOrCrash(),
      startDate: workTask.beginHour.getOrCrash(),
      store: StoreDTO.fromDomain(workTask.store),
      endDate: workTask.endHour.getOrCrash(),
      serverTimeStamp: FieldValue.serverTimestamp(),
      completed: workTask.completed,
    );
  }

  WorkTask toDomain() {
    return WorkTask(
      id: UniqueId.fromUniqueString(id),
      name: WorkTaskName(name),
      type: WorkTaskType(type),
      store: store.toDomain(),
      hours: WorkTaskHours(hours),
      beginHour: WorkTaskBegin(startDate),
      endHour: WorkTaskEnd(endDate),
      description: WorkTaskDescription(description),
      completed: completed,
    );
  }

  factory WorkTaskDTO.fromJson(Map<String, dynamic> json) =>
      _$WorkTaskDTOFromJson(json);

  factory WorkTaskDTO.fromFirestore(DocumentSnapshot doc) =>
      WorkTaskDTO.fromJson(doc.data() as Map<String, dynamic>)
          .copyWith(id: doc.id);
}

class ServerTimestampConverter implements JsonConverter<FieldValue, Object> {
  const ServerTimestampConverter();

  @override
  FieldValue fromJson(Object json) {
    return FieldValue.serverTimestamp();
  }

  @override
  Object toJson(FieldValue fieldValue) => fieldValue;
}

@freezed
abstract class StoreDTO implements _$StoreDTO {
  const StoreDTO._();

  const factory StoreDTO({
    @JsonKey(includeToJson: false) required String id,
    required String name,
    required String address,
  }) = _StoreDTO;

  factory StoreDTO.fromDomain(Store store) {
    return StoreDTO(
      id: store.id.getOrCrash(),
      name: store.name.getOrCrash(),
      address: store.address.getOrCrash(),
    );
  }

  Store toDomain() {
    return Store(
      id: UniqueId.fromUniqueString(id),
      name: StoreName(name),
      address: StoreAddress(address),
    );
  }

  factory StoreDTO.fromJson(Map<String, dynamic> json) =>
      _$StoreDTOFromJson(json);
}
