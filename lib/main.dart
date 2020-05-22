import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main()
{
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MyApp(),
    ),
  );
}

class Counter with ChangeNotifier
{
  int value = 0;

  void increment()
  {
    value += 1;
    notifyListeners();
  }

  void decrement()
  {
    value -= 1;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'Color Picker',
      home: ColorsPicker()
    );
  }
}

class ColorsPicker extends StatefulWidget
{
  @override
  _ColorsPickerState createState() => _ColorsPickerState();
}

class _ColorsPickerState extends State<ColorsPicker>
{
  final Set<String> _saved = Set<String>();
  List<String> _colorList = ['Red', 'Blue', 'Yellow', 'Green'];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Widget build(BuildContext context)
  {
    final provider = Provider.of<Counter>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Picker'),
      ),
      body: _buildColorList(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: new Text('Number of colors picked: ${provider.value}',
        style: TextStyle(fontSize: 25, color: Colors.white),
        textAlign: TextAlign.center,
        ),
      ),
    );
  }
  Widget _buildColorList()
  {
    return ListView.builder(
    itemCount: _colorList.length,
    padding: const EdgeInsets.all(1.0),
    itemBuilder: (context, i)
    {
     return _buildRow(_colorList[i]);
    }
  );
  }
  Widget _buildRow(String string)
  {
    final bool savedColor = _saved.contains(string);
    final provider = Provider.of<Counter>(context);
    return ListTile(
        title: new Text(string,
        style: _biggerFont,
        ),
        trailing: Icon(
          savedColor ? Icons.favorite : Icons.favorite,
          color: savedColor? Colors.red: null,
        ),
        onTap: ()
        {
          setState(() 
          {
            if (savedColor)
            {
              _saved.remove(string);
              provider.decrement();
            }
            else
            {
              _saved.add(string);
              provider.increment();
            }
          });
        },
      );

  }
}