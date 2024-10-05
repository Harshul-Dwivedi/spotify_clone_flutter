import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/data/models/auth/signin_user_req.dart';
import 'package:blog_app/domain/repository/auth/auth.dart';
import 'package:blog_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class SigninUsecase implements Usecase<Either, SigninUserReq> {
  @override
  Future<Either> call({SigninUserReq? params}) async {
    return sl<AuthRepository>().signin(params!);
  }
}
