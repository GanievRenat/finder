import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../di/api_module.dart';
import '../../models/answer/answer_model.dart';
import 'body/chat_completions_body.dart';

part 'chat_completions_api.g.dart';

@RestApi()
@singleton
abstract class ChatCompletionsApi {
  @factoryMethod
  factory ChatCompletionsApi(@Named(DependencyDioName.dioWithKey) Dio dio) =>
      _ChatCompletionsApi(dio);

  @POST('/chat/completions')
  Future<AnswerModel> send({@Body() required ChatCompletionsBody request});
}
