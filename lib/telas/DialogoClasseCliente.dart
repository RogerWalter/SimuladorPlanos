import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:simulador_unifique/util/Res.dart';

import '../util/Controller.dart';

class DialogoClasseCliente extends StatefulWidget {
  const DialogoClasseCliente({Key? key}) : super(key: key);

  @override
  State<DialogoClasseCliente> createState() => _DialogoClasseClienteState();
}

class _DialogoClasseClienteState extends State<DialogoClasseCliente> {
  Controller controller = Get.find();
  Res res = Res();

  @override
  Widget build(BuildContext context) {
    Curve curva_aplicada = Curves.slowMiddle;
    var largura = MediaQuery.of(context).size.width;
    var altura = MediaQuery.of(context).size.height;
    var largura_coluna = (largura - 240)/14;
    var tam_circulo = largura/14;
    var tam_circulo_celular = altura*0.15;
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
                              padding: EdgeInsets.fromLTRB(8,8,8,4),
                              child: Text(
                                "Qual a classe do cliente?",
                                style: res.texto_bold_azul_20,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Container(
                                                  width: (tam_circulo > 75) ? 75 : tam_circulo,
                                                  height: (tam_circulo > 75) ? 75 : tam_circulo,
                                                  decoration: BoxDecoration(
                                                    color: res.cor_0,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                  ),
                                                  child: Material(
                                                    color: res.cor_0,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                    child: InkWell(
                                                        splashColor: Colors.white,
                                                        highlightColor: Colors.white,
                                                        hoverColor: res.cor_0,
                                                        borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                        onTap: (){
                                                          controller.altera_classe_cliente(0);
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            Expanded(
                                                                child: Align(
                                                                  alignment: Alignment.center,
                                                                  child: AutoSizeText(
                                                                    "0",
                                                                    style: res.texto_bold_branco_16,
                                                                    minFontSize: 8,
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                )
                                                            ),
                                                          ],
                                                        )
                                                    ),
                                                  )
                                              ).animate().fadeIn(duration: 100.ms, delay: 0.ms, curve: curva_aplicada).slideX(begin: -1, end: 0, duration: 200.ms)
                                          ),
                                          Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Container(
                                                  width: (tam_circulo > 75) ? 75 : tam_circulo,
                                                  height: (tam_circulo > 75) ? 75 : tam_circulo,
                                                  decoration: BoxDecoration(
                                                    color: res.cor_1,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                  ),
                                                  child: Material(
                                                    color: res.cor_1,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                    child: InkWell(
                                                        splashColor: Colors.white,
                                                        highlightColor: Colors.white,
                                                        hoverColor: res.cor_1,
                                                        borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                        onTap: (){
                                                          controller.altera_classe_cliente(1);
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            Expanded(
                                                                child: Align(
                                                                  alignment: Alignment.center,
                                                                  child: AutoSizeText(
                                                                    "1",
                                                                    style: res.texto_bold_branco_16,
                                                                    minFontSize: 8,
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                )
                                                            ),
                                                          ],
                                                        )
                                                    ),
                                                  )
                                              ).animate().fadeIn(duration: 100.ms, delay: 200.ms, curve: curva_aplicada)
                                          ),
                                          Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Container(
                                                  width: (tam_circulo > 75) ? 75 : tam_circulo,
                                                  height: (tam_circulo > 75) ? 75 : tam_circulo,
                                                  decoration: BoxDecoration(
                                                    color: res.cor_2,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                  ),
                                                  child: Material(
                                                    color: res.cor_2,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                    child: InkWell(
                                                        splashColor: Colors.white,
                                                        highlightColor: Colors.white,
                                                        hoverColor:res.cor_2,
                                                        borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                        onTap: (){
                                                          controller.altera_classe_cliente(2);
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            Expanded(
                                                                child: Align(
                                                                  alignment: Alignment.center,
                                                                  child: AutoSizeText(
                                                                    "2",
                                                                    style: res.texto_bold_branco_16,
                                                                    minFontSize: 8,
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                )
                                                            ),
                                                          ],
                                                        )
                                                    ),
                                                  )
                                              ).animate().fadeIn(duration: 100.ms, delay: 300.ms, curve: curva_aplicada)
                                          ),
                                          Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Container(
                                                  width: (tam_circulo > 75) ? 75 : tam_circulo,
                                                  height: (tam_circulo > 75) ? 75 : tam_circulo,
                                                  decoration: BoxDecoration(
                                                    color: res.cor_3,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                  ),
                                                  child: Material(
                                                    color: res.cor_3,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                    child: InkWell(
                                                        splashColor: Colors.white,
                                                        highlightColor: Colors.white,
                                                        hoverColor: res.cor_3,
                                                        borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                        onTap: (){
                                                          controller.altera_classe_cliente(3);
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            Expanded(
                                                                child: Align(
                                                                  alignment: Alignment.center,
                                                                  child: AutoSizeText(
                                                                    "3",
                                                                    style: res.texto_bold_branco_16,
                                                                    minFontSize: 8,
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                )
                                                            ),
                                                          ],
                                                        )
                                                    ),
                                                  )
                                              ).animate().fadeIn(duration: 100.ms, delay: 400.ms, curve: curva_aplicada)
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Container(
                                                  width: (tam_circulo > 75) ? 75 : tam_circulo,
                                                  height: (tam_circulo > 75) ? 75 : tam_circulo,
                                                  decoration: BoxDecoration(
                                                    color: res.cor_4,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                  ),
                                                  child: Material(
                                                    color: res.cor_4,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                    child: InkWell(
                                                        splashColor: Colors.white,
                                                        highlightColor: Colors.white,
                                                        hoverColor: res.cor_4,
                                                        borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                        onTap: (){
                                                          controller.altera_classe_cliente(4);
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            Expanded(
                                                                child: Align(
                                                                  alignment: Alignment.center,
                                                                  child: AutoSizeText(
                                                                    "4",
                                                                    style: res.texto_bold_branco_16,
                                                                    minFontSize: 8,
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                )
                                                            ),
                                                          ],
                                                        )
                                                    ),
                                                  )
                                              ).animate().fadeIn(duration: 100.ms, delay: 400.ms, curve: curva_aplicada)
                                          ),
                                          Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Container(
                                                  width: (tam_circulo > 75) ? 75 : tam_circulo,
                                                  height: (tam_circulo > 75) ? 75 : tam_circulo,
                                                  decoration: BoxDecoration(
                                                    color: res.cor_5,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                  ),
                                                  child: Material(
                                                    color: res.cor_5,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                    child: InkWell(
                                                        splashColor: Colors.white,
                                                        highlightColor: Colors.white,
                                                        hoverColor: res.cor_5,
                                                        borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                        onTap: (){
                                                          controller.altera_classe_cliente(5);
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            Expanded(
                                                                child: Align(
                                                                  alignment: Alignment.center,
                                                                  child: AutoSizeText(
                                                                    "5",
                                                                    style: res.texto_bold_branco_16,
                                                                    minFontSize: 8,
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                )
                                                            ),
                                                          ],
                                                        )
                                                    ),
                                                  )
                                              ).animate().fadeIn(duration: 100.ms, delay: 300.ms, curve: curva_aplicada)
                                          ),
                                          Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Container(
                                                  width: (tam_circulo > 75) ? 75 : tam_circulo,
                                                  height: (tam_circulo > 75) ? 75 : tam_circulo,
                                                  decoration: BoxDecoration(
                                                    color: res.cor_6,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                  ),
                                                  child: Material(
                                                    color: res.cor_6,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                    child: InkWell(
                                                        splashColor: Colors.white,
                                                        highlightColor: Colors.white,
                                                        hoverColor: res.cor_6,
                                                        borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                        onTap: (){
                                                          controller.altera_classe_cliente(6);
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            Expanded(
                                                                child: Align(
                                                                  alignment: Alignment.center,
                                                                  child: AutoSizeText(
                                                                    "6",
                                                                    style: res.texto_bold_branco_16,
                                                                    minFontSize: 8,
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                )
                                                            ),
                                                          ],
                                                        )
                                                    ),
                                                  )
                                              ).animate().fadeIn(duration: 100.ms, delay: 200.ms, curve: curva_aplicada)
                                          ),
                                          Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Container(
                                                  width: (tam_circulo > 75) ? 75 : tam_circulo,
                                                  height: (tam_circulo > 75) ? 75 : tam_circulo,
                                                  decoration: BoxDecoration(
                                                    color: res.cor_99,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                  ),
                                                  child: Material(
                                                    color: res.cor_99,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                    child: InkWell(
                                                        splashColor: Colors.white,
                                                        highlightColor: Colors.white,
                                                        hoverColor: res.cor_99,
                                                        borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                        onTap: (){
                                                          controller.altera_classe_cliente(99);
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            Expanded(
                                                                child: Align(
                                                                  alignment: Alignment.center,
                                                                  child: Padding(
                                                                    padding: EdgeInsets.all((tam_circulo_celular > 75) ? 75/4 : tam_circulo_celular/4),
                                                                    child: SvgPicture.asset(
                                                                      "assets/logo-branca-sem-circulo.svg",
                                                                      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                                                      fit: BoxFit.contain,
                                                                    ),
                                                                  )
                                                                )
                                                            ),
                                                          ],
                                                        )
                                                    ),
                                                  )
                                              ).animate().fadeIn(duration: 100.ms, delay: 0.ms, curve: curva_aplicada).slideX(begin: 1, end: 0, duration: 200.ms)
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              )
                          )
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: largura/1.25,
                    height: (altura<750) ? altura*0.8 : altura*0.6,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(8,8,8,4),
                              child: Text(
                                "Qual a classe do cliente?",
                                style: res.texto_bold_azul_20,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Container(
                                              width: (tam_circulo_celular > 75) ? 75 : tam_circulo_celular,
                                              height: (tam_circulo_celular > 75) ? 75 : tam_circulo_celular,
                                              decoration: BoxDecoration(
                                                color: res.cor_0,
                                                borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                              ),
                                              child: Material(
                                                color: res.cor_0,
                                                borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                child: InkWell(
                                                    splashColor: Colors.white,
                                                    highlightColor: Colors.white,
                                                    hoverColor: res.cor_0,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                    onTap: (){
                                                      controller.altera_classe_cliente(0);
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: <Widget>[
                                                        Expanded(
                                                            child: Align(
                                                              alignment: Alignment.center,
                                                              child: AutoSizeText(
                                                                "0",
                                                                style: res.texto_bold_branco_16,
                                                                minFontSize: 8,
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            )
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              )
                                          ).animate().fadeIn(duration: 100.ms, delay: 0.ms, curve: curva_aplicada).slideX(begin: -1, end: 0, duration: 200.ms)
                                      ),
                                      Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Container(
                                              width: (tam_circulo_celular > 75) ? 75 : tam_circulo_celular,
                                              height: (tam_circulo_celular > 75) ? 75 : tam_circulo_celular,
                                              decoration: BoxDecoration(
                                                color: res.cor_1,
                                                borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                              ),
                                              child: Material(
                                                color: res.cor_1,
                                                borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                child: InkWell(
                                                    splashColor: Colors.white,
                                                    highlightColor: Colors.white,
                                                    hoverColor: res.cor_1,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                    onTap: (){
                                                      controller.altera_classe_cliente(1);
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: <Widget>[
                                                        Expanded(
                                                            child: Align(
                                                              alignment: Alignment.center,
                                                              child: AutoSizeText(
                                                                "1",
                                                                style: res.texto_bold_branco_16,
                                                                minFontSize: 8,
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            )
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              )
                                          ).animate().fadeIn(duration: 100.ms, delay: 200.ms, curve: curva_aplicada)
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Container(
                                              width: (tam_circulo_celular > 75) ? 75 : tam_circulo_celular,
                                              height: (tam_circulo_celular > 75) ? 75 : tam_circulo_celular,
                                              decoration: BoxDecoration(
                                                color: res.cor_2,
                                                borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                              ),
                                              child: Material(
                                                color: res.cor_2,
                                                borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                child: InkWell(
                                                    splashColor: Colors.white,
                                                    highlightColor: Colors.white,
                                                    hoverColor: res.cor_2,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                    onTap: (){
                                                      controller.altera_classe_cliente(2);
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: <Widget>[
                                                        Expanded(
                                                            child: Align(
                                                              alignment: Alignment.center,
                                                              child: AutoSizeText(
                                                                "2",
                                                                style: res.texto_bold_branco_16,
                                                                minFontSize: 8,
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            )
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              )
                                          ).animate().fadeIn(duration: 100.ms, delay: 200.ms, curve: curva_aplicada)
                                      ),
                                      Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Container(
                                              width: (tam_circulo_celular > 75) ? 75 : tam_circulo_celular,
                                              height: (tam_circulo_celular > 75) ? 75 : tam_circulo_celular,
                                              decoration: BoxDecoration(
                                                color: res.cor_3,
                                                borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                              ),
                                              child: Material(
                                                color: res.cor_3,
                                                borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                child: InkWell(
                                                    splashColor: Colors.white,
                                                    highlightColor: Colors.white,
                                                    hoverColor: res.cor_3,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                    onTap: (){
                                                      controller.altera_classe_cliente(3);
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: <Widget>[
                                                        Expanded(
                                                            child: Align(
                                                              alignment: Alignment.center,
                                                              child: AutoSizeText(
                                                                "3",
                                                                style: res.texto_bold_branco_16,
                                                                minFontSize: 8,
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            )
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              )
                                          ).animate().fadeIn(duration: 100.ms, delay: 0.ms, curve: curva_aplicada).slideX(begin: 1, end: 0, duration: 200.ms)
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Container(
                                              width: (tam_circulo_celular > 75) ? 75 : tam_circulo_celular,
                                              height: (tam_circulo_celular > 75) ? 75 : tam_circulo_celular,
                                              decoration: BoxDecoration(
                                                color: res.cor_4,
                                                borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                              ),
                                              child: Material(
                                                color: res.cor_4,
                                                borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                child: InkWell(
                                                    splashColor: Colors.white,
                                                    highlightColor: Colors.white,
                                                    hoverColor: res.cor_4,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                    onTap: (){
                                                      controller.altera_classe_cliente(4);
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: <Widget>[
                                                        Expanded(
                                                            child: Align(
                                                              alignment: Alignment.center,
                                                              child: AutoSizeText(
                                                                "4",
                                                                style: res.texto_bold_branco_16,
                                                                minFontSize: 8,
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            )
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              )
                                          ).animate().fadeIn(duration: 100.ms, delay: 0.ms, curve: curva_aplicada).slideX(begin: -1, end: 0, duration: 200.ms)
                                      ),
                                      Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Container(
                                              width: (tam_circulo_celular > 75) ? 75 : tam_circulo_celular,
                                              height: (tam_circulo_celular > 75) ? 75 : tam_circulo_celular,
                                              decoration: BoxDecoration(
                                                color: res.cor_5,
                                                borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                              ),
                                              child: Material(
                                                color: res.cor_5,
                                                borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                child: InkWell(
                                                    splashColor: Colors.white,
                                                    highlightColor: Colors.white,
                                                    hoverColor: res.cor_5,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                    onTap: (){
                                                      controller.altera_classe_cliente(5);
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: <Widget>[
                                                        Expanded(
                                                            child: Align(
                                                              alignment: Alignment.center,
                                                              child: AutoSizeText(
                                                                "5",
                                                                style: res.texto_bold_branco_16,
                                                                minFontSize: 8,
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            )
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              )
                                          ).animate().fadeIn(duration: 100.ms, delay: 200.ms, curve: curva_aplicada)
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Container(
                                              width: (tam_circulo_celular > 75) ? 75 : tam_circulo_celular,
                                              height: (tam_circulo_celular > 75) ? 75 : tam_circulo_celular,
                                              decoration: BoxDecoration(
                                                color: res.cor_6,
                                                borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                              ),
                                              child: Material(
                                                color: res.cor_6,
                                                borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                child: InkWell(
                                                    splashColor: Colors.white,
                                                    highlightColor: Colors.white,
                                                    hoverColor: res.cor_6,
                                                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                    onTap: (){
                                                      controller.altera_classe_cliente(6);
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: <Widget>[
                                                        Expanded(
                                                            child: Align(
                                                              alignment: Alignment.center,
                                                              child: AutoSizeText(
                                                                "6",
                                                                style: res.texto_bold_branco_16,
                                                                minFontSize: 8,
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            )
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              )
                                          ).animate().fadeIn(duration: 100.ms, delay: 200.ms, curve: curva_aplicada)
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Container(
                                            width: (tam_circulo_celular > 75) ? 75 : tam_circulo_celular,
                                            height: (tam_circulo_celular > 75) ? 75 : tam_circulo_celular,
                                            decoration: BoxDecoration(
                                              color: res.cor_99,
                                              borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                            ),
                                            child: Material(
                                              color: res.cor_99,
                                              borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                              child: InkWell(
                                                  splashColor: Colors.white,
                                                  highlightColor: Colors.white,
                                                  hoverColor: res.cor_99,
                                                  borderRadius: BorderRadius.all(Radius.circular(37.5)),
                                                  onTap: (){
                                                    controller.altera_classe_cliente(99);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Expanded(
                                                          child: Align(
                                                            alignment: Alignment.center,
                                                            child: Padding(
                                                              padding: EdgeInsets.all((tam_circulo_celular > 75) ? 75/4 : tam_circulo_celular/4),
                                                              child: SvgPicture.asset(
                                                                "assets/logo-branca-sem-circulo.svg",
                                                                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                                                fit: BoxFit.contain,
                                                              ),
                                                            )
                                                          )
                                                      ),
                                                    ],
                                                  )
                                              ),
                                            )
                                        ).animate().fadeIn(duration: 100.ms, delay: 0.ms, curve: curva_aplicada).slideX(begin: 1, end: 0, duration: 200.ms)
                                      ),
                                    ],
                                  ),
                                ],
                              )
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          else{
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
}
