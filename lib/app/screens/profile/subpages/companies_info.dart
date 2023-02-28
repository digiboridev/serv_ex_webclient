import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/models/company/company.dart';
import 'package:serv_expert_webclient/app/providers/app_providers.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';

class CompaniesInfoPage extends ConsumerStatefulWidget {
  const CompaniesInfoPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CompaniesInfoPageState();
}

class _CompaniesInfoPageState extends ConsumerState<CompaniesInfoPage> {
  @override
  Widget build(BuildContext context) {
    List<Company> companies = ref.read(companiesStreamProvider).value!;

    return Container(
      color: Colors.white,
      child: FillableScrollableWrapper(
        child: Column(
          children: [
            header(),
            ...companies.map((company) => companyInfo(company)),
          ],
        ),
      ),
    );
  }

  Widget companyInfo(Company company) {
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
              Text(company.name),
            ],
          ),
          Row(
            children: [
              const Text('Email:'),
              const SizedBox(
                width: 4,
              ),
              Text(company.email),
            ],
          ),
          Row(
            children: [
              const Text('Id:'),
              const SizedBox(
                width: 4,
              ),
              Text(company.id),
            ],
          ),
          // members
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Members:'),
              const SizedBox(
                width: 4,
              ),
              company.membersIds.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: company.membersIds.map((member) => Text(member)).toList(),
                    )
                  : const Text('No members'),
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
          Text('Companies info', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
