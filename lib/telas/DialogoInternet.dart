import 'package:another_flushbar/flushbar.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/Internet.dart';
import '../util/Controller.dart';
import '../util/Res.dart';

class DialogoInternet extends StatefulWidget {
  const DialogoInternet({Key? key}) : super(key: key);

  @override
  State<DialogoInternet> createState() => _DialogoInternetState();
}

class _DialogoInternetState extends State<DialogoInternet> {
  Controller controller = Get.find();
  Internet novo = Internet();
  Res res = Res();

  List<String> upg_eqpto = [
    "",
    "Sim",
    "Não"
  ];

  @override
  Widget build(BuildContext context) {
    controller.internet_limpar_dialogo();
    List<String> listas = [];
    Internet busca = Internet();

    if(controller.tipo_cliente == 0){//PF
      if(controller.cliente_score.value){
        listas = busca.planos_pf;
      }
      else{
        listas = busca.planos_pf_cli_inadimplente;
      }
    }
    else{
      if(controller.cliente_score.value){
        listas = busca.planos_pj;
      }
      else{
        listas = busca.planos_pj_cli_inadimplente;
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
                    width: (largura > 1400)
                        ? largura/2.5
                        : largura/1.5,
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
                                "Adicionar Plano Internet",
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
                                      //width: largura/10,
                                      height: 56,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: AutoSizeText(
                                          "Plano: ",
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
                                                      controller.internet_seleciona_plano(novoValor);
                                                    },
                                                    items: listas.map((String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    itemHeight: null,
                                                    value: controller.internet_plano_selecionado_dropdown.value,
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
                            padding: EdgeInsets.fromLTRB(16,0,16,0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                      color: Colors.transparent,
                                      //width: largura/6,
                                      height: 56,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: AutoSizeText(
                                          "Upgrade de Equipamento? ",
                                          style: res.texto_azul_16,
                                          minFontSize: 6,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left: 16)),
                                Expanded(
                                  child: DropdownButtonHideUnderline(
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
                                                  controller.internet_seleciona_upgrade(novoValor);
                                                },
                                                items: upg_eqpto.map((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                itemHeight: null,
                                                value: controller.internet_upg_selecionado_dropdown.value,
                                                style: res.texto_bold_azul_claro_16
                                            ),
                                          )
                                      )
                                  )
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
                                          onTap: (){salvar_internet();},
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
                    width: largura/1,
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
                                "Adicionar Plano Internet",
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
                                  "Plano: ",
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
                                            items: listas.map((String value) {
                                              return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Align(alignment: Alignment.center, child: Text(value),)
                                              );
                                            }).toList(),
                                            value: controller.internet_plano_selecionado_dropdown.value,
                                            onChanged: (String? novoValor) {
                                              controller.internet_seleciona_plano(novoValor);
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
                          Container(
                              color: Colors.transparent,
                              child: Align(
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  "Upgrade de Equipamento?",
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
                                            items: upg_eqpto.map((String value) {
                                              return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Align(alignment: Alignment.center, child: Text(value),)
                                              );
                                            }).toList(),
                                            value: controller.internet_upg_selecionado_dropdown.value,
                                            onChanged: (String? novoValor) {
                                              controller.internet_seleciona_upgrade(novoValor);
                                            },
                                            borderRadius: BorderRadius.circular(20),
                                            iconEnabledColor: res.azul_claro,
                                            iconDisabledColor: res.azul_claro,
                                            icon: Icon(Icons.keyboard_arrow_down_rounded),
                                            style: res.texto_bold_azul_claro_16,
                                          )
                                      )
                                  )
                              ),
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
                                          onTap: (){salvar_internet();},
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

  salvar_internet(){
    if(controller.tipo_cliente == 0){//PF
      if(controller.internet_plano_selecionado_dropdown.value == "" && (controller.internet_upg_selecionado_dropdown.value == "Não" || controller.internet_upg_selecionado_dropdown.value == "")){
        Flushbar(
          backgroundColor: Colors.red,
          messageText: Text('Existem campos obrigatórios que não foram preenchidos.', style: res.texto_branco_16,),
          duration: Duration(seconds: 2),
        ).show(context);
        return;
      }
      else{
        if(controller.internet_plano_selecionado_dropdown.value != "" && (controller.internet_upg_selecionado_dropdown.value == "Não" || controller.internet_upg_selecionado_dropdown.value == "")){
          //somente plano preenchido
          Internet novo = Internet();
          novo.plano = controller.internet_plano_selecionado_dropdown.value;
          novo.mensal_fid_12 = 0;
          novo.mensal_fid_24 = 0;
          controller.internet_adicionar(novo);
          controller.recalcular_total();
          Navigator.of(context).pop();
        }
        if(controller.internet_plano_selecionado_dropdown.value == "" && controller.internet_upg_selecionado_dropdown.value == "Sim"){
          //somente upgrade preenchido
          Internet novo = Internet();
          novo.plano = "Upgrade de Equipamento";
          novo.mensal_fid_12 = 0;
          novo.mensal_fid_24 = 0;
          controller.internet_adicionar(novo);
          controller.recalcular_total();
          Navigator.of(context).pop();
        }
        if(controller.internet_plano_selecionado_dropdown.value != "" && controller.internet_upg_selecionado_dropdown.value == "Sim"){
          //ambos preenchidos
          Internet novo = Internet();
          novo.plano = controller.internet_plano_selecionado_dropdown.value;
          novo.mensal_fid_12 = 0;
          novo.mensal_fid_24 = 0;
          controller.internet_adicionar(novo);

          Internet nova = Internet();
          nova.plano = "Upgrade de Equipamento";
          nova.mensal_fid_12 = 0;
          nova.mensal_fid_24 = 0;
          controller.internet_adicionar(nova);
          controller.recalcular_total();
          Navigator.of(context).pop();
        }
      }
    }
    else{//PJ
      if(controller.internet_plano_selecionado_dropdown.value == "" && (controller.internet_upg_selecionado_dropdown.value == "Não" || controller.internet_upg_selecionado_dropdown.value == "")){
        Flushbar(
          backgroundColor: Colors.red,
          messageText: Text('Existem campos obrigatórios que não foram preenchidos.', style: res.texto_branco_16,),
          duration: Duration(seconds: 2),
        ).show(context);
        return;
      }
      else{
        if(controller.internet_plano_selecionado_dropdown.value != "" && (controller.internet_upg_selecionado_dropdown.value == "Não" || controller.internet_upg_selecionado_dropdown.value == "")){
          //somente plano preenchido
          Internet novo = Internet();
          novo.plano = controller.internet_plano_selecionado_dropdown.value;
          novo.mensal_fid_12 = 0;
          novo.mensal_fid_24 = 0;
          controller.internet_adicionar(novo);
          controller.recalcular_total();
          Navigator.of(context).pop();
        }
        if(controller.internet_plano_selecionado_dropdown.value == "" && controller.internet_upg_selecionado_dropdown.value == "Sim"){
          //somente upgrade preenchido
          Internet novo = Internet();
          novo.plano = "Upgrade de Equipamento";
          novo.mensal_fid_12 = 0;
          novo.mensal_fid_24 = 0;
          controller.internet_adicionar(novo);
          controller.recalcular_total();
          Navigator.of(context).pop();
        }
        if(controller.internet_plano_selecionado_dropdown.value != "" && controller.internet_upg_selecionado_dropdown.value == "Sim"){
          //ambos preenchidos
          Internet novo = Internet();
          novo.plano = controller.internet_plano_selecionado_dropdown.value;
          novo.mensal_fid_12 = 0;
          novo.mensal_fid_24 = 0;
          controller.internet_adicionar(novo);

          Internet nova = Internet();
          nova.plano = "Upgrade de Equipamento";
          nova.mensal_fid_12 = 0;
          nova.mensal_fid_24 = 0;
          controller.internet_adicionar(nova);

          controller.recalcular_total();
          Navigator.of(context).pop();
        }
      }
    }
  }
}
