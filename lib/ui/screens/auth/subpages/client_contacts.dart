import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/validators.dart';
import 'package:serv_expert_webclient/data/models/client/client_contact.dart';
import 'package:serv_expert_webclient/ui/components/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/ui/screens/auth/auth_screen.dart';

class ContactBuildDTO {
  String firstName;
  String lastName;
  String phone;

  ContactBuildDTO({
    this.firstName = '',
    this.lastName = '',
    this.phone = '',
  });
}

class ClientContactsSubpage extends ConsumerStatefulWidget {
  const ClientContactsSubpage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ClientContactsSubpage> createState() => _ClientContactsSubpageState();
}

class _ClientContactsSubpageState extends ConsumerState<ClientContactsSubpage> {
  final formKey = GlobalKey<FormState>();
  List<ContactBuildDTO> editableContacts = [];

  onContinue() {
    bool? valid = formKey.currentState?.validate();
    if (valid == true) {
      List<ClientContact> clientContacts = editableContacts
          .map((e) => ClientContact(
                firstName: e.firstName,
                lastName: e.lastName,
                phone: e.phone,
              ))
          .toList();

      ref.read(authScreenControllerProvider.notifier).submitClientContacts(contacts: clientContacts);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Form(
        key: formKey,
        child: FillableScrollableWrapper(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 32,
              ),
              const Text(
                'ADD CONTACTS',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              contactsList(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    editableContacts.add(ContactBuildDTO());
                  });
                },
                child: const Text('Add contact'),
              ),
              const SizedBox(
                height: 32,
              ),
              continueButton(),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column contactsList() {
    return Column(
      children: editableContacts.map((e) {
        return Column(
          children: [
            SizedBox(
              width: 600,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Contact ${editableContacts.indexOf(e) + 1}'),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          editableContacts.remove(e);
                        });
                      },
                      child: const Icon(Icons.delete_sweep_outlined)),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            nameField(
              label: 'First name',
              initialValue: e.firstName,
              onChanged: (value) {
                e.firstName = value;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            nameField(
              label: 'Last name',
              initialValue: e.lastName,
              onChanged: (value) {
                e.lastName = value;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            phoneField(
              label: 'Phone',
              initialValue: e.phone,
              onChanged: (value) {
                e.phone = value;
              },
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget continueButton() {
    return SizedBox(
      width: 600,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            onContinue();
          },
          child: Ink(
            // width: 600,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'CONTINUE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget nameField({required String label, required String? initialValue, required Function(String) onChanged}) {
    return SizedBox(
      width: 600,
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: TextInputType.name,
        maxLength: 20,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter name';
          }
          if (!AppValidators.isValidName(value)) {
            return 'Please enter correct name';
          }
          return null;
        },
        onFieldSubmitted: (value) {
          onContinue();
        },
        onChanged: onChanged,
        decoration: InputDecoration(
            counter: const SizedBox(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            labelText: label,
            fillColor: Colors.white70),
      ),
    );
  }

  Widget phoneField({required String label, required String? initialValue, required Function(String) onChanged}) {
    return SizedBox(
      width: 600,
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: TextInputType.phone,
        maxLength: 20,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter phone';
          }
          if (!AppValidators.isValidPhone(value)) {
            return 'Please enter correct phone';
          }
          return null;
        },
        onFieldSubmitted: (value) {
          onContinue();
        },
        onChanged: onChanged,
        decoration: InputDecoration(
            counter: const SizedBox(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            labelText: label,
            fillColor: Colors.white70),
      ),
    );
  }
}
