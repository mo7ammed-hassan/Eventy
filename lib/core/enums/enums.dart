enum StepStatus { completed, inProgress, pending }

enum EventType { public, private }

enum ScheduleViewMode { daily, full }

extension CapitalizedEnum on Enum {
  String get capitalizedName => name[0].toUpperCase() + name.substring(1);
}
