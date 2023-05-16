import 'package:authentication_repository/authentication_repository.dart';

class LinkCredential extends AuthBaseException {
  LinkCredential(this.credential, [super.message]);

  final AuthCredential credential;
}
