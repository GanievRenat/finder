import '../../models/answer/answer_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'body/check_status_model.dart';

part 'check_status_api.g.dart';

@RestApi()
abstract class CheckStatusApi {
  factory CheckStatusApi(Dio dio) => _CheckStatusApi(dio);

  @POST('/status')
  Future<AnswerModel> send({@Body() required CheckStatusModel request});
}



/* 
{
    "request_id": "a176951e-1690-4180-a8b9-4a4f7a414fe2",
    "status": "processing" // completed, failed, processing, or cancelled)
}
*/