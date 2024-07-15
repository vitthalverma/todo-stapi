import 'dart:convert';
import 'package:frontend/core/constants/app_creds.dart';
import 'package:frontend/core/error/exceptions.dart';
import 'package:frontend/core/manager/token_manager.dart';
import 'package:frontend/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract interface class AuthRemoteDataSource {
  Future<UserModel> login(String identifier, String password);
  Future<UserModel> signUp(String username, String email, String password);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<UserModel> login(String identifier, String password) async {
    try {
      final response = await client.post(
        Uri.parse('$baseAuthUrl/auth/local'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(
            <String, String>{'identifier': identifier, 'password': password}),
      );
      if (response.statusCode == 200) {
        final userModel = UserModel.fromJson(jsonDecode(response.body));
        await saveToken(userModel.jwt);
        return userModel;
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      print(e);
      throw NtwkException(e.toString());
    }
  }

  @override
  Future<UserModel> signUp(
      String username, String email, String password) async {
    try {
      final response = await client.post(
          Uri.parse('$baseAuthUrl/auth/local/register'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(
            <String, String>{
              'username': username,
              'email': email,
              'password': password
            },
          ));

      if (response.statusCode == 200) {
        final token = jsonDecode(response.body)['jwt'];
        await saveToken(token);
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      throw NtwkException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    await deleteToken();
  }
}
