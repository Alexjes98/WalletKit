import 'package:flutter/material.dart';
import 'package:wallet_kit/DTO/person_dto.dart';
import 'package:wallet_kit/services/persons.dart';

class PersonsSelect extends StatefulWidget {
  PersonsSelect({super.key, required this.onChangeDropdownItem});
  Function onChangeDropdownItem;

  @override
  State<PersonsSelect> createState() => _PersonsSelectState();
}

class _PersonsSelectState extends State<PersonsSelect> {
  final PersonsService personService = PersonsService();
  late Future<List<PersonDTO>> decryptedPersons;
  late PersonDTO selectedPerson;

  _PersonsSelectState() {
    decryptedPersons = _loadDecryptedPersons();
  }

  Future<List<PersonDTO>> _loadDecryptedPersons() async {
    List<PersonDTO> persons = await personService.getDecryptedPersons();
    selectedPerson = persons.first;
    widget.onChangeDropdownItem(selectedPerson.id, selectedPerson.name);
    return persons.toList();
  }

  void onChangeDropdownItem(PersonDTO? selectedPerson) {
    setState(() {
      this.selectedPerson = selectedPerson!;
    });
    widget.onChangeDropdownItem(selectedPerson?.id, selectedPerson?.name);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: decryptedPersons,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error loading persons');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No persons available');
        } else {
          return DropdownButton<PersonDTO>(
            padding: const EdgeInsets.all(10),
            icon: const Icon(Icons.person),
            value: selectedPerson,
            items: snapshot.data!
                .map<DropdownMenuItem<PersonDTO>>((PersonDTO person) {
              return DropdownMenuItem<PersonDTO>(
                value: person,
                child: Text(person.name),
              );
            }).toList(),
            onChanged: onChangeDropdownItem,
          );
        }
      },
    );
  }
}
