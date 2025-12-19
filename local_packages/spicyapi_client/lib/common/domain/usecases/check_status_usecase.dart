import 'package:either_dart/either.dart';
import 'package:spicyapi_client/common/domain/repository/body/check_status_body.dart';
import '../entities/answer/answer.dart';
import '../repository/spacyapi_repository.dart';

class CheckStatus {
  final SpacyAPIRepository _bananaRepository;
  final String _apiKey;
  final String _clientId;

  CheckStatus({
    required SpacyAPIRepository repository,
    required String apiKey,
    required String clientId,
  }) : _bananaRepository = repository,
       _apiKey = apiKey,
       _clientId = clientId;

  Future<Either<SendMessageError, Answer>> call({
    required String requestId,
  }) async {
    var result = await _bananaRepository.checkStatus(
      CheckStatusBody(
        apiKey: _apiKey,
        clientId: _clientId,
        requestId: requestId,
      ),
    );
    return result;
  }
}
