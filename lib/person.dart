class Person {
  Person(this.name, this.surname, this.phoneNumber, this.password);

  final String name;
  final String surname;
  final String phoneNumber;
  final String password;

  Person.fromJson(Map<String, dynamic> json) :
        name = json['name'],
        surname = json['surname'],
        phoneNumber = json['phone_number'],
        password = json['password'];

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'surname': surname,
        'phone_number': phoneNumber,
        'password': password
      };
}