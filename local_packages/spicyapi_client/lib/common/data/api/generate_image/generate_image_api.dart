import '../../../data/models/answer/answer_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'body/request_model.dart';

part 'generate_image_api.g.dart';

@RestApi()
abstract class GenerateImageApi {
  factory GenerateImageApi(Dio dio) => _GenerateImageApi(dio);

  @POST('/generateIdentityImage')
  Future<AnswerModel> send({@Body() required RequestModel request});
}



/* 
{
    "request_id": "a176951e-1690-4180-a8b9-4a4f7a414fe2",
    "status": "processing" // completed, failed, processing, or cancelled)
}
*/