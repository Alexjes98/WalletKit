import 'package:flutter/material.dart';
import 'package:wallet_kit/DTO/person_dto.dart';
import 'package:wallet_kit/services/persons.dart';

class PersonsList extends StatelessWidget {
  final PersonsService personService = PersonsService();
  late Future<List<PersonDTO>> decryptedPersons;
  PersonsList({Key? key}) : super(key: key) {
    decryptedPersons = _loadDecryptedPersons();
  }
  Future<List<PersonDTO>> _loadDecryptedPersons() async {
    List<PersonDTO> persons = await personService.getDecryptedPersons();
    return persons.toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: decryptedPersons,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error loading movements');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No movements available');
        } else {
          return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    PersonDTO person = snapshot.data![index];
                    return ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(person.name),
                      subtitle: Text(person.description),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {},
                      ),
                    );
                  }));
        }
      },
    );
  }
}
