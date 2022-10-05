import 'package:konsi_app/app/data/models/user_model.dart';
import 'package:konsi_app/app/data/provider/login_provider.dart';

class LoginRepository {
  final LoginApiClient apiClient = LoginApiClient();

  Future createUserWithEmailAndPassword(String email, String password,) {
    return apiClient.createUserWithEmailAndPassword(email, password);
  }

  Future signInWithEmailAndPassword(String email, String password) {
    return apiClient.signInWithEmailAndPassword(email, password);
  }

  signOut() {
    apiClient.signOut();
  }
}
