class Author {
  final String name;
  final int? birthYear;
  final int? deathYear;

  Author({required this.name, this.birthYear, this.deathYear});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(name: json['name'] as String, birthYear: json['birth_year'] as int?, deathYear: json['death_year'] as int?);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'birth_year': birthYear, 'death_year': deathYear};
  }
}
