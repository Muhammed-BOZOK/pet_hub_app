import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../routes/route_name.dart';

final userControlerRepositoryProvider =
    Provider((ref) => UserControlRepository(auth: FirebaseAuth.instance));

class UserControlRepository {
  final FirebaseAuth auth;
  UserControlRepository({
    required this.auth,
  });

  isUserSignedIn() {
    final user = auth.currentUser;
    if (user != null) {
      debugPrint('aktif user mevcut');
      return AppRouteNames.home;
    } else {
      debugPrint('aktif user yok');

      return AppRouteNames.signIn;
    }
  }
}
