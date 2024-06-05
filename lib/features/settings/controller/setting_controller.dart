import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_friend_hub_app/features/settings/repository/setting_repository.dart';

final settingControllerProvider = Provider((ref) =>
    SettingController(settingRepository: ref.watch(settingRepositoryProvider)));

class SettingController {
  final SettingRepository settingRepository;

  SettingController({
    required this.settingRepository,
  });

  Future<void> updateProfilePhoto(File newPhoto) async {
    return await settingRepository.updateProfilePhoto(newPhoto);
  }
}
