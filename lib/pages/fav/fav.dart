


class Fav {
  final String name;
  final bool favourite;
  Fav({required this.name, required this.favourite});

  Fav copyWith({
    String ? name,
    bool ? favourite,
  }){
    return Fav(name: name ?? this.name, 
    favourite: favourite ?? this.favourite);
  }

}