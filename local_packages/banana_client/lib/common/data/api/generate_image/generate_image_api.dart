import 'package:banana_client/common/data/models/answer/answer_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'body/request_model.dart';

part 'generate_image_api.g.dart';

@RestApi()
abstract class GenerateImageApi {
  factory GenerateImageApi(Dio dio) => _GenerateImageApi(dio);

  @POST('/v1beta/models/gemini-2.5-flash-image:generateContent')
  Future<AnswerModel> send({@Body() required RequestModel request});
}
