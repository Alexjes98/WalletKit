import 'package:flutter/material.dart';
import 'package:wallet_kit/DTO/person_dto.dart';
import 'package:wallet_kit/constants/components.dart';
import 'package:wallet_kit/constants/app_colors.dart';
import 'package:wallet_kit/services/persons.dart';
import 'package:wallet_kit/utils/generator.dart';
import 'package:wallet_kit/widgets/textInput/input_text_field.dart';

class AddPersonPage extends StatefulWidget {
  const AddPersonPage({super.key});

  @override
  State<AddPersonPage> createState() => _AddPersonPageState();
}

class _AddPersonPageState extends State<AddPersonPage> {
  TextEditingController personNameController = TextEditingController();
  TextEditingController personDescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: ConstAppBar,
            body: Column(
              children: [
                Expanded(
                    child: ListView(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 50, left: 10, right: 10),
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        'Add person',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 33),
                      ),
                    ),
                    InputTextField(
                      labelText: 'Person name',
                      hintText: 'my friend',
                      icon: Icons.person,
                      keyboardType: TextInputType.text,
                      inputController: personNameController,
                    ),
                    InputTextField(
                      labelText: 'Person description',
                      hintText: 'something to help you remember who this is',
                      icon: Icons.description,
                      keyboardType: TextInputType.text,
                      inputController: personDescriptionController,
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: white,
                          ),
                          onPressed: () async {
                            PersonsService personService = PersonsService();
                            PersonDTO person = PersonDTO(
                                id: int.parse(generateRandomIdByDate()),
                                name: personNameController.text,
                                description: personDescriptionController.text);
                            await personService
                                .saveEncryptedPerson(person)
                                .then((value) => {Navigator.pop(context)});
                          },
                          child: const Text('Add person'),
                        )
                      ],
                    )
                  ],
                ))
              ],
            )));
  }
}
