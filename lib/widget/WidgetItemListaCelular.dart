import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:simulador_unifique/model/ItemMostrar.dart';
import '../util/Controller.dart';
import '../util/Res.dart';

class WidgetItemListaCelular extends StatefulWidget {
  ItemMostrar item;
  int index = -1;
  WidgetItemListaCelular(ItemMostrar this.item, int this.index);

  @override
  State<WidgetItemListaCelular> createState() => _WidgetItemListaCelularState();
}

class _WidgetItemListaCelularState extends State<WidgetItemListaCelular> {
  Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    Res res = Res();
    return Card(
        shadowColor: res.azul_escuro.withOpacity(0.50),
        elevation: 5,
        margin: EdgeInsets.only(bottom: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
                begin: Alignment(-1,-1),
                end: Alignment(1,2),
                colors: <Color>[res.azul_claro, Color(0xff14639B)]),
          ),
          child: Container(
              height: 40,
              child: Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: SvgPicture.asset(
                        widget.item.icone,
                        height: 20,
                      ),
                    ),
                    if(widget.item.info_1.isNotEmpty || widget.item.info_3.isNotEmpty)Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            widget.item.info_1.isNotEmpty
                                ? AutoSizeText(
                                    //controller_mobx.lista_camera[index].tipo,
                                    widget.item.info_1,
                                    textAlign: TextAlign.center,
                                    style: res.texto_branco_12,
                                    minFontSize: 8,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : Container(),
                            widget.item.info_3.isNotEmpty
                                ? AutoSizeText(
                                    //controller_mobx.lista_camera[index].tipo,
                                    widget.item.info_3,
                                    textAlign: TextAlign.center,
                                    style: res.texto_branco_12,
                                    minFontSize: 8,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : Container(),
                          ]
                      ),
                    ),
                    if(widget.item.info_2.isNotEmpty || widget.item.info_4.isNotEmpty)Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            widget.item.info_2.isNotEmpty
                                ? AutoSizeText(
                                    //controller_mobx.lista_camera[index].tipo,
                                    widget.item.info_2,
                                    textAlign: TextAlign.center,
                                    style: res.texto_branco_12,
                                    minFontSize: 8,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : Container(),
                            widget.item.info_4.isNotEmpty
                                ? AutoSizeText(
                              //controller_mobx.lista_camera[index].tipo,
                                    widget.item.info_4,
                                    textAlign: TextAlign.center,
                                    style: res.texto_branco_12,
                                    minFontSize: 8,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : Container(),
                          ]
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: IconButton(
                          icon: SvgPicture.asset(
                            "assets/icone-excluir.svg",
                            height: 20,
                          ),
                          onPressed: (){
                            controller.mostrar_remover_item(widget.item);
                          },
                          iconSize: 20,
                          splashColor: res.azul_claro.withOpacity(0.25),
                          splashRadius: 20,
                          highlightColor: res.azul_claro,
                          hoverColor: Colors.white,
                        )
                    ),
                  ],
                ),
              )
          ),
        )
    );
  }
}
