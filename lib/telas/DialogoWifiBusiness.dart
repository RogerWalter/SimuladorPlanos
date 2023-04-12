import 'package:another_flushbar/flushbar.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:simulador_unifique/model/WifiBusiness.dart';

import '../util/Controller.dart';
import '../util/Res.dart';

class DialogoWifiBusiness extends StatefulWidget {
  const DialogoWifiBusiness({Key? key}) : super(key: key);

  @override
  State<DialogoWifiBusiness> createState() => _DialogoWifiBusinessState();
}

class _DialogoWifiBusinessState extends State<DialogoWifiBusiness> {
  Controller controller = Get.find();
  WifiBusiness nova = WifiBusiness();
  Res res = Res();
  bool mostrar_link = true;

  @override
  Widget build(BuildContext context) {
    WifiBusiness listas = WifiBusiness();
    var largura = MediaQuery.of(context).size.width;
    var altura = MediaQuery.of(context).size.height;
    var largura_coluna = (largura - 240)/14;
    controller.wifibusi_limpar_dialogo();

    //verificação para exibição da inserção de link ou não
    verificar_link_lista();

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
                    width: (largura > 1300) ? largura/3 : largura/2,
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
                                "Adicionar item Wifi Business",
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
                                          "Linha de AP: ",
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
                                                      controller.wifibusi_linha_ap_selecionado_dropdown(novoValor);
                                                    },
                                                    items: listas.lista_linha_ap.map((String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    itemHeight: null,
                                                    value: controller.wifibusi_linha_ap_selecionado_dropdown.value,
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
                                                      controller.wifibusi_seleciona_licen(novoValor);
                                                    },
                                                    items: listas.lista_licen.map((String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    itemHeight: null,
                                                    value: controller.wifibusi_licen_selecionado_dropdown.value,
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
                                                    onPressed: (){ controller.wifibusi_bt_rem_qtd(); },
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
                                                  controller.wifibusi_qtd_adicionar.toString(),
                                                  style: res.texto_bold_azul_claro_16,
                                                ),
                                                IconButton(
                                                    onPressed: (){ controller.wifibusi_bt_add_qtd(); },
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
                          Visibility(
                            visible: mostrar_link,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 16, bottom: 16),
                                    child: Text(
                                      "Se desejar adicionar um link de internet para o Wifi Business, escolha uma opção abaixo. Caso contrário, deixe em branco",
                                      style: res.texto_azul_12,
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
                                                "Link de Internet: ",
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
                                                            controller.wifibusi_seleciona_link(novoValor);
                                                          },
                                                          items: listas.lista_link.map((String value) {
                                                            return DropdownMenuItem<String>(
                                                              value: value,
                                                              child: Text(value),
                                                            );
                                                          }).toList(),
                                                          itemHeight: null,
                                                          value: controller.wifibusi_link_selecionado_dropdown.value,
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
                                          onTap: (){ salvar_wifibusiness();},
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
                                "Adicionar item Wifi Business",
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
                                  "Linha de AP",
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
                                            items: listas.lista_linha_ap.map((String value) {
                                              return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Align(alignment: Alignment.center, child: Text(value),)
                                              );
                                            }).toList(),
                                            value: controller.wifibusi_linha_ap_selecionado_dropdown.value,
                                            onChanged: (String? novoValor) {
                                              controller.wifibusi_seleciona_linha_ap(novoValor);
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
                                            alignment: Alignment.center,
                                            items: listas.lista_licen.map((String value) {
                                              return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Align(alignment: Alignment.center, child: Text(value),)
                                              );
                                            }).toList(),
                                            value: controller.wifibusi_licen_selecionado_dropdown.value,
                                            onChanged: (String? novoValor) {
                                              controller.wifibusi_seleciona_licen(novoValor);
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
                                            onPressed: (){ controller.wifibusi_bt_rem_qtd(); },
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
                                            controller.wifibusi_qtd_adicionar.toString(),
                                            style: res.texto_bold_azul_claro_16,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: (){ controller.wifibusi_bt_add_qtd(); },
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
                          Visibility(
                            visible: mostrar_link,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Se desejar adicionar um link de internet para o Wifi Business, escolha uma opção abaixo. Caso contrário, deixe em branco",
                                    style: res.texto_azul_12,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                    color: Colors.transparent,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: AutoSizeText(
                                        "Link de Internet:",
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
                                                  items: listas.lista_link.map((String value) {
                                                    return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Align(alignment: Alignment.center, child: Text(value),)
                                                    );
                                                  }).toList(),
                                                  value: controller.wifibusi_link_selecionado_dropdown.value,
                                                  onChanged: (String? novoValor) {
                                                    controller.wifibusi_seleciona_link(novoValor);
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
                                          onTap: (){salvar_wifibusiness();},
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

  verificar_link_lista(){
    String link_lista = "";
    try{
      link_lista = controller.lista_wifibusiness.firstWhere((e) => e.link != "").link;
    }catch(e){
      link_lista = "";
    }
    if(link_lista != "")//possui link na link_lista
      mostrar_link = false;
    else
      mostrar_link = true;
  }

  salvar_wifibusiness(){
    WifiBusiness calcular = WifiBusiness();
    if((controller.wifibusi_linha_ap_selecionado_dropdown.value == "" &&
        controller.wifibusi_licen_selecionado_dropdown.value == "" &&
        controller.wifibusi_link_selecionado_dropdown.value == "") ||
        (controller.wifibusi_linha_ap_selecionado_dropdown.value != "" &&
        controller.wifibusi_licen_selecionado_dropdown.value == "") ||
        (controller.wifibusi_linha_ap_selecionado_dropdown.value == "" &&
          controller.wifibusi_licen_selecionado_dropdown.value != "")){
      //todos os campos estão em branco e não é possível salvar nada
      Flushbar(
        backgroundColor: Colors.red,
        messageText: Text('Campos em branco. Não é possível salvar.', style: res.texto_branco_16,),
        duration: Duration(seconds: 2),
      ).show(context);
      return;
    }
    else if(controller.wifibusi_linha_ap_selecionado_dropdown.value != "" &&
        controller.wifibusi_licen_selecionado_dropdown.value != "" &&
        controller.wifibusi_link_selecionado_dropdown.value == ""){
      //preenchidos somente os campos de AP, portanto salvamos somente o AP
      WifiBusiness novo_ap = WifiBusiness();
      novo_ap.linha_ap = controller.wifibusi_linha_ap_selecionado_dropdown.value;
      novo_ap.licen = controller.wifibusi_licen_selecionado_dropdown.value;
      novo_ap.link = "";
      novo_ap.valor_mensalidade = calcular.verifica_valor_item(novo_ap, controller.classe_cliente.value, controller.tipo_cliente.value);
      for(int i = 0; i < controller.wifibusi_qtd_adicionar.value; i++){
        controller.wifibusi_adicionar(novo_ap);
      }
      controller.recalcular_total();
      Navigator.of(context).pop();
    }
    else if(controller.wifibusi_linha_ap_selecionado_dropdown.value == "" &&
        controller.wifibusi_licen_selecionado_dropdown.value == "" &&
        controller.wifibusi_link_selecionado_dropdown.value != ""){
      //preenchido somente o campo de link, portanto salvamos somente o link
      WifiBusiness novo_link = WifiBusiness();
      novo_link.linha_ap = "";
      novo_link.licen = "";
      novo_link.link = controller.wifibusi_link_selecionado_dropdown.value;
      novo_link.valor_mensalidade = calcular.verifica_valor_item(novo_link, controller.classe_cliente.value, controller.tipo_cliente.value);
      controller.wifibusi_adicionar(novo_link);

      controller.recalcular_total();
      Navigator.of(context).pop();
    }
    else{
      //todos os campos foram preenchidos, então salvamos o ap e o link
      WifiBusiness novo_ap = WifiBusiness();
      WifiBusiness novo_link = WifiBusiness();
      novo_ap.linha_ap = controller.wifibusi_linha_ap_selecionado_dropdown.value;
      novo_ap.licen = controller.wifibusi_licen_selecionado_dropdown.value;
      novo_ap.link = "";
      novo_ap.valor_mensalidade = calcular.verifica_valor_item(novo_ap, controller.classe_cliente.value, controller.tipo_cliente.value);
      for(int i = 0; i < controller.wifibusi_qtd_adicionar.value; i++){
        controller.wifibusi_adicionar(novo_ap);
      }
      novo_link.linha_ap = "";
      novo_link.licen = "";
      novo_link.link = controller.wifibusi_link_selecionado_dropdown.value;
      novo_link.valor_mensalidade = calcular.verifica_valor_item(novo_link, controller.classe_cliente.value, controller.tipo_cliente.value);
      controller.wifibusi_adicionar(novo_link);

      controller.recalcular_total();
      Navigator.of(context).pop();
    }
  }
}
