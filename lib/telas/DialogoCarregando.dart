import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:simulador_unifique/util/Res.dart';

class DialogoCarregando extends StatefulWidget {
  const DialogoCarregando({Key? key}) : super(key: key);

  @override
  State<DialogoCarregando> createState() => _DialogoCarregandoState();
}

class _DialogoCarregandoState extends State<DialogoCarregando> {
  Res res = Res();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        width: 100,
        height: 100,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeText(
                  "Carregando...",
                  style: res.texto_bold_azul_16,
                  minFontSize: 8,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        )
    );
  }
}