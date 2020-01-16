import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget { // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Comunidade Lellas',
      theme: ThemeData(
        primaryColor: Colors.brown,
      ),
      home: MyCLStatefull(),
    );
  }
}

class MyCLStatefull extends StatefulWidget {
  @override
  MyCLState createState() => MyCLState();
}

class MyCLState extends State<MyCLStatefull> {
  final _suggestions = <WordPair>[];
  final _suggestionsRow = <Text>[];

  final Set<WordPair> _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Menu',
          onPressed: null, // TODO Implementar menu, Login, profile etc
        ),
        title: Text('Comunidade Lellas'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_back),
              tooltip: 'Nível anterior',
              onPressed:null, // TODO Implementar navegação para traz. Pode ser implementada através do touch na tela par a direita.
          ),
          IconButton(
              icon: Icon(Icons.arrow_forward),
              tooltip: 'Nivel posterior',
              onPressed: _pushSaved), // TODO Implementar navegação para frente. Pode ser implementada através do touch na tela par a esquerda.
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
                (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          )
              .toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(   // Add the lines from here...
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),                // ... to here.
      onTap: () {      // Add 9 lines from here...
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}