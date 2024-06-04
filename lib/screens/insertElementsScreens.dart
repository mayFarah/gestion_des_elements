import 'package:flutter/material.dart';
import 'package:gestion_des_elements/models/element.dart';
import 'package:gestion_des_elements/services/sqlDataBase.dart';





// ignore: camel_case_types
class insertElementsScreen extends StatelessWidget {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController(); 
  
  insertElementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un élément'),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nomController,
              decoration: const InputDecoration(labelText: "Nom de l'élément"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Description de l'élément"),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                final nom = nomController.text;
                final description = descriptionController.text;
                if (nom.isNotEmpty && description.isNotEmpty) {
                  final element = Elements(nom: nom, description: description);
                  await CruddataBase().insertElement(element);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Élément ajouté avec succès'))
                  );
                  Navigator.pop(context, true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Veuillez saisir tous les champs !'))
                  );
                }
              },
              child: const Text("Ajouter un élément"),
            ),
          ],
        ),
      ),
    );
  }
}
