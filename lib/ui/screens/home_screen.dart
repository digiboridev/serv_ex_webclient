import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/ui/components/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/ui/components/header.dart';
import 'package:serv_expert_webclient/ui/router.gr.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FillableScrollableWrapper(
        child: Column(
          children: [
            Header(context: context),
            const Spacer(),
            const Text(
              'HOME',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                serviceTile(),
                ordersTile(),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget serviceTile() {
    return Container(
      width: 300,
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.deepPurple,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.router.navigate(const RepairServiceVendorsScreenRoute());
          },
          child: Center(
            child: Text('SERVICE', style: const TextStyle(color: Colors.white, fontSize: 24)),
          ),
        ),
      ),
    );
  }

  Widget ordersTile() {
    return Container(
      width: 300,
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.deepPurple,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Center(
            child: Text('ERTAX', style: const TextStyle(color: Colors.white, fontSize: 24)),
          ),
        ),
      ),
    );
  }
}
