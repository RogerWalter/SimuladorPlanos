import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../util/Controller.dart';
import '../util/Res.dart';

class DialogoSemAcesso extends StatefulWidget {

  @override
  State<DialogoSemAcesso> createState() => _DialogoSemAcessoState();
}

class _DialogoSemAcessoState extends State<DialogoSemAcesso> {

  Controller controller = Get.find();
  Res res = Res();

  @override
  Widget build(BuildContext context) {

    var largura = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: (largura > 1300) ? largura/3.5 : largura/1.15,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                    image: AssetImage('assets/wallpaper-dialogo.jpg'),
                    //colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.75), BlendMode.modulate,),
                    fit: BoxFit.cover
                )
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Solicitar Acesso",
                        style: res.texto_bold_azul_16,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16,0,16,0),
                      child: Text(
                        "Por gentileza, entre em contato com a equipe de Inovação e Novos Negócios para solicitar acesso ao simulador.",
                        style: res.texto_azul_16,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 0.5,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: <Color>[
                                    Colors.black12.withOpacity(0.05),
                                    Colors.black12.withOpacity(0.25),
                                    Colors.black12.withOpacity(0.5),
                                    Colors.black12.withOpacity(1),
                                    Colors.black12.withOpacity(0.5),
                                    Colors.black12.withOpacity(0.25),
                                    Colors.black12.withOpacity(0.05),
                                  ]
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16,0,16,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                              color: Colors.transparent,
                              height: 56,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  hoverColor: Colors.white.withOpacity(0.5),
                                  highlightColor: Colors.white.withOpacity(0.5),
                                  splashColor: Colors.white.withOpacity(0.5),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: AutoSizeText(
                                      "Entendido!",
                                      style: res.texto_azul_claro_16,
                                      minFontSize: 6,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  onTap: (){Navigator.of(context).pop();},
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
