import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/data/models/auth/create_user_req.dart';
import 'package:blog_app/domain/repository/auth/auth.dart';
import 'package:blog_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class SignupUsecase implements Usecase<Either, CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq? params}) async {
    return sl<AuthRepository>().signup(params!);
  }
}
