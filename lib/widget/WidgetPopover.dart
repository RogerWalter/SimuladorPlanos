import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import 'package:simulador_unifique/Util/Res.dart';
import 'package:simulador_unifique/telas/DialogoClasseCliente.dart';

import '../util/Controller.dart';
import '../util/Dialogos.dart';



class PopoverWidget extends StatefulWidget {
  int parametro = -1;//usado para verificar se é uma tela de celular ou de pc

  PopoverWidget(this.parametro);

  @override
  State<PopoverWidget> createState() => _PopoverWidgetState();
}

class _PopoverWidgetState extends State<PopoverWidget> {
  Controller controller = Get.find();
  Res res = Res();
  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: widget.parametro == 0
                        ? EdgeInsets.only(right: 8, top: 16)
                        : EdgeInsets.only(right: 8, top: 8),
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: controller.cliente_score.value ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )
                  ),
                  Padding(
                    padding: widget.parametro == 0
                        ? EdgeInsets.only(top: 16)
                        : EdgeInsets.only(top: 8),
                    child: Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        (controller.classe_cliente == 9)
                            ? " - "
                            : (controller.classe_cliente == 99)
                              ? "Colaborador Unifique"
                              : "Cliente Classe " + controller.classe_cliente.toString(),
                        textAlign: TextAlign.center,
                        style: widget.parametro == 0
                          ? res.texto_bold_azul_20
                          : res.texto_bold_azul_16,
                        minFontSize: 8,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Padding(
                    padding: widget.parametro == 0
                        ? EdgeInsets.only(left: 8, top: 16)
                        : EdgeInsets.only(left: 8, top: 8),
                    child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: controller.cliente_score.value ? Colors.green : Colors.red,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        )
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: widget.parametro == 0
                        ? EdgeInsets.only(bottom: 16)
                        : EdgeInsets.only(bottom: 8),
                    child: Align(
                        alignment: Alignment.center,
                        child: Obx(() =>
                            AutoSizeText(
                              (controller.classe_cliente == 9) ? " " : "Toque para alterar",
                              textAlign: TextAlign.center,
                              style: res.texto_azul_12,
                              minFontSize: 8,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ).animate(onPlay: (controller) => controller.loop(reverse: true)).fade(duration: 1500.ms))
                    ),
                  )
                ],
              )
            ],
          ),
          onTap: (){
            Dialogos novo = Dialogos();
            novo.mostrar_dialogo_selecionar_classe(context);
          },
        )
    );
  }
}
