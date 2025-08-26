enum ConnectionStatus {
  pending,
  accepted,
  rejected,
}

class ConnectionModel {
  final String id;
  final String requesterId;
  final String receiverId;
  final ConnectionStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  ConnectionModel({
    required this.id,
    required this.requesterId,
    required this.receiverId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ConnectionModel.fromJson(Map<String, dynamic> json) {
    return ConnectionModel(
      id: json['id'],
      requesterId: json['requesterId'],
      receiverId: json['receiverId'],
      status: ConnectionStatus.values.firstWhere(
        (e) => e.toString() == 'ConnectionStatus.${json['status']}',
      ),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'requesterId': requesterId,
      'receiverId': receiverId,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}