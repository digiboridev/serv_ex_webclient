import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/text_styles.dart';
import 'package:serv_expert_webclient/data/dto/repair_service/new_contact.dart';
import 'package:serv_expert_webclient/utils/validators.dart';
import 'package:serv_expert_webclient/widgets/regular_button.dart';

class AddContactDialog extends ConsumerStatefulWidget {
  const AddContactDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddContactDialogState();
}

class _AddContactDialogState extends ConsumerState<AddContactDialog> {
  final formKey = GlobalKey<FormState>();

  NewContactDTO contact = NewContactDTO();

  onAddContact() {
    bool? valid = formKey.currentState?.validate();
    if (valid == true) {
      Navigator.pop(context, contact);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'ADD CONTACT',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: 345,
                child: nameField(label: 'Firstname', initialValue: contact.firstName, onChanged: (value) => setState(() => contact.firstName = value)),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: 345,
                child: nameField(label: 'Lastname', initialValue: contact.firstName, onChanged: (value) => setState(() => contact.lastName = value)),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(width: 345, child: phoneField(label: 'Phone', initialValue: contact.phone, onChanged: (value) => setState(() => contact.phone = value))),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: 345,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RegularButton(
                    text: 'ADD CONTACT',
                    textStyle: AppTextStyles.btnText,
                    onTap: onAddContact,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget nameField({required String label, required String? initialValue, required Function(String) onChanged}) {
    return TextFormField(
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
        onAddContact();
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
        fillColor: Colors.white70,
      ),
    );
  }

  Widget phoneField({required String label, required String? initialValue, required Function(String) onChanged}) {
    return TextFormField(
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
        onAddContact();
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
        fillColor: Colors.white70,
      ),
    );
  }
}
