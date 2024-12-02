import 'package:jdr/services/class/stat_service.dart';

class Stat {
  String? id;
  String name;
  int value;
  int? max;

  Stat({
    this.id,
    required this.name,
    required this.value,
    this.max,
  });

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
      'name': name,
      'value': value,
      'max': max,
    };
  }

  factory Stat.fromMap(Map<String, dynamic> map) {
    return Stat(
      id: map['id'],
      name: map['name'],
      value: map['value'],
      max: map['max'],
    );
  }
}
