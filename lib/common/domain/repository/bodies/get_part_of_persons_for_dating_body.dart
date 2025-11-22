import 'package:flirta/common/domain/entites/entities.dart';

import 'body_request.dart';

class GetPartOfPersonsForDatingBody extends RequestBody {
  final FilterData _filterData;
  final String _userUid;
  final int _limit;
  final List<String> _excludeIds;

  GetPartOfPersonsForDatingBody({
    required FilterData filter,
    required String userUid,
    int limit = 10,
    List<String> excludeIds = const [],
  }) : _filterData = filter,
       _userUid = userUid,
       _limit = limit,
       _excludeIds = excludeIds;

  FilterData get filterData => _filterData;
  String get userUid => _userUid;
  int get limit => _limit;
  List<String> get excludeIds => _excludeIds;

  @override
  Map<String, dynamic> toMap() {
    return {
      "interestedGender": _filterData.interestedGender.index,
      "selectTags": _filterData.selectTags,
      "excludeIds": _excludeIds,
      "limit": _limit,
    };
  }
}
