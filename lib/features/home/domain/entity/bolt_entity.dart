class BoltPayload {
  final String? id;
  final int duration;
  final DateTime? timestamp;

  BoltPayload({required this.duration, this.timestamp, this.id});

  factory BoltPayload.fromMap(Map<String, dynamic> map, String id) {
    return BoltPayload(
        duration: map['duration'],
        timestamp: map['timestamp'].toDate(),
        id: id);
  }
}
