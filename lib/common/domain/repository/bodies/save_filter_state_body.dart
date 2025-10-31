import 'package:flirta/common/domain/entites/entities.dart';

import 'body_request.dart';

class SaveFilterStateBody extends RequestBody {
  final FilterData _filterData;

  SaveFilterStateBody({required FilterData filter}) : _filterData = filter;

  @override
  Map<String, dynamic> toMap() {
    return {
      "interestedGender": _filterData.interestedGender.index,
      "selectTags": _filterData.selectTags,
    };
  }
}
