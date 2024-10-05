import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/domain/repository/auth/auth.dart';
import 'package:blog_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetUserUsecase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<AuthRepository>().getUser();
  }
}
