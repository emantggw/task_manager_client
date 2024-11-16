import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_manager/ui/enums/task_status.enum.dart';

part 'Task.freezed.dart';
part 'Task.g.dart';

@freezed
class Task with _$Task {
  factory Task(
      {required String title,
      required String description,
      required String category,
      required TaskStatus status,
      DateTime? cratedAt,
      String? id}) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
