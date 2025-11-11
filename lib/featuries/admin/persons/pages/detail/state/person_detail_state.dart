import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flutter/widgets.dart';

class PersonDetailState extends ChangeNotifier {
  PersonModel? _personModel;

  PersonModel? get personModel => _personModel;

  PersonDetailState(PersonModel? personModel) : _personModel = personModel;

  void setNewState(PersonModel? newState) {
    _personModel = newState;
    notifyListeners();
  }
}
