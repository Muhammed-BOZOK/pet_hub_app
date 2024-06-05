class PetModel {
  String? petId;
  String? ownerId;
  String? name;
  String? species;
  String? breed;
  String? age;
  String? gender;
  String? weight;
  String? color;
  String? about;

  PetModel({
    this.petId,
    this.ownerId,
    this.name,
    this.species,
    this.breed,
    this.age,
    this.gender,
    this.weight,
    this.color,
    this.about,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      petId: json['pet_id'],
      ownerId: json['owner_id'],
      name: json['name'],
      species: json['species'],
      breed: json['breed'],
      age: json['age'],
      gender: json['gender'],
      weight: json['weight'],
      color: json['color'],
      about: json['about'],
    );
  }

  Map<String, dynamic> toJson() => {
        'pet_id': petId,
        'owner_id': ownerId,
        'name': name,
        'species': species,
        'breed': breed,
        'age': age,
        'gender': gender,
        'weight': weight,
        'color': color,
        'about': about,
      };
}
