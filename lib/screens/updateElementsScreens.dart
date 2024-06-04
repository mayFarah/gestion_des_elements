import 'package:flutter/material.dart';
import 'package:gestion_des_elements/models/element.dart';
import 'package:gestion_des_elements/services/sqlDataBase.dart';

class ModifierElementsScreen extends StatefulWidget {
  final int? elementId;
  const ModifierElementsScreen({Key? key, this.elementId}) : super(key: key);

  @override
  State<ModifierElementsScreen> createState() => _ModifierElementsScreenState();
}

class _ModifierElementsScreenState extends State<ModifierElementsScreen> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadElementsData();
  }

  @override
  void dispose() {
    nomController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadElementsData() async {
    if (widget.elementId != null) {
      final item = await CruddataBase().getElementById(widget.elementId!);
      if (item != null) {
        setState(() {
          nomController.text = item.nom;
          descriptionController.text = item.description;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier un élément'),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: Icon(Icons.menu),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
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
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                final nom = nomController.text;
                final description = descriptionController.text;
                if (nom.isNotEmpty && description.isNotEmpty) {
                  final item = Elements(
                    id: widget.elementId,
                    nom: nom,
                    description: description,
                  );
                  await CruddataBase().updateElement(item);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Élément mis à jour avec succès')),
                  );
                  Navigator.pop(context, true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Veuillez remplir tous les champs !')),
                  );
                }
              },
              child: Text("Mettre à jour l'élément"),
            ),
          ],
        ),
      ),
    );
  }
}
