import 'package:flutter/material.dart';
class SemDados extends StatefulWidget {
  const SemDados({Key? key}) : super(key: key);

  @override
  State<SemDados> createState() => _SemDadosState();
}

class _SemDadosState extends State<SemDados> {
  @override
  Widget build(BuildContext context) {
    double altura_icone =MediaQuery.of(context).size.height/8;
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.info_outline,
            color: const Color(0xff232f66).withOpacity(0.5),
            size: altura_icone,
          ),
          DefaultTextStyle(
            style: TextStyle(
              color: const Color(0xff232f66).withOpacity(0.5),
              fontSize: 14,
            ),
            child: Text(
              "Não há dados inseridos",
            ),
          )
        ],
      ),
    );
  }
}
