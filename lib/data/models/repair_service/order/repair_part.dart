import 'dart:convert';
import 'package:equatable/equatable.dart';

class RepairPart extends Equatable {
  final String name;
  final DateTime date;
  final double price;
  final List<RepairSubpart> subparts;
  final String note;
  final bool selected;
  const RepairPart({
    required this.name,
    required this.date,
    required this.price,
    required this.subparts,
    this.note = '',
    this.selected = false,
  });

  RepairPart copyWith({
    String? name,
    DateTime? date,
    double? price,
    List<RepairSubpart>? subparts,
    String? note,
    bool? selected,
  }) {
    return RepairPart(
      name: name ?? this.name,
      date: date ?? this.date,
      price: price ?? this.price,
      subparts: subparts ?? this.subparts,
      note: note ?? this.note,
      selected: selected ?? this.selected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'date': date.millisecondsSinceEpoch,
      'price': price,
      'subparts': subparts.map((x) => x.toMap()).toList(),
      'note': note,
      'selected': selected,
    };
  }

  factory RepairPart.fromMap(Map<String, dynamic> map) {
    return RepairPart(
      name: map['name'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      price: map['price'] as double,
      subparts: List<RepairSubpart>.from(
        (map['subparts'] as List).map<RepairSubpart>(
          (x) => RepairSubpart.fromMap(x as Map<String, dynamic>),
        ),
      ),
      note: map['note'] as String,
      selected: map['selected'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory RepairPart.fromJson(String source) => RepairPart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      name,
      date,
      price,
      subparts,
      note,
      selected,
    ];
  }
}

class RepairSubpart extends Equatable {
  final String name;
  final DateTime date;
  final double price;
  final String note;
  const RepairSubpart({
    required this.name,
    required this.date,
    required this.price,
    this.note = '',
  });

  RepairSubpart copyWith({
    String? name,
    DateTime? date,
    double? price,
    String? note,
  }) {
    return RepairSubpart(
      name: name ?? this.name,
      date: date ?? this.date,
      price: price ?? this.price,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'date': date.millisecondsSinceEpoch,
      'price': price,
      'note': note,
    };
  }

  factory RepairSubpart.fromMap(Map<String, dynamic> map) {
    return RepairSubpart(
      name: map['name'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      price: map['price'] as double,
      note: map['note'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RepairSubpart.fromJson(String source) => RepairSubpart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, date, price, note];
}
