import 'package:another_flushbar/flushbar.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:simulador_unifique/util/Proposta.dart';

import '../util/Controller.dart';
import '../util/Res.dart';
import 'DialogoCarregando.dart';

class DialogoGerarProposta extends StatefulWidget {
  const DialogoGerarProposta({Key? key}) : super(key: key);

  @override
  State<DialogoGerarProposta> createState() => _DialogoGerarPropostaState();
}

class _DialogoGerarPropostaState extends State<DialogoGerarProposta> {
  Controller controller = Get.find();
  Res res = Res();

  TextEditingController _controller_desconto = TextEditingController();
  FocusNode _foco_desconto = FocusNode();
  TextEditingController _controller_cliente = TextEditingController();
  FocusNode _foco_cliente = FocusNode();
  TextEditingController _controller_consultor = TextEditingController();
  FocusNode _foco_consultor = FocusNode();

  final TextInputFormatter formatter = CentavosInputFormatter(moeda: true);

  @override
  Widget build(BuildContext context) {
    var largura = MediaQuery.of(context).size.width;
    return LayoutBuilder(
        builder: (context, constraints) {
          var layout_altura = constraints.maxHeight;
          if (layout_altura > 200) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: (largura > 1400)
                        ? largura/3.5
                        : (largura > 1000 && largura < 1400)
                          ? largura/2
                          : largura/1.25,
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
                                "Gerar Proposta",
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
                                        controller: _controller_cliente,
                                        focusNode: _foco_cliente,
                                        keyboardType: TextInputType.name,
                                        textCapitalization: TextCapitalization.characters,
                                        textInputAction: TextInputAction.next,
                                        inputFormatters: [UpperCaseTextFormatter()],
                                        cursorColor: res.azul_claro,
                                        style: res.texto_bold_azul_claro_16,
                                        decoration: InputDecoration(
                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                          counterText: "",
                                          labelText: "Nome do Cliente",
                                          labelStyle: res.texto_azul_16,
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
                                      ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16,),
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
                                      controller: _controller_consultor,
                                      focusNode: _foco_consultor,
                                      keyboardType: TextInputType.name,
                                      textCapitalization: TextCapitalization.characters,
                                      textInputAction: TextInputAction.next,
                                      inputFormatters: [UpperCaseTextFormatter()],
                                      cursorColor: res.azul_claro,
                                      style: res.texto_bold_azul_claro_16,
                                      decoration: InputDecoration(
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        counterText: "",
                                        labelText: "Nome do Consultor",
                                        labelStyle: res.texto_azul_16,
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
                                      onSubmitted: (content){

                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16,),
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
                                      controller: _controller_desconto,
                                      focusNode: _foco_desconto,
                                      keyboardType: TextInputType.number,
                                      textCapitalization: TextCapitalization.characters,
                                      textInputAction: TextInputAction.done,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        formatter
                                      ],
                                      cursorColor: res.azul_claro,
                                      style: res.texto_bold_azul_claro_16,
                                      decoration: InputDecoration(
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        counterText: "",
                                        labelText: "Nova Adesão (Opcional)",
                                        labelStyle: res.texto_azul_16,
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
                                      onSubmitted: (content){
                                        gerar_proposta();
                                      },
                                    ),
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
                                              "Cancelar",
                                              style: res.texto_azul_claro_16,
                                              minFontSize: 6,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
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
                                            gerar_proposta();
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

  gerar_proposta() async{
    if(_controller_consultor.text.isEmpty || _controller_cliente.text.isEmpty){
      Flushbar(
        backgroundColor: Colors.red,
        messageText: Text('Preencha todos os campos antes de prosseguir', style: res.texto_branco_16,),
        duration: Duration(seconds: 2),
      ).show(context);
      return;
    }
    else{
      mostrar_progress();
      controller.alterar_dados_proposta(_controller_cliente.text, _controller_consultor.text);
      if(_controller_desconto.text.isNotEmpty){
        controller.adesao_com_desconto = UtilBrasilFields.converterMoedaParaDouble(_controller_desconto.text);
      }
      else{
        controller.adesao_com_desconto = controller.adesao_com_fidelidade.value;
      }
      Proposta gerar = Proposta();
      await Future.delayed(const Duration(seconds: 1), () async{
        await gerar.gerar_pdf();
      });
      Navigator.of(context).pop();
      Navigator.of(context).pop();

      controller.mostrar_limpar_plano();
    }
  }

  mostrar_progress() async{
    showAnimatedDialog(
        barrierDismissible: false,
        context: context,
        builder: (_){
          return WillPopScope(
              child: CustomDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(15.0))),
                  child: DialogoCarregando()
              ),
              onWillPop: () async => false
          );
        }
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
