import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_friend_hub_app/models/data/user_model.dart';

import '../repository/auth_repository.dart';

final authContreollerProvider = Provider(
  (ref) => AuthContreoller(authRepository: ref.watch(authRepositoryProvider)),
);

class AuthContreoller {
  final AuthRepository authRepository;
  AuthContreoller({required this.authRepository});

  Future<void> signInWithEmailAndPassword({required UserModel userModel}) {
    return authRepository.signInWithEmailAndPassword(
      email: userModel.email,
      password: userModel.password!,
    );
  }

  Future<void> signUpWithEmailAndPassword(
      {required UserModel userModel}) async {
    return authRepository.signUpWithEmailAndPassword(userModel: userModel);
  }

  Future<void> signInWithGoogle() {
    return authRepository.signInWithGoogle();
  }
}
