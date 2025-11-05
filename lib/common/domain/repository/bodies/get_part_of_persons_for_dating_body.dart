import 'package:flirta/common/domain/entites/entities.dart';

import 'body_request.dart';

class GetPartOfPersonsForDatingBody extends RequestBody {
  final FilterData _filterData;
  final String _userUid;

  GetPartOfPersonsForDatingBody({
    required FilterData filter,
    required String userUid,
  }) : _filterData = filter,
       _userUid = userUid;

  FilterData get filterData => _filterData;
  String get userUid => _userUid;

  @override
  Map<String, dynamic> toMap() {
    return {
      "interestedGender": _filterData.interestedGender.index,
      "selectTags": _filterData.selectTags,
    };
  }
}
