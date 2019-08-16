import 'package:flutter/material.dart';
import 'app_layout.dart';
import 'util.dart';
import 'app_route.dart';
import 'widgets.dart';
import 'itens_venda.dart';
import 'venda_model.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final GlobalKey<ScaffoldState> _scaffoldstate = GlobalKey<ScaffoldState>();

  int _counter = 0;
  String _lblTot = "";
  int _totItens = 0;
  bool _ocupado = false;
  bool _semItens = false;
 int _skip = 0;

VendaModel _current = VendaModel();

void _add() async {

  
    _current.clienteId = 1;
    _current.comanda = 1;
    _current.vendaId = 1;
  

  ItensVendaModel novoItem = ItensVendaModel();

  novoItem.vendaId = 1;
  novoItem.desconto = 0;
  novoItem.item = 1;
  novoItem.itensVendaId = 1;
  novoItem.produtoId = 1;
  novoItem.quantidade = 1;
  novoItem.valorTotalItem = 10;
  novoItem.valorUnitario = 10;

  if(_current.listItensVenda == null)
    _current.listItensVenda = List<ItensVendaModel>();

  _current.listItensVenda.add(novoItem);
    
    _resetLista();
  } 

   void _removerItem(ItensVendaModel item) async {

    _current.listItensVenda.remove(item);

    _resetLista();
  } 


  // lista global
  List<ItensVendaModel> _listaTela = List<ItensVendaModel>();

  String _titulo = "Mesas/Comandas: ";

  Future<Null> _getData() async {
    _listaTela = [];

    if (mounted)
      setState(() {
        _ocupado = true;
      });
      
    if (mounted)
      setState(() {
        _totItens = _current.listItensVenda.length;
        _ocupado = false;
        if (_totItens == 0) {
          _semItens = true;
        } else {
          _semItens = false;
        }
      });

    // se tem erro exibe snackBar
    // if (!service.tratarErroLoad(resp, _scaffoldstate)) {
    //   return;
    // }

    int _totItensAdd = 0;
    for (var item in _current.listItensVenda) {
      _listaTela.add(item);
        _totItensAdd++;
    }

    if (mounted)
      setState(() {
        _lblTot = Util.exibirTot(_totItensAdd);
      });

    return;
  }

  ScrollController listViewController;

  void _scrollListener() {
    // print(listViewController.position.extentAfter);
    if (listViewController.position.extentAfter < 500) {
      // evita vários get pro servidor
      if (_listaTela.length >= _totItens) {
        return;
      }

      _skip++;
      _getData();
    }
  }

  Future<Null> _resetLista() async {
    _skip = 0;
    _lblTot = Util.exibirTot(0);
    if (mounted)
      setState(() {
        _listaTela.clear();
      });

    await _getData();

    return null;
  }

  @override
  void initState() {
    super.initState();

    listViewController = ScrollController()..addListener(_scrollListener);

    _getData();
  }

  bool _exibirAdd = false;

  @override
  void dispose() {
    listViewController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      key: _scaffoldstate,
     body: (_listaTela.length == 0)
      ? new AppLayout(
        navBar: NavBar(
          title: "$_titulo",
        ),
        widget: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
              ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0, right: 15.0),
                    child: Container(
                        width: 45.0,
                        height: 45.0,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.grey),
                            shape: BoxShape.circle),
                        child: new Icon(Icons.shopping_basket)),
                  ),
                  Text("$_titulo",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 10.0, bottom: 15.0),
              child: Divider(
                height: 1.0,
              ),
            ),
            // sem itens
            Offstage(
              offstage: !_semItens,
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.list,
                    size: 50.0,
                  ),
                  Text('Sem itens'),
                  FlatButton(
                    onPressed: () {
                      _resetLista();
                    },
                    child: Text('Atualizar'),
                  )
                ],
              ),
            ),
            // loading
            Offstage(
              offstage: !_ocupado,
              child: Center(child: CircularProgressIndicator()),
            ),
                  ],
                ),
              ) 
              : new AppLayout(
        navBar: NavBar(
          title: "$_titulo",
        ),
        widget: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
              ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0, right: 15.0),
                    child: Container(
                        width: 45.0,
                        height: 45.0,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.grey),
                            shape: BoxShape.circle),
                        child: new Icon(Icons.shopping_basket)),
                  ),
                  Text("$_titulo",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 10.0, bottom: 15.0),
              child: Divider(
                height: 1.0,
              ),
            ),
            // sem itens
            Offstage(
              offstage: !_semItens,
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.list,
                    size: 50.0,
                  ),
                  Text('Sem itens'),
                  FlatButton(
                    onPressed: () {
                      _resetLista();
                    },
                    child: Text('Atualizar'),
                  )
                ],
              ),
            ),
            // loading
            Offstage(
              offstage: !_ocupado,
              child: Center(child: CircularProgressIndicator()),
            ),

            Flexible(
              child: ClipRect(
                child: RefreshIndicator(
                  onRefresh: _resetLista,
                  
                  child: ListView(
                    padding: const EdgeInsets.only(
                      left: 4.0,
                      right: 4.0,
                    ),
                      controller: listViewController,
                      children: _listaTela.map((it) {
                        return Dismissible(
                          background: Container(color: Colors.red,),
                          key: ValueKey("remover"),
                          onDismissed: (direction){
                            setState((){
                              _removerItem(it);
                            });
                          },
                          child: ListTile(
                          onTap: () {
                          },
                          title: Row(
                            children: <Widget>[
                             
                              Padding(
                                  padding: EdgeInsets.only(right: 12.0),
                                  child: Container(
                                    height: 40.0,
                                    width: 50.0,
                                    child: Icon(
                                      Icons.label,
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                                    color: Colors.blueGrey,
                                  )),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 4.0),
                                          child: Text(
                                            it.valorTotalItem.toString(),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                letterSpacing: 1.0,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 4.0),
                                          child: Text(
                                            it.quantidade.toString(),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              letterSpacing: 1.0,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                        );
                      }).toList()),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '$_lblTot',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
     floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: Icon(Icons.add),
            label: "Adicionar item",
            onTap: () {
              _add();
            }, 
            ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
