import 'package:roomplan_flutter/roomplan_flutter.dart';

/// Represents the final result of a successful room scan.
class ScanResult {
  /// The structured data of the scanned room, including walls and objects.
  final RoomData room;

  /// Metadata associated with the scanning session.
  final ScanMetadata metadata;

  /// Confidence levels for various aspects of the scan.
  final ScanConfidence confidence;

  /// Absolute path to the temporary USDZ file generated for this scan.
  ///
  /// The file is removed when the next scan starts, so copy it elsewhere if
  /// it needs to be retained permanently.
  final String? usdzFilePath;

  /// Creates a [ScanResult] object.
  const ScanResult({
    required this.room,
    required this.metadata,
    required this.confidence,
    this.usdzFilePath,
  });

  /// Creates a [ScanResult] from a JSON map.
  factory ScanResult.fromJson(Map<String, dynamic> json) {
    return ScanResult(
      room: RoomData.fromJson(json['room'] as Map<String, dynamic>? ?? {}),
      metadata: ScanMetadata.fromJson(
          json['metadata'] as Map<String, dynamic>? ?? {}),
      confidence: ScanConfidence.fromJson(
          json['confidence'] as Map<String, dynamic>? ?? {}),
      usdzFilePath: (json['usdz_file_path'] ?? json['usdzFilePath']) as String?,
    );
  }

  /// Converts this [ScanResult] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'room': room.toJson(),
      'metadata': metadata.toJson(),
      'confidence': confidence.toJson(),
      'usdz_file_path': usdzFilePath,
    };
  }

  /// Creates a copy of this scan result with modified values.
  ScanResult copyWith({
    RoomData? room,
    ScanMetadata? metadata,
    ScanConfidence? confidence,
    String? usdzFilePath,
  }) {
    return ScanResult(
      room: room ?? this.room,
      metadata: metadata ?? this.metadata,
      confidence: confidence ?? this.confidence,
      usdzFilePath: usdzFilePath ?? this.usdzFilePath,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScanResult &&
        other.room == room &&
        other.metadata == metadata &&
        other.confidence == confidence &&
        other.usdzFilePath == usdzFilePath;
  }

  @override
  int get hashCode => Object.hash(room, metadata, confidence, usdzFilePath);

  @override
  String toString() {
    return 'ScanResult(room: $room, metadata: $metadata, '
        'confidence: $confidence, usdzFilePath: $usdzFilePath)';
  }
}
