class Weighin {
  final int id;
  final double weight;
  final DateTime date;

  Weighin({
    required this.id,
    required this.weight,
    required this.date,
  });

  // Uncomment the following method if you need to convert the object to a map, but
  // since we await the ID from the database there is no reason to convert it to a map
  // to add into the database
  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'weight': weight,
  //     'date': date.millisecondsSinceEpoch,
  //   };
  // }

  factory Weighin.fromMap(Map<String, dynamic> map) {
    return Weighin(
      id: map['id'],
      weight: double.parse(map['weight']),
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }
}
