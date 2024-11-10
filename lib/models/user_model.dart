import 'package:user_registration/data/local/db_helper.dart';

class UserModel {
  int? id;
  String name;
  String email;
  String phone;
  String gender;
  bool? isSubmitted;

  UserModel({this.id,
    this.isSubmitted = false,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender});

  factory UserModel.fromMap({required Map<String, dynamic> map}) {
    return UserModel(
      id: map[DbHelper.TableCol_ID],
      name: map[DbHelper.TableCol_Name],
      email: map[DbHelper.TableCol_Email],
      phone: map[DbHelper.TableCol_Phone],
      gender: map[DbHelper.TableCol_Gender],
    );
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String?gender,
    bool? isSubmitted,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      isSubmitted: isSubmitted ?? this.isSubmitted,);
  }

  Map<String, dynamic> toMap() {
    return {
      DbHelper.TableCol_Name: name,
      DbHelper.TableCol_Email: email,
      DbHelper.TableCol_Phone: phone,
      DbHelper.TableCol_Gender: gender,
      DbHelper.TableCol_IsSubmitted: isSubmitted! ? 1 : 0
    };
  }
}
