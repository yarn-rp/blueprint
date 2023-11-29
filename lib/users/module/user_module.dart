import 'package:authentication_repository/authentication_repository.dart';
import 'package:blueprint/users/state_management/cubit/user_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:user_repository/user_repository.dart';

@module
abstract class UserModule {
  @lazySingleton
  UserRepository userRepository(
    FirebaseFirestore firestore,
    AuthenticationRepositoryContract authenticationRepository,
  ) =>
      UserRepository(
        currentUserIdStream: authenticationRepository.authenticationStream
            .map((event) => event!.id),
        firestore: firestore,
      );

  @lazySingleton
  UserCubit userCubit(
    UserRepository userRepository,
  ) =>
      UserCubit(userRepository: userRepository);
}
