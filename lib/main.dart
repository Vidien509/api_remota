import 'package:flutter/material.dart';
import 'servicoapi.dart';
import 'cidade.dart';

void main() {
  runApp(const CidadesApp());
}

class CidadesApp extends StatelessWidget {
  const CidadesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cidades App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CidadesScreen(),
    );
  }
}

class CidadesScreen extends StatefulWidget {
  const CidadesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CidadesScreenState createState() => _CidadesScreenState();
}

class _CidadesScreenState extends State<CidadesScreen> {
  List<Cidade> _cidades = [];
  List<Cidade> _filteredCidades = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCidades();
  }

  Future<void> _fetchCidades() async {
    try {
      List<Cidade> cidades = await ServicoApi.fetchCidades();
      setState(() {
        _cidades = cidades;
        _filteredCidades = cidades;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // ignore: avoid_print
      print(e);
    }
  }

  void _filterCidades(String query) {
    List<Cidade> filtered = _cidades.where((cidade) {
      return cidade.nome.toLowerCase().contains(query.toLowerCase()) ||
          cidade.estado.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredCidades = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cidades'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: _filterCidades,
                    decoration: const InputDecoration(
                      labelText: 'Buscar Cidade',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredCidades.length,
                    itemBuilder: (context, index) {
                      Cidade cidade = _filteredCidades[index];
                      return ListTile(
                        title: Text(cidade.nome),
                        subtitle: Text(
                            '${cidade.estado} - População: ${cidade.populacao}'),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
