import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:simulador_unifique/model/ItemMostrar.dart';
import '../util/Controller.dart';
import '../util/Res.dart';

class WidgetItemLista extends StatefulWidget {
  double altura_item = 0;
  ItemMostrar item;
  int index = -1;
  WidgetItemLista(ItemMostrar this.item, int this.index, this.altura_item);

  @override
  State<WidgetItemLista> createState() => _WidgetItemListaState();
}

class _WidgetItemListaState extends State<WidgetItemLista> {
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
              height: widget.altura_item,
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: SvgPicture.asset(
                        widget.item.icone,
                        height: widget.altura_item/2,
                      ),
                    ),
                    widget.item.info_1.isNotEmpty
                        ? Expanded(
                      child: AutoSizeText(
                        //controller_mobx.lista_camera[index].tipo,
                        widget.item.info_1,
                        textAlign: TextAlign.center,
                        style: res.texto_branco_12,
                        minFontSize: 8,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                        : Container(),
                    widget.item.info_2.isNotEmpty
                        ? Expanded(
                      child: AutoSizeText(
                        //controller_mobx.lista_camera[index].tipo,
                        widget.item.info_2,
                        textAlign: TextAlign.center,
                        style: res.texto_branco_12,
                        minFontSize: 8,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                        : Container(),
                    widget.item.info_3.isNotEmpty
                        ? Expanded(
                      child: AutoSizeText(
                        //controller_mobx.lista_camera[index].tipo,
                        widget.item.info_3,
                        textAlign: TextAlign.center,
                        style: res.texto_branco_12,
                        minFontSize: 8,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                        : Container(),
                    widget.item.info_4.isNotEmpty
                    ? Expanded(
                      child: AutoSizeText(
                        //controller_mobx.lista_camera[index].tipo,
                        widget.item.info_4,
                        textAlign: TextAlign.center,
                        style: res.texto_branco_12,
                        minFontSize: 8,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                    : Container(),
                    Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: IconButton(
                          icon: SvgPicture.asset(
                            "assets/icone-excluir.svg",
                            height: widget.altura_item/2,
                          ),
                          onPressed: (){
                            controller.mostrar_remover_item(widget.item);
                          },
                          iconSize: widget.altura_item/2,
                          splashColor: res.azul_claro.withOpacity(0.25),
                          splashRadius: widget.altura_item/2,
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
