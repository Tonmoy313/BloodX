import 'package:serverpod/serverpod.dart';

import 'donor_prompt_service.dart';

class DonorPromptEndpoint extends Endpoint {
  final DonorPromptService _service = DonorPromptService();

  @override
  bool get requireLogin => true;

  Future<bool> claimDonorPrompt(Session session) {
    return _service.claimPrompt(session);
  }
}
