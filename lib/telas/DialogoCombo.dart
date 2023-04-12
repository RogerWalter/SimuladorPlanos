import 'package:another_flushbar/flushbar.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simulador_unifique/model/Internet.dart';
import 'package:simulador_unifique/model/Telefone.dart';
import 'package:simulador_unifique/model/TvHd.dart';
import 'package:simulador_unifique/model/ValoresPF.dart';

import '../model/Combo.dart';
import '../model/ValoresPJ.dart';
import '../util/Controller.dart';
import '../util/Res.dart';

class DialogoCombo extends StatefulWidget {
  const DialogoCombo({Key? key}) : super(key: key);

  @override
  State<DialogoCombo> createState() => _DialogoComboState();
}

class _DialogoComboState extends State<DialogoCombo> {
  Controller controller = Get.find();
  Res res = Res();
  @override
  Widget build(BuildContext context) {
    controller.combo_limpar_dialogo();
    Combo listas = Combo();

    List<String> lista_internet = [];
    List<String> lista_tvhd = [];
    List<String> lista_telefone = [];

    if(controller.tipo_cliente == 0){//PF
      if(controller.cliente_score.value){
        lista_internet = listas.lista_internet;
        lista_tvhd = listas.lista_tvhd;
        lista_telefone = listas.lista_telefonia;
      }
      else{
        lista_internet = listas.lista_internet;
        lista_tvhd = listas.lista_tvhd;
        lista_telefone = listas.lista_telefonia;
      }
    }
    else{
      if(controller.cliente_score.value){
        lista_internet = listas.lista_internet_pj;
        lista_telefone = listas.lista_telefonia_pj;
      }
      else{
        lista_internet = listas.lista_internet_pj_inad;
        lista_telefone = listas.lista_telefonia_pj_inad;
      }
    }

    var largura = MediaQuery.of(context).size.width;
    return LayoutBuilder(
        builder: (context, constraints){
          var layout_largura = constraints.maxWidth;
          var layout_altura = constraints.maxHeight;
          if(layout_largura>1000 && layout_altura>500){
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: (largura > 1400) ? largura / 2.5 : largura / 2,
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
                              padding: EdgeInsets.fromLTRB(16,16,16,16),
                              child: Text(
                                "Adicionar Combo",
                                style: res.texto_bold_azul_16,
                                textAlign: TextAlign.center,
                              ),
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
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: AutoSizeText(
                                          "Internet: ",
                                          style: res.texto_azul_16,
                                          minFontSize: 6,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left: 16)),
                                Expanded(
                                  child: Obx(() =>
                                      DropdownButtonHideUnderline(
                                          child: Container(
                                              height: 56,
                                              color: Colors.transparent,
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: DropdownButtonFormField<String>(
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      fillColor: Colors.transparent,
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(width: 2, color: Colors.transparent),
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(width: 2, color: Colors.transparent),
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                    ),
                                                    iconEnabledColor: res.azul_claro,
                                                    iconDisabledColor: res.azul_claro,
                                                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                                                    borderRadius: BorderRadius.circular(20),
                                                    isDense: true,
                                                    onChanged: (String? novoValor) {
                                                      controller.combo_seleciona_internet(novoValor);
                                                    },
                                                    items: lista_internet.map((String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    itemHeight: null,
                                                    value: controller.combo_inte_selecionado_dropdown.value,
                                                    style: res.texto_bold_azul_claro_16
                                                ),
                                              )
                                          )
                                      )
                                  ),
                                )
                              ],
                            ),
                          ),
                          Obx(() =>
                              Visibility(
                                visible: controller.tipo_cliente == 0 ? true : false,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(16,0,16,0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                            color: Colors.transparent,
                                            height: 56,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: AutoSizeText(
                                                "TV HD: ",
                                                style: res.texto_azul_16,
                                                minFontSize: 6,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(left: 16)),
                                      Expanded(
                                        child: Obx(() =>
                                            DropdownButtonHideUnderline(
                                                child: Container(
                                                    height: 56,
                                                    color: Colors.transparent,
                                                    child: Align(
                                                      alignment: Alignment.centerRight,
                                                      child: DropdownButtonFormField<String>(
                                                          decoration: InputDecoration(
                                                            isDense: true,
                                                            fillColor: Colors.transparent,
                                                            enabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(width: 2, color: Colors.transparent),
                                                              borderRadius: BorderRadius.circular(20),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(width: 2, color: Colors.transparent),
                                                              borderRadius: BorderRadius.circular(20),
                                                            ),
                                                          ),
                                                          iconEnabledColor: res.azul_claro,
                                                          iconDisabledColor: res.azul_claro,
                                                          icon: Icon(Icons.keyboard_arrow_down_rounded),
                                                          borderRadius: BorderRadius.circular(20),
                                                          isDense: true,
                                                          onChanged: (String? novoValor) {
                                                            controller.combo_seleciona_tvhd(novoValor);
                                                          },
                                                          items: lista_tvhd.map((String value) {
                                                            return DropdownMenuItem<String>(
                                                              value: value,
                                                              child: Text(value),
                                                            );
                                                          }).toList(),
                                                          itemHeight: null,
                                                          value: controller.combo_tvhd_selecionado_dropdown.value,
                                                          style: res.texto_bold_azul_claro_16
                                                      ),
                                                    )
                                                )
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
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
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: AutoSizeText(
                                          "Telefonia: ",
                                          style: res.texto_azul_16,
                                          minFontSize: 6,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left: 16)),
                                Expanded(
                                  child: Obx(() =>
                                      DropdownButtonHideUnderline(
                                          child: Container(
                                              height: 56,
                                              color: Colors.transparent,
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: DropdownButtonFormField<String>(
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      fillColor: Colors.transparent,
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(width: 2, color: Colors.transparent),
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(width: 2, color: Colors.transparent),
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                    ),
                                                    iconEnabledColor: res.azul_claro,
                                                    iconDisabledColor: res.azul_claro,
                                                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                                                    borderRadius: BorderRadius.circular(20),
                                                    isDense: true,
                                                    onChanged: (String? novoValor) {
                                                      controller.combo_seleciona_telefone(novoValor);
                                                    },
                                                    items: lista_telefone.map((String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    itemHeight: null,
                                                    value: controller.combo_telf_selecionado_dropdown.value,
                                                    style: res.texto_bold_azul_claro_16
                                                ),
                                              )
                                          )
                                      )
                                  ),
                                )
                              ],
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
                                              "Cancelar",
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
                                Container(
                                  height: 56,
                                  width: 0.5,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: <Color>[
                                          Colors.black12.withOpacity(1),
                                          Colors.black12.withOpacity(1),
                                          Colors.black12.withOpacity(1),
                                          Colors.black12.withOpacity(0.5),
                                          Colors.black12.withOpacity(0.25),
                                          Colors.black12.withOpacity(0.05),
                                        ]
                                    ),
                                  ),
                                ),
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
                                              "Confirmar",
                                              style: res.texto_azul_claro_16,
                                              minFontSize: 6,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          onTap: (){salvar_combo();},
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
          else if(layout_largura<1000 && layout_altura > 500){//tela celular
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: largura/1.15,
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
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "Adicionar Combo",
                                style: res.texto_bold_azul_16,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top:8),
                          ),
                          Container(
                              color: Colors.transparent,
                              child: Align(
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  "Internet:",
                                  style: res.texto_azul_16,
                                  minFontSize: 6,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                          ),
                          Obx(() =>
                              DropdownButtonHideUnderline(
                                  child: Container(
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: DropdownButton(
                                            alignment: Alignment.center,
                                            items: lista_internet.map((String value) {
                                              return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Align(alignment: Alignment.center, child: Text(value),)
                                              );
                                            }).toList(),
                                            value: controller.combo_inte_selecionado_dropdown.value,
                                            onChanged: (String? novoValor) {
                                              controller.combo_seleciona_internet(novoValor);
                                            },
                                            borderRadius: BorderRadius.circular(20),
                                            iconEnabledColor: res.azul_claro,
                                            iconDisabledColor: res.azul_claro,
                                            icon: Icon(Icons.keyboard_arrow_down_rounded),
                                            style: res.texto_bold_azul_claro_16,
                                          )
                                      )
                                  )
                              )
                          ),
                          Padding(
                            padding: EdgeInsets.only(top:8),
                          ),
                          Obx(() =>
                              Visibility(
                                  visible: controller.tipo_cliente == 0 ? true : false,
                                  child:Column(
                                    children: [
                                      Container(
                                          color: Colors.transparent,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: AutoSizeText(
                                              "TV HD:",
                                              style: res.texto_azul_16,
                                              minFontSize: 6,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                      ),
                                      Obx(() =>
                                          DropdownButtonHideUnderline(
                                              child: Container(
                                                  child: Align(
                                                      alignment: Alignment.center,
                                                      child: DropdownButton(
                                                        alignment: Alignment.center,
                                                        items: lista_tvhd.map((String value) {
                                                          return DropdownMenuItem<String>(
                                                              value: value,
                                                              child: Align(alignment: Alignment.center, child: Text(value),)
                                                          );
                                                        }).toList(),
                                                        value: controller.combo_tvhd_selecionado_dropdown.value,
                                                        onChanged: (String? novoValor) {
                                                          controller.combo_seleciona_tvhd(novoValor);
                                                        },
                                                        borderRadius: BorderRadius.circular(20),
                                                        iconEnabledColor: res.azul_claro,
                                                        iconDisabledColor: res.azul_claro,
                                                        icon: Icon(Icons.keyboard_arrow_down_rounded),
                                                        style: res.texto_bold_azul_claro_16,
                                                      )
                                                  )
                                              )
                                          )
                                      ),
                                    ],
                                  )
                              )
                          ),
                          Container(
                              color: Colors.transparent,
                              child: Align(
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  "Telefonia:",
                                  style: res.texto_azul_16,
                                  minFontSize: 6,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                          ),
                          Obx(() =>
                              DropdownButtonHideUnderline(
                                  child: Container(
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: DropdownButton(
                                            alignment: Alignment.center,
                                            items: lista_telefone.map((String value) {
                                              return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Align(alignment: Alignment.center, child: Text(value),)
                                              );
                                            }).toList(),
                                            value: controller.combo_telf_selecionado_dropdown.value,
                                            onChanged: (String? novoValor) {
                                              controller.combo_seleciona_telefone(novoValor);
                                            },
                                            borderRadius: BorderRadius.circular(20),
                                            iconEnabledColor: res.azul_claro,
                                            iconDisabledColor: res.azul_claro,
                                            icon: Icon(Icons.keyboard_arrow_down_rounded),
                                            style: res.texto_bold_azul_claro_16,
                                          )
                                      )
                                  )
                              )
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
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
                            padding: EdgeInsets.fromLTRB(8,0,8,0),
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
                                              "Cancelar",
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
                                Container(
                                  height: 56,
                                  width: 0.5,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: <Color>[
                                          Colors.black12.withOpacity(1),
                                          Colors.black12.withOpacity(1),
                                          Colors.black12.withOpacity(1),
                                          Colors.black12.withOpacity(0.5),
                                          Colors.black12.withOpacity(0.25),
                                          Colors.black12.withOpacity(0.05),
                                        ]
                                    ),
                                  ),
                                ),
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
                                              "Confirmar",
                                              style: res.texto_azul_claro_16,
                                              minFontSize: 6,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          onTap: (){salvar_combo();},
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
          else{//muito pequeno - precisa aumentar a tela para usar
            return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: AutoSizeText(
                    'Aumente a janela para usar',
                    style: res.texto_bold_azul_20,
                    minFontSize: 8,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
            );
          }
        }
    );
  }

  salvar_combo(){
    if(controller.tipo_cliente == 0){//PF
      if( controller.combo_inte_selecionado_dropdown.value == "" ||
          controller.combo_tvhd_selecionado_dropdown.value == ""){
        Flushbar(
          backgroundColor: Colors.red,
          messageText: Text('Combos precisa possuir pelo menos Internet e TV HD. Portanto, esses campos são obrigatórios. Verifique e tente novamente', style: res.texto_branco_16,),
          duration: Duration(seconds: 2),
        ).show(context);
        return;
      }
      else{
        String plano = verificar_combo();
        if(plano == ""){
          Flushbar(
            backgroundColor: Colors.red,
            messageText: Text('Os itens selecionados para esse Combo são incompatíveis. Verifique se esse combo que está tentando montar existe e tente novamente', style: res.texto_branco_16,),
            duration: Duration(seconds: 2),
          ).show(context);
          return;
        }
        else{
          if(controller.cliente_score.value){
            Combo novo = Combo();
            novo.plano = plano;
            novo.mensalidade = 0;
            controller.combo_adicionar(novo);
            controller.recalcular_total();
            Navigator.of(context).pop();
          }
          else{
            String pesquisa = "";
            try{
              ComboValorPF busca = ValoresPF().combo_cli_inad.firstWhere((e) => e.plano == plano);
              pesquisa = busca.plano;
            }catch(e){
              pesquisa = "";
            }
            if(pesquisa == ""){
              Flushbar(
                backgroundColor: Colors.red,
                messageText: Text('O Combo montado não está disponível para clientes inadimplentes. Altere o combo e tente novamente', style: res.texto_branco_16,),
                duration: Duration(seconds: 4),
              ).show(context);
              return;
            }
            else{
              Combo novo = Combo();
              novo.plano = plano;
              novo.mensalidade = 0;
              controller.combo_adicionar(novo);
              controller.recalcular_total();
              Navigator.of(context).pop();
            }
          }
        }
      }
    }
    else{//PJ
      if( controller.combo_inte_selecionado_dropdown.value == "" ||
          controller.combo_telf_selecionado_dropdown.value == ""){
        Flushbar(
          backgroundColor: Colors.red,
          messageText: Text('Existem campos obrigatórios que não foram preenchidos.', style: res.texto_branco_16,),
          duration: Duration(seconds: 2),
        ).show(context);
        return;
      }
      else{
        String plano = verificar_combo();
        if(plano == ""){
          Flushbar(
            backgroundColor: Colors.red,
            messageText: Text('Os itens selecionados para esse Combo são incompatíveis. Verifique se esse combo que está tentando montar existe e tente novamente', style: res.texto_branco_16,),
            duration: Duration(seconds: 4),
          ).show(context);
          return;
        }
        else{
          if(controller.cliente_score.value){
            Combo novo = Combo();
            novo.plano = plano;
            novo.mensalidade = 0;
            controller.combo_adicionar(novo);
            controller.recalcular_total();
            Navigator.of(context).pop();
          }
          else{
            String pesquisa = "";
            try{
              ComboValorPJ busca = ValoresPJ().combo_cli_inad.firstWhere((e) => e.plano == plano);
              pesquisa = busca.plano;
            }catch(e){
              pesquisa = "";
            }
            if(pesquisa == ""){
              Flushbar(
                backgroundColor: Colors.red,
                messageText: Text('O Combo montado não está disponível para clientes inadimplentes. Tente alterar o combo e tente novamente', style: res.texto_branco_16,),
                duration: Duration(seconds: 4),
              ).show(context);
              return;
            }
            else{
              Combo novo = Combo();
              novo.plano = plano;
              novo.mensalidade = 0;
              controller.combo_adicionar(novo);
              controller.recalcular_total();
              Navigator.of(context).pop();
            }
          }
        }
      }
    }
  }

  String verificar_combo(){
    Combo listas = Combo();
    String plano = "";
    if(controller.tipo_cliente == 0){//pesquisamos o combo nas listas de pf
      if(controller.combo_telf_selecionado_dropdown.value == ""){
        //combo de dois itens
        ComposicaoCombo busca = ComposicaoCombo.vazio();
        try{
          busca = listas.composicoes_dois_itens
              .firstWhere((e) =>
          e.internet == controller.combo_inte_selecionado_dropdown.value &&
              e.tv == controller.combo_tvhd_selecionado_dropdown.value);
        }catch(e){
          plano = "";
        }
        plano = busca.nome_combo;
      }
      else{
        //combo de tres itens
        ComposicaoCombo busca = ComposicaoCombo.vazio();
        try{
          busca = listas.composicoes_tres_itens
              .firstWhere((e) =>
          e.internet == controller.combo_inte_selecionado_dropdown.value &&
              e.tv == controller.combo_tvhd_selecionado_dropdown.value &&
              e.telefone == controller.combo_telf_selecionado_dropdown.value);
        }catch(e){
          plano = "";
        }
        plano = busca.nome_combo;
      }
    }
    else{//pesquisamos os combos nas listas de pj
      ComposicaoCombo busca = ComposicaoCombo.vazio();
      try{
        busca = listas.composicoes_pj
            .firstWhere((e) =>
        e.internet == controller.combo_inte_selecionado_dropdown.value &&
            e.telefone == controller.combo_telf_selecionado_dropdown.value);
      }catch(e){
        plano = "";
      }
      plano = busca.nome_combo;
    }
    return plano;
  }
}
