class Space {
  late final int id;
  late final String name;
  late final String imageUrl;
  late final int price;
  late final String city;
  late final String country;
  late final int rating;
  late final String address;
  late final String phone;
  late final String mapUrl;
  late final List photos;
  late final int numberOfKitchens;
  late final int numberOfBedrooms;
  late final int numberOfCupboards;

  Space({
    required this.city,
    required this.country,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
    required this.address,
    required this.mapUrl,
    required this.numberOfBedrooms,
    required this.numberOfCupboards,
    required this.numberOfKitchens,
    required this.phone,
    required this.photos,
  });

  Space.fromJson(json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    country = json['country'];
    imageUrl = json['image_url'];
    price = json['price'];
    rating = json['rating'];
    address = json['address'];
    phone = json['phone'];
    mapUrl = json["map_url"];
    photos = json['photos'];
    numberOfBedrooms = json['number_of_bedrooms'];
    numberOfCupboards = json['number_of_cupboards'];
    numberOfKitchens = json['number_of_kitchens'];
  }
}
