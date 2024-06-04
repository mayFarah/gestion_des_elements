import 'package:flutter/material.dart';
import 'package:gestion_des_elements/models/element.dart';
import 'package:gestion_des_elements/screens/insertElementsScreens.dart';
import 'package:gestion_des_elements/screens/updateElementsScreens.dart';
import 'package:gestion_des_elements/services/sqlDataBase.dart';



class AffichageElementScreen extends StatefulWidget {
  const AffichageElementScreen({super.key});

  @override
  _AffichageElementScreenState createState() => _AffichageElementScreenState();
}

class _AffichageElementScreenState extends State<AffichageElementScreen> {
  late Future<List<Elements>> _future;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    setState(() {
      _future = CruddataBase().getElements();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion d\'élèments'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(onPressed: () => {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: FutureBuilder<List<Elements>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Une erreur s\'est produite'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucune donnée trouvée'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final elements = snapshot.data![index];

                return ListTile(
                  title: Text(elements.nom),
                  subtitle: Text(elements.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.green),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ModifierElementsScreen(elementId: elements.id),
                            ),
                          );
                          if (result != null && result is bool && result) {
                            _refreshData();
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          if (elements.id != null) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirmation"),
                                  content: const Text("Êtes-vous sûr de vouloir supprimer ce élèment ?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Annuler"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await CruddataBase().deleteElement(elements.id!);
                                        _refreshData();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Supprimer"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => insertElementsScreen(),
            ),
          );
          if (result != null && result is bool && result) {
            _refreshData();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
