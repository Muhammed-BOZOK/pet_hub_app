import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_friend_hub_app/features/profile/repository/profile_repository.dart';
import 'package:pet_friend_hub_app/models/data/user_model.dart';

final profileControllerProvider = Provider((ref) => ProfileController(
      profileRepository: ref.watch(prfileRepositoryProvider),
    ));

class ProfileController {
  final ProfileRepository profileRepository;

  ProfileController({
    required this.profileRepository,
  });

  Future<UserModel> getuser() async {
    return await profileRepository.getUser();
  }
}
