class RepairPartDTO {
  final String name;
  final DateTime date;
  final double price;
  final List<RepairSubpartDTO> subparts;
  final String note;
  final bool selected;
  const RepairPartDTO({
    required this.name,
    required this.date,
    required this.price,
    required this.subparts,
    this.note = '',
    this.selected = false,
  });
}

class RepairSubpartDTO {
  final String name;
  final DateTime date;
  final double price;
  final String note;
  const RepairSubpartDTO({
    required this.name,
    required this.date,
    required this.price,
    this.note = '',
  });
}
