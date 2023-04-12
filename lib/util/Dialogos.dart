import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:simulador_unifique/telas/DialogoCliente.dart';
import 'package:simulador_unifique/util/Controller.dart';

import '../telas/DialogoClasseCliente.dart';
import '../telas/DialogoExcluir.dart';

class Dialogos{
  Controller controller = Get.find();


  mostrar_dialogo_selecionar_classe(BuildContext context){
    showAnimatedDialog(
      context: context,
      barrierDismissible: controller.classe_cliente != 9 ? true : false,
      builder: (context) {
        return CustomDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: DialogoClasseCliente()
        );
      },
      animationType: DialogTransitionType.fadeScale,
      curve: Curves.easeOutQuint,
      duration: Duration(milliseconds: 500),
    );
  }

  mostrar_dialogo_cliente(BuildContext context){
    showAnimatedDialog(
      context: context,
      barrierDismissible: controller.classe_cliente != 9 ? true : false,
      builder: (context) {
        return CustomDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: DialogoCliente()
        );
      },
      animationType: DialogTransitionType.fadeScale,
      curve: Curves.easeOutQuint,
      duration: Duration(milliseconds: 500),
    );
  }

  mostrar_dialogo_adicionar_item(BuildContext context, Widget widgetDialogo){
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CustomDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: widgetDialogo
        );
      },
      animationType: DialogTransitionType.fadeScale,
      curve: Curves.easeOutQuint,
      duration: Duration(milliseconds: 500),
    );
  }

  mostrar_dialogo_remover_item(BuildContext context, String titulo, String mensagem, int indice, int parametro){
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CustomDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: DialogoExcluir(titulo, mensagem, parametro)
        );
      },
      animationType: DialogTransitionType.fadeScale,
      curve: Curves.easeOutQuint,
      duration: Duration(milliseconds: 500),
    );
  }

}