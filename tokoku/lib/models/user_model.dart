import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String namaToko;
  final String email;
  final String password;

  UserModel({
    required this.id,
    required this.namaToko,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        id,
        namaToko,
        email,
        password,
      ];
}
