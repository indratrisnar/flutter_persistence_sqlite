class Cat {
  final int id;
  final String name;
  final int age;

  Cat({
    required this.id,
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMapInsert() {
    return {
      'name': name,
      'age': age,
    };
  }

  Map<String, dynamic> toMapUpdate() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  factory Cat.fromMap(Map<String, dynamic> map) {
    return Cat(
      id: map['id'],
      name: map['name'],
      age: map['age'],
    );
  }
}
