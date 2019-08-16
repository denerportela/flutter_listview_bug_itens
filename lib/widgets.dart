import 'app_route.dart';
import 'main.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar(
      {Key key,
      this.title = '',
      // this.title = title,
      this.exibirTitulo = false,
      this.isOnMultiSelection = false,
      this.handleOpenMultiSelection,
      this.color = Colors.transparent,
      this.actions = const [],
      this.saveFunc})
      : super(key: key);

  final String title;
  final bool exibirTitulo;
  final Function handleOpenMultiSelection;
  final bool isOnMultiSelection;
  final Color color;
  final List<Widget> actions;
  final Function saveFunc;

  @override
  Widget build(BuildContext context) {
    var requiredActions = [
      // multi sel
      handleOpenMultiSelection != null
          ? IconButton(
              icon: Icon(Icons.check_box),
              onPressed: handleOpenMultiSelection,
            )
          : Container(),

      // salvar em forms ou go home
      Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
            onPressed: () {
              // if (saveFunc != null) {
              //   saveFunc();
              // } else {
              //   if (ObjMem.usuario == null) {
              //     return;
              //   }
              //   Navigator.pushAndRemoveUntil(context,
              //       AppRoute.getAppRoute(HomePage()), ModalRoute.withName('/'));
              // }

              Navigator.push(
                        context, AppRoutes.getAppRoute(MyApp()));
            },
            icon: Icon(
              saveFunc == null ? Icons.home : Icons.save,
              size: 25.0,
              color: Colors.white,
            ),
          )),
    ];

    List<Widget> newActions = [];

    this.actions.forEach((it) => newActions.add(it));
    requiredActions.forEach((it) => newActions.add(it));

    return AnimatedOpacity(
      opacity: isOnMultiSelection ? 0.0 : 1.0,
      duration: Duration(milliseconds: 100),
      child: AppBar(
        //title: Text(title,
        title: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          //child: Text(exibirTitulo ? title : '',
          child: Text(title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0)),
        ),
        backgroundColor: color,
        centerTitle: false,
        actions: newActions,
        elevation: 0.0,
      ),
    );
  }
}