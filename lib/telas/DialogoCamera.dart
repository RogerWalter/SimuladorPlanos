import 'package:another_flushbar/flushbar.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../model/Camera.dart';
import '../util/Controller.dart';
import '../util/Res.dart';

class DialogoCamera extends StatefulWidget {
  const DialogoCamera({Key? key}) : super(key: key);

  @override
  State<DialogoCamera> createState() => _DialogoCameraState();
}

class _DialogoCameraState extends State<DialogoCamera> {
  Controller controller = Get.find();
  Camera nova = Camera();
  Res res = Res();

  @override
  Widget build(BuildContext context) {
    controller.camera_limpar_dialogo();
    controller.camera_seleciona_lice("Padrão");
    Camera listas = Camera();
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
                    width: (largura > 1300) ? largura/3.5 : largura/2,
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
                                "Adicionar Câmera",
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
                                        "Tipo da Câmera: ",
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
                                                    controller.camera_seleciona_tipo(novoValor);
                                                  },
                                                  items: listas.lista_tipo.map((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  itemHeight: null,
                                                  value: controller.camera_tipo_selecionado_dropdown.value,
                                                  style: res.texto_bold_azul_claro_16,
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
                                      height: 56,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: AutoSizeText(
                                          "Armazenamento: ",
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
                                                      controller.camera_seleciona_armz(novoValor);
                                                    },
                                                    items: listas.lista_armz.map((String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    itemHeight: null,
                                                    value: controller.camera_armz_selecionado_dropdown.value,
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
                                      height: 56,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: AutoSizeText(
                                          "Licença: ",
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
                                                      controller.camera_seleciona_lice(novoValor);
                                                    },
                                                    items: listas.lista_lice.map((String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    itemHeight: null,
                                                    value: controller.camera_lice_selecionado_dropdown.value,
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
                                      height: 56,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: AutoSizeText(
                                          "Quantidade: ",
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
                                      Container(
                                          height: 56,
                                          color: Colors.transparent,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                    onPressed: (){ controller.camera_bt_rem_qtd(); },
                                                    iconSize: 35,
                                                    splashColor: Colors.transparent,
                                                    hoverColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    icon: SvgPicture.asset(
                                                      "assets/icone-mais-qtd.svg",
                                                      height: 35,
                                                    )
                                                ),
                                                Text(
                                                  controller.camera_qtd_adicionar.toString(),
                                                  style: res.texto_bold_azul_claro_16,
                                                ),
                                                IconButton(
                                                    onPressed: (){ controller.camera_bt_add_qtd(); },
                                                    iconSize: 35,
                                                    splashColor: Colors.transparent,
                                                    hoverColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    icon: SvgPicture.asset(
                                                      "assets/icone-menos-qtd.svg",
                                                      height: 35,
                                                    )
                                                ),
                                              ],
                                            ),
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
                                          onTap: (){salvar_camera();},
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
                    width: largura/1.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                            image: AssetImage('assets/wallpaper-dialogo.jpg'),
                            fit: BoxFit.cover
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "Adicionar Câmera",
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
                                  "Tipo da Câmera:",
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
                                          items: listas.lista_tipo.map((String value) {
                                            return DropdownMenuItem<String>(
                                                value: value,
                                                child: Align(alignment: Alignment.center, child: Text(value),)
                                            );
                                          }).toList(),
                                          value: controller.camera_tipo_selecionado_dropdown.value,
                                          onChanged: (String? novoValor) {
                                            controller.camera_seleciona_tipo(novoValor);
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
                                  "Armazenamento:",
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
                                            items: listas.lista_armz.map((String value) {
                                              return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Align(alignment: Alignment.center, child: Text(value),)
                                              );
                                            }).toList(),
                                            value: controller.camera_armz_selecionado_dropdown.value,
                                            onChanged: (String? novoValor) {
                                              controller.camera_seleciona_armz(novoValor);
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
                                  "Licença:",
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
                                            items: listas.lista_lice.map((String value) {
                                              return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Align(alignment: Alignment.center, child: Text(value),)
                                              );
                                            }).toList(),
                                            value: controller.camera_lice_selecionado_dropdown.value,
                                            onChanged: (String? novoValor) {
                                              controller.camera_seleciona_lice(novoValor);
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
                                  "Quantidade:",
                                  style: res.texto_azul_16,
                                  minFontSize: 6,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                          ),
                          Obx(() =>
                              Container(
                                  color: Colors.transparent,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            onPressed: (){ controller.camera_bt_rem_qtd(); },
                                            iconSize: 35,
                                            splashColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            icon: SvgPicture.asset(
                                              "assets/icone-mais-qtd.svg",
                                              height: 35,
                                            )
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 8, right: 8),
                                          child: Text(
                                            controller.camera_qtd_adicionar.toString(),
                                            style: res.texto_bold_azul_claro_16,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: (){ controller.camera_bt_add_qtd(); },
                                            iconSize: 35,
                                            splashColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            icon: SvgPicture.asset(
                                              "assets/icone-menos-qtd.svg",
                                              height: 35,
                                            )
                                        ),
                                      ],
                                    ),
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
                                          onTap: (){salvar_camera();},
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
              body: Container(
                color: Colors.white,
                child: Expanded(
                    child: Center(
                      child: AutoSizeText(
                        'Aumente a janela para usar',
                        style: res.texto_bold_azul_20,
                        minFontSize: 8,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                ),
              ),
            );
          }
        }
    );
  }

  salvar_camera(){
    if(controller.camera_tipo_selecionado_dropdown == "" || controller.camera_tipo_selecionado_dropdown.toString().isEmpty ||
        controller.camera_armz_selecionado_dropdown == "" || controller.camera_armz_selecionado_dropdown.toString().isEmpty ||
        controller.camera_lice_selecionado_dropdown == "" || controller.camera_lice_selecionado_dropdown.toString().isEmpty){
      Flushbar(
        backgroundColor: Colors.red,
        messageText: Text('Existem campos obrigatórios que não foram preenchidos.', style: res.texto_branco_16,),
        duration: Duration(seconds: 2),
      ).show(context);
      return;
    }
    else{
      nova.armaz = controller.camera_armz_selecionado_dropdown.toString();
      nova.tipo = controller.camera_tipo_selecionado_dropdown.toString();
      nova.licen = controller.camera_lice_selecionado_dropdown.toString();
      for(int i = 0; i < controller.camera_qtd_adicionar.value; i++){
        controller.camera_adicionar(nova);
      }
      controller.recalcular_total();
      Navigator.of(context).pop();
    }
  }
}
