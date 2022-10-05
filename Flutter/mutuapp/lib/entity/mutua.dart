import 'Status.dart';

class Mutua {
  int get id => createdDate.hashCode;

  final DateTime createdDate;
  final Status status;

  DateTime? start;
  DateTime? end;
  String? reason;
  String? protocolNumber;

  Mutua.create()
      : createdDate = DateTime.now(),
        status = Status.NEW;

  Mutua._internal({
    required this.createdDate,
    required this.status,
    this.reason,
    this.start,
    this.end,
    this.protocolNumber,
  });

  Mutua copyWith({
    DateTime? start,
    DateTime? end,
    Status? status,
    String? reason,
    String? protocolNumber,
  }) {
    return Mutua._internal(
      createdDate: createdDate,
      status: status ?? this.status,
      reason: reason ?? this.reason,
      start: start ?? this.start,
      end: end ?? this.end,
      protocolNumber: protocolNumber ?? this.protocolNumber,
    );
  }

  Mutua fromJson(Map<String, dynamic> json) {
    DateTime createDate = json['cratedDate'];
    DateTime? start = json['start'];
    DateTime? end = json['end'];
    Status status = json['status'];
    String? reason = json['reason'];
    String? protocolNumber = json['protocolNumber'];

    return Mutua._internal(
      createdDate: createDate,
      start: start,
      end: end,
      status: status,
      reason: reason,
      protocolNumber: protocolNumber,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cratedDate'] = createdDate;
    data['status'] = status;
    data['reason'] = reason;
    data['start'] = start;
    data['end'] = end;
    data['protocolNumber'] = protocolNumber;
    return data;
  }
}
