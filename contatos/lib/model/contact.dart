class Contact {
  static final String contactTable = "contactTable";
  static final String contactId = "contactId";
  static final String nameColumn = "nameColumn";
  static final String phoneColumn = "phoneColumn";
  static final String emailColumn = "emailColumn";
  static final String imageColumn = "imageColumn";

  late int id;
  late String name;
  late String phone;
  late String email;
  late String image;

  Contact({
    this.id = 0,
    this.name = "",
    this.email = "",
    this.image = "",
    this.phone = "",
  });

  Contact.fromMap(Map map) {
    id = map[contactId];
    name = map[nameColumn];
    phone = map[phoneColumn];
    email = map[emailColumn];
    image = map[imageColumn];
  }

  Map<String, Object?> toMap() {
    Map<String, Object?> map = {
      nameColumn: name,
      phoneColumn: phone,
      emailColumn: email,
      image: image,
    };

    if (id != 0) map[contactId] = id;
    return map;
  }

  @override
  String toString() {
    return "Contact(id: $id, name: $name, phone: $phone, email: $email, image: $image)";
  }
}
