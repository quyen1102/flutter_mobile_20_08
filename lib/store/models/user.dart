import 'package:flutter/material.dart';

/*
  id
  userName // tên đăng nhập
  password //mật khẩu
  fullName // Họ tên đầy đủ
  gender   //Gới tính 0:Nữ || 1: Nam
  birthDate   // ngày sinh
  age   Tuổi
  email  //
  address   //địa chỉ
  hometown //
  avatar //đường dẫn ảnh đại diện
  productsInCart  // list id product
  orderId // id đơn hàng
  bankNumber // số tk ngân hàng
  bankName // tên ngân hàng
  qrcodeUrl //
 */
@immutable
class User {
  final int id;
  final String userName;
  final String password;
  final String fullName;
  final int gender;
  final String birthDate;
  final int age;
  final String email;
  final String address;
  final String hometown;
  final String avatar;
  final String productsInCart;
  final int orderId;
  final int bankNumber;
  final String bankName;
  final String qrcodeUrl;

  const User({
    required this.id,
    required this.userName,
    required this.password,
    required this.fullName,
    required this.gender,
    required this.birthDate,
    required this.age,
    required this.email,
    required this.address,
    required this.hometown,
    required this.avatar,
    required this.productsInCart,
    required this.orderId,
    required this.bankNumber,
    required this.bankName,
    required this.qrcodeUrl
});

}