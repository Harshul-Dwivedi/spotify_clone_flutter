import 'package:blog_app/domain/usecases/auth/get_user.dart';
import 'package:blog_app/presentation/profile/bloc/profile_state.dart';
import 'package:blog_app/service_locator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async {
    var user = await sl<GetUserUsecase>().call();
    user.fold((l) {
      emit(ProfileInfoFailure());
    }, (userEntity) {
      emit(ProfileInfoLoaded(userEntity: userEntity));
    });
  }
}
