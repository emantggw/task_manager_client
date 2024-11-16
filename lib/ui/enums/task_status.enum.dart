enum TaskStatus { active, done }

extension TaskStatusX on TaskStatus {
  bool get isActive => TaskStatus.active == this;
  bool get isDone => TaskStatus.done == this;
}
