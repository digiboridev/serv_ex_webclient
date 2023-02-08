import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/global_providers.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/router.gr.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _innerRouterKey = GlobalKey<AutoRouterState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          menu(context),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              clipBehavior: Clip.hardEdge,
              child: AutoRouter(
                key: _innerRouterKey,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget menu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.05),
        border: Border(
          right: BorderSide(
            color: Colors.deepPurple.withOpacity(0.25),
            width: 1,
          ),
        ),
      ),
      width: 200,
      child: FillableScrollableWrapper(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Material(
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: () {
                    context.router.replace(const ClientInfoPageRoute());
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Row(
                      children: const [
                        Icon(Icons.person),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Client',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Material(
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: () {
                    context.router.replace(const CompaniesInfoPageRoute());
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Row(
                      children: const [
                        Icon(Icons.business_center),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Companies',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(8),
                    clipBehavior: Clip.hardEdge,
                    child: IconButton(
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      icon: const Icon(
                        Icons.home,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        context.router.navigate(const HomeScreenRoute());
                      },
                    ),
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(8),
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        ref.read(fireAuthServiceProvider).signOut();
                        context.router.replaceAll([const AuthScreenRoute()]);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
