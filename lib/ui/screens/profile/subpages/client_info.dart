import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/models/client/client.dart';
import 'package:serv_expert_webclient/ui/app_providers.dart';
import 'package:serv_expert_webclient/ui/components/fillable_scrollable_wrapper.dart';

class ClientInfoPage extends ConsumerStatefulWidget {
  const ClientInfoPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClientInfoPageState();
}

class _ClientInfoPageState extends ConsumerState<ClientInfoPage> {
  @override
  Widget build(BuildContext context) {
    Client client = ref.read(currentClientStreamProvider).value!;

    return Container(
      color: Colors.white,
      child: FillableScrollableWrapper(
        child: Column(
          children: [
            header(),
            info(client),
          ],
        ),
      ),
    );
  }

  Widget info(Client client) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.05),
        border: Border.all(
          color: Colors.deepPurple.withOpacity(0.25),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Text('Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            ],
          ),
          Row(
            children: [
              const Text('Name:'),
              const SizedBox(
                width: 4,
              ),
              Text('${client.firstName} ${client.lastName}'),
            ],
          ),
          Row(
            children: [
              const Text('Email:'),
              const SizedBox(
                width: 4,
              ),
              Text(client.email),
            ],
          ),
          Row(
            children: [
              const Text('Phone:'),
              const SizedBox(
                width: 4,
              ),
              Text(client.phone),
            ],
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: const [
          Text('Client info', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
