import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hello_ddd/domain/auth/i_auth_repository.dart';
import 'package:hello_ddd/domain/workers/value_objects.dart';
import 'package:hello_ddd/domain/core/value_objects.dart';
import 'package:hello_ddd/domain/work_tasks/store.dart';
import 'package:hello_ddd/domain/work_tasks/value_objects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_ddd/domain/workers/worker.dart';

import 'package:hello_ddd/domain/work_tasks/work_task.dart';

import '../../domain/auth/user.dart';
import '../../domain/auth/value_objects.dart';
import '../../injection.dart';

part 'work_task_dtos.freezed.dart';

part 'work_task_dtos.g.dart';

@freezed
abstract class WorkTaskDTO implements _$WorkTaskDTO {
  const WorkTaskDTO._();

  @JsonSerializable(explicitToJson: true)
  const factory WorkTaskDTO({
    @JsonKey(includeToJson: false, includeFromJson: false) String? id,
    required String name,
    required String description,
    required String type,
    required double hours,
    required bool completed,
    required int rating,
    @TimestampConverter() required DateTime beginDate,
    @TimestampConverter() required DateTime endDate,
    required StoreDTO store,
    @JsonKey(includeIfNull: false) required WorkerDTO? worker,
    required UserDTO client,
  }) = _WorkTaskDTO;

  factory WorkTaskDTO.fromDomain(WorkTask workTask) {
    return WorkTaskDTO(
      id: workTask.id.getOrCrash(),
      name: workTask.name.getOrCrash(),
      description: workTask.description.getOrCrash(),
      type: workTask.type.getOrCrash(),
      hours: workTask.hours.getOrCrash(),
      beginDate: workTask.beginDate.getOrCrash(),
      store: StoreDTO.fromDomain(workTask.store),
      worker: workTask.worker != null
          ? WorkerDTO.fromDomain(workTask.worker!)
          : null,
      client: UserDTO.fromDomain(getCurrentUser()!),
      rating: workTask.rating.getOrCrash(),
      endDate: workTask.endDate.getOrCrash(),
      completed: workTask.completed,
    );
  }

  WorkTask toDomain() {
    return WorkTask(
      id: id != null ? UniqueId.fromUniqueString(id!) : UniqueId(),
      name: WorkTaskName(name),
      type: WorkTaskType(type),
      store: store.toDomain(),
      worker: (worker ?? worker!.toDomain()) as Worker?,
      hours: WorkTaskHours(hours),
      rating: WorkTaskRating(rating),
      beginDate: WorkTaskBegin(beginDate),
      endDate: WorkTaskEnd(endDate),
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

User? getCurrentUser() {
  getIt<IAuthRepository>()
      .getSignedInUser()
      .then((value) => value.fold(() => null, (a) => a))
      .onError((error, stackTrace) => null);
  return null;
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

@freezed
abstract class StoreDTO implements _$StoreDTO {
  const StoreDTO._();

  const factory StoreDTO({
    required String id,
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

@freezed
abstract class UserDTO implements _$UserDTO {
  const UserDTO._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UserDTO({
    required String id,
    required String username,
    required String email,
    required String firstName,
    required String lastName,
  }) = _UserDTO;

  factory UserDTO.fromDomain(User user) {
    return UserDTO(
      id: user.id.getOrCrash(),
      username: user.username.getOrCrash(),
      email: user.emailAddress.getOrCrash(),
      firstName: user.firstName,
      lastName: user.lastName,
    );
  }

  User toDomain() {
    return User(
      id: UniqueId.fromUniqueString(id),
      username: Username(username),
      emailAddress: EmailAddress(email),
      firstName: firstName,
      lastName: lastName,
    );
  }

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);
}

@freezed
abstract class WorkerDTO implements _$WorkerDTO {
  const WorkerDTO._();

  const factory WorkerDTO({
    required String id,
    required String fullName,
    required String position,
    required UserDTO? user,
    required double rating,
  }) = _WorkerDTO;

  factory WorkerDTO.fromDomain(Worker worker) {
    return WorkerDTO(
      id: worker.id.getOrCrash(),
      fullName: worker.fullName.getOrCrash(),
      position: worker.position.getOrCrash(),
      rating: worker.rating.getOrCrash(),
      user: worker.user != null ? UserDTO.fromDomain(worker.user!) : null,
    );
  }

  Worker toDomain() {
    return Worker(
      id: UniqueId.fromUniqueString(id),
      fullName: WorkerFullName(fullName),
      position: WorkerPosition(position),
      rating: WorkerRating(rating),
      user: (user ?? user!.toDomain()) as User,
    );
  }

  factory WorkerDTO.fromJson(Map<String, dynamic> json) =>
      _$WorkerDTOFromJson(json);

  factory WorkerDTO.fromFirestore(DocumentSnapshot doc) =>
      WorkerDTO.fromJson(doc.data() as Map<String, dynamic>)
          .copyWith(id: doc.id);
}
