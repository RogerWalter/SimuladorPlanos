import 'package:another_flushbar/flushbar.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:simulador_unifique/util/Dialogos.dart';

import '../util/Controller.dart';
import '../util/Res.dart';
import 'DialogoGerarProposta.dart';

class DialogoCliente extends StatefulWidget {
  const DialogoCliente({Key? key}) : super(key: key);

  @override
  State<DialogoCliente> createState() => _DialogoClienteState();
}

class _DialogoClienteState extends State<DialogoCliente> {
  Controller controller = Get.find();
  Res res = Res();

  TextEditingController _controller_cpf = TextEditingController();
  FocusNode _foco_cpf = FocusNode();

  String? valor_selecionado = "";
  String? valor_selecionado_score = "";

  List<String> clienteUnifique = [
    "",
    "Sim",
    "Não",
  ];
  @override
  Widget build(BuildContext context) {
    var largura = MediaQuery.of(context).size.width;
    _foco_cpf.requestFocus();
    return LayoutBuilder(
        builder: (context, constraints) {
          var layout_largura = constraints.maxWidth;
          var layout_altura = constraints.maxHeight;
          if (layout_largura > 1000 && layout_altura > 200) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: (largura > 1400) ? largura/3.5 : largura/2,
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
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                              child: Text(
                                "Informações Iniciais",
                                style: res.texto_bold_azul_16,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                      color: Colors.transparent,
                                      height: 56,
                                      child: TextField(
                                        expands: true,
                                        maxLines: null,
                                        minLines: null,
                                        controller: _controller_cpf,
                                        focusNode: _foco_cpf,
                                        keyboardType: TextInputType.number,
                                        textCapitalization: TextCapitalization.characters,
                                        textInputAction: TextInputAction.next,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly, CpfOuCnpjFormatter()],
                                        cursorColor: res.azul_claro,
                                        style: res.texto_bold_azul_claro_16,
                                        decoration: InputDecoration(
                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                          counterText: "",
                                          labelText: "CPF/CNPJ do Cliente",
                                          labelStyle: res.texto_bold_azul_16,
                                          fillColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(width: 1, color: res.azul_escuro),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(width: 1, color: res.azul_escuro),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                        onChanged: (content){

                                        },
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16,),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                    child: DropdownButtonHideUnderline(
                                        child: Container(
                                            height: 56,
                                            color: Colors.transparent,
                                            child: Align(
                                              alignment: Alignment
                                                  .centerRight,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                  decoration: InputDecoration(
                                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                                    counterText: "",
                                                    labelText: "É cliente Unifique?",
                                                    labelStyle: res.texto_bold_azul_16,
                                                    fillColor: Colors.transparent,
                                                    hoverColor: Colors.transparent,
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(width: 1, color: res.azul_escuro),
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(width: 1, color: res.azul_escuro),
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                  ),
                                                  iconEnabledColor: res.azul_claro,
                                                  iconDisabledColor: res.azul_claro,
                                                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                                                  borderRadius: BorderRadius.circular(20),
                                                  isDense: true,
                                                  onChanged: (String? novoValor) {
                                                    valor_selecionado = novoValor;
                                                    if(novoValor == "Sim"){
                                                      controller.alterar_cliente_unifique(true);
                                                    }
                                                    if(novoValor == "Não"){
                                                      controller.alterar_cliente_unifique(false);
                                                    }
                                                  },
                                                  items: clienteUnifique.map((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  itemHeight: null,
                                                  //value: controller.telef_cli_unifique_selecionado_dropdown.value,
                                                  style: res.texto_bold_azul_claro_16
                                              ),
                                            )
                                        )
                                    )
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 16,),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                    child: DropdownButtonHideUnderline(
                                        child: Container(
                                            height: 56,
                                            color: Colors.transparent,
                                            child: Align(
                                              alignment: Alignment
                                                  .centerRight,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                  decoration: InputDecoration(
                                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                                    counterText: "",
                                                    labelText: "Cliente Inadimplente?",
                                                    labelStyle: res.texto_bold_azul_16,
                                                    fillColor: Colors.transparent,
                                                    hoverColor: Colors.transparent,
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(width: 1, color: res.azul_escuro),
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(width: 1, color: res.azul_escuro),
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                  ),
                                                  iconEnabledColor: res.azul_claro,
                                                  iconDisabledColor: res.azul_claro,
                                                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                                                  borderRadius: BorderRadius.circular(20),
                                                  isDense: true,
                                                  onChanged: (String? novoValor) {
                                                    valor_selecionado_score = novoValor;
                                                    if(novoValor == "Sim"){
                                                      controller.alterar_cliente_score(false);
                                                    }
                                                    if(novoValor == "Não"){
                                                      controller.alterar_cliente_score(true);
                                                    }
                                                  },
                                                  items: clienteUnifique.map((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  itemHeight: null,
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
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                                          hoverColor: Colors.white.withOpacity(
                                              0.5),
                                          highlightColor: Colors.white
                                              .withOpacity(0.5),
                                          splashColor: Colors.white.withOpacity(
                                              0.5),
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
                                          onTap: () {
                                            salvar_cliente();
                                          },
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
          else
          if (layout_largura < 1000 && layout_altura > 200) { //tela celular
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
                                  "Informações Iniciais",
                                  style: res.texto_bold_azul_16,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.zero,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        color: Colors.transparent,
                                        height: 56,
                                        child: TextField(
                                          expands: true,
                                          maxLines: null,
                                          minLines: null,
                                          controller: _controller_cpf,
                                          focusNode: _foco_cpf,
                                          keyboardType: TextInputType.number,
                                          textCapitalization: TextCapitalization.characters,
                                          textInputAction: TextInputAction.next,
                                          inputFormatters: [FilteringTextInputFormatter.digitsOnly, CpfOuCnpjFormatter()],
                                          cursorColor: res.azul_claro,
                                          style: res.texto_bold_azul_claro_16,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                            counterText: "",
                                            labelText: "CPF/CNPJ do Cliente",
                                            labelStyle: res.texto_bold_azul_16,
                                            fillColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(width: 1, color: res.azul_escuro),
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(width: 1, color: res.azul_escuro),
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                          ),
                                          onChanged: (content){

                                          },
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16,),
                            Padding(
                              padding: EdgeInsets.zero,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                      child: DropdownButtonHideUnderline(
                                          child: Container(
                                              height: 56,
                                              color: Colors.transparent,
                                              child: Align(
                                                alignment: Alignment
                                                    .centerRight,
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  decoration: InputDecoration(
                                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                                    counterText: "",
                                                    labelText: "É cliente Unifique?",
                                                    labelStyle: res.texto_bold_azul_16,
                                                    fillColor: Colors.transparent,
                                                    hoverColor: Colors.transparent,
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(width: 1, color: res.azul_escuro),
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(width: 1, color: res.azul_escuro),
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                  ),
                                                  iconEnabledColor: res.azul_claro,
                                                  iconDisabledColor: res.azul_claro,
                                                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                                                  borderRadius: BorderRadius.circular(20),
                                                  isDense: true,
                                                  onChanged: (String? novoValor) {
                                                    valor_selecionado = novoValor;
                                                    if(novoValor == "Sim"){
                                                      controller.alterar_cliente_unifique(true);
                                                    }
                                                    if(novoValor == "Não"){
                                                      controller.alterar_cliente_unifique(false);
                                                    }
                                                  },
                                                  items: clienteUnifique.map((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  itemHeight: null,
                                                  //value: controller.telef_cli_unifique_selecionado_dropdown.value,
                                                  style: res.texto_bold_azul_claro_16,
                                                ),
                                              )
                                          )
                                      )
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 16,),
                            Padding(
                              padding: EdgeInsets.zero,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                      child: DropdownButtonHideUnderline(
                                          child: Container(
                                              height: 56,
                                              color: Colors.transparent,
                                              child: Align(
                                                alignment: Alignment
                                                    .centerRight,
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  decoration: InputDecoration(
                                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                                    counterText: "",
                                                    labelText: "Cliente inadimplente?",
                                                    labelStyle: res.texto_bold_azul_16,
                                                    fillColor: Colors.transparent,
                                                    hoverColor: Colors.transparent,
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(width: 1, color: res.azul_escuro),
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(width: 1, color: res.azul_escuro),
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                  ),
                                                  iconEnabledColor: res.azul_claro,
                                                  iconDisabledColor: res.azul_claro,
                                                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                                                  borderRadius: BorderRadius.circular(20),
                                                  isDense: true,
                                                  onChanged: (String? novoValor) {
                                                    valor_selecionado_score = novoValor;
                                                    if(novoValor == "Sim"){
                                                      controller.alterar_cliente_score(false);
                                                    }
                                                    if(novoValor == "Não"){
                                                      controller.alterar_cliente_score(true);
                                                    }
                                                  },
                                                  items: clienteUnifique.map((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  itemHeight: null,
                                                  //value: controller.telef_cli_unifique_selecionado_dropdown.value,
                                                  style: res.texto_bold_azul_claro_16,
                                                ),
                                              )
                                          )
                                      )
                                  )
                                ],
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
                              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
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
                                            hoverColor: Colors.white.withOpacity(
                                                0.5),
                                            highlightColor: Colors.white
                                                .withOpacity(0.5),
                                            splashColor: Colors.white.withOpacity(
                                                0.5),
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
                                            onTap: () {
                                              salvar_cliente();
                                            },
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
                )
            );
          }
          else { //muito pequeno - precisa aumentar a tela para usar
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

  salvar_cliente(){
    if(_controller_cpf.text.isEmpty || valor_selecionado == "" || valor_selecionado_score == ""){
      Flushbar(
        backgroundColor: Colors.red,
        messageText: Text('Preencha todos os campos antes de prosseguir', style: res.texto_branco_16,),
        duration: Duration(seconds: 2),
      ).show(context);
      return;
      return;
    }
    else{
      if(_controller_cpf.text.length>14){
        //if(!UtilBrasilFields.isCPFValido(UtilBrasilFields.removeCaracteres(_controller_cpf.text))){
        if(!UtilBrasilFields.isCNPJValido(_controller_cpf.text)){
          Flushbar(
            backgroundColor: Colors.red,
            messageText: Text('O CNPJ informado é inválido. Verifique e tente novamente.', style: res.texto_branco_16,),
            duration: Duration(seconds: 2),
          ).show(context);
          return;
        }
      }
      else{
        if(!UtilBrasilFields.isCPFValido(UtilBrasilFields.removeCaracteres(_controller_cpf.text))){
          Flushbar(
            backgroundColor: Colors.red,
            messageText: Text('O CPF informado é inválido. Verifique e tente novamente.', style: res.texto_branco_16,),
            duration: Duration(seconds: 2),
          ).show(context);
          return;
        }
      }
      //consultar dados de score
      if(valor_selecionado_score == "Sim" && valor_selecionado == "Não"){
        controller.alterar_cliente_score(false);
      }
      else{
        controller.alterar_cliente_score(true);
      }
      controller.cliente_cpf_cnpj = _controller_cpf.text;
      Future.delayed(const Duration(milliseconds: 400), () {
        Dialogos mostrar = Dialogos();
        mostrar.mostrar_dialogo_selecionar_classe(context);
      });
      Navigator.of(context).pop();
    }
  }
}
