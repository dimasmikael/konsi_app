import 'package:konsi_app/app/utils/constants.dart';

mixin ValidationMixin {
  dynamic isNotEmpty(dynamic value, [dynamic message]) {
    if (value.isEmpty) return message ?? "Esse campo é obrigatório";
    return null;
  }

  dynamic confirmPassword(String value, String password, [dynamic message]) {
    if (value != password) return message ?? "Esse campo é obrigatório";

    return null;
  }

  dynamic hasSevenChars(dynamic value, [dynamic message]) {
    if (value!.length < 7) {
      return message ?? "Esse campo é obrigatório";
    }
    return null;
  }

  dynamic checkEmail(dynamic value, [dynamic message]) {
    if (!value.contains("@")) return message ?? "Digite um email válido";
    return null;
  }

  dynamic combine(List<dynamic Function()>? validators) {
    for (final func in validators!) {
      final validation = func();
      if (validation != null) return validation;
    }
    return null;
  }
}
