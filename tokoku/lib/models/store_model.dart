import 'package:equatable/equatable.dart';

class StoreModel extends Equatable {
  final String id;
  final String namaToko;
  final String alamat;

  StoreModel({
    this.id = '',
    required this.namaToko,
    required this.alamat,
  });

  factory StoreModel.fromJson(String id, Map<String, dynamic> json) {
    return StoreModel(
      id: id,
      namaToko: json['nama_toko'],
      alamat: json['alamat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_toko': namaToko,
      'alamat': alamat,
    };
  }

  @override
  List<Object> get props => [id, namaToko, alamat];
}
