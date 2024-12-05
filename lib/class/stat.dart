import 'package:jdr/services/class/stat_service.dart';
import 'package:uuid/uuid.dart';

class Stat {
  String? id;
  String name;
  int value;
  int? max;

  static const Uuid _uuid = Uuid();

  Stat({
    String? id,
    required this.name,
    required this.value,
    this.max,
  }) : id = id ?? _uuid.v4();

  @override
  String toString() {
    return 'User{id: $id, name: $name, value: $value, max: $max}';
  }

  Future<void> createStat(String userId, String characterId) async {
    await StatService().createStat(this, userId, characterId);
  }

  static Future<Stat?> readStat(String userId, String characterId, String statId) async {
    return await StatService().readStat(userId, characterId, statId);
  }

  Future<void> updateStat(String userId, String characterId) async {
    await StatService().updateStat(this, userId, characterId);
  }

  static Future<void> deleteStat(String userId, String characterId, String statId) async {
    await StatService().deleteStat(userId, characterId, statId);
  }

  void updateValue(int newValue) {
    if (max != null && newValue > max!) {
      throw Exception('Value exceeds maximum limit');
    } else {
      value = newValue;
    }
  }

  void updateMax(int newMax) {
    if (newMax >= value) {
      max = newMax;
    } else {
      throw Exception('New max is less than current value');
    }
  }

  void resetValue() {
    value = 0;
  }

  void increaseValue(int increment) {
    if (value + increment <= max!) {
      value += increment;
    } else {
      throw Exception('Value exceeds maximum limit');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'max': max ?? '',
    };
  }

  factory Stat.fromMap(Map<String, dynamic> map) {
    Stat s =  Stat(
      id: map['id'],
      name: map['name'],
      value: map['value'] is String ? int.parse(map['value']) : map['value'] as int,
      max: map['max'] != null ? (map['max'] is String ? int.parse(map['max']) : map['max'] as int?) : null,
    );
    print(s);
    return s;
  }
}
