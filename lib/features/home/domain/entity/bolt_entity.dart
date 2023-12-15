class BoltPayload {
  final int duration;
  final DateTime? timestamp;

  BoltPayload({required this.duration, this.timestamp});

  factory BoltPayload.fromMap(Map<String, dynamic> map) {
    return BoltPayload(
      duration: map['duration'],
      timestamp: map['timestamp'].toDate(),
    );
  }
}
