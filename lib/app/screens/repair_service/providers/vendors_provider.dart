import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/models/repair_service/vendor.dart';
import 'package:serv_expert_webclient/global_providers.dart';

final vendorsProvider = StreamProvider.autoDispose<List<RSVendor>>((ref) {
  final vendorsRepository = ref.watch(rsVendorsRepositoryProvider);
  return vendorsRepository.vendorsStream();
});
