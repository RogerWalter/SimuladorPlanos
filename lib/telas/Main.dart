import 'package:another_flushbar/flushbar.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simulador_unifique/model/Combo.dart';
import 'package:simulador_unifique/model/Internet.dart';
import 'package:simulador_unifique/model/ItemMostrar.dart';
import 'package:simulador_unifique/model/Camera.dart';
import 'package:simulador_unifique/model/Mesh.dart';
import 'package:simulador_unifique/model/Telefone.dart';
import 'package:simulador_unifique/model/TvHd.dart';
import 'package:simulador_unifique/model/WifiBusiness.dart';
import 'package:simulador_unifique/telas/DialogoCamera.dart';
import 'package:simulador_unifique/telas/DialogoCasaInteligente.dart';
import 'package:simulador_unifique/telas/DialogoInternet.dart';
import 'package:simulador_unifique/telas/DialogoTelemedicina.dart';
import 'package:simulador_unifique/telas/DialogoTvHD.dart';
import 'package:simulador_unifique/telas/DialogoWifiBusiness.dart';
import 'package:simulador_unifique/util/Dialogos.dart';
import 'package:simulador_unifique/widget/WidgetPopover.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';
import '../model/CasaInteligente.dart';
import '../model/Telemedicina.dart';
import '../util/Controller.dart';
import '../util/SemDados.dart';
import '../widget/WidgetItemLista.dart';
import '../util/Res.dart';
import '../widget/WidgetItemListaCelular.dart';
import 'DialogoGerarProposta.dart';
import 'DialogoCombo.dart';
import 'DialogoMesh.dart';
import 'DialogoTelefonia.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  /*await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xff232f66),
      ),
      home: Main(),
    ),
  );
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> with TickerProviderStateMixin{
  Curve curva_aplicada_anim_init = Curves.linear;

  Controller controller = Get.put(Controller());
  Dialogos mostrar = Dialogos();

  final MaterialStateProperty<Icon?> thumbIcon =
  MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
      // Thumb icon when the switch is selected.
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.factory_rounded, color: Colors.white);
      }
      return const Icon(Icons.person, color: Colors.white);
    },
  );

  int param = 0;

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_){
      if(param == 0){
        //controller.altera_classe_cliente(1);
        mostrar.mostrar_dialogo_cliente(context);
        param++;
      }
    });

    AnimationController controller_animacao_imagem = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    AnimationController controller_animacao_tipo_cliente = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    var largura_total = MediaQuery.of(context).size.width;
    var altura_total = MediaQuery.of(context).size.height;
    Res res = Res();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Simulador de Planos Unifique",
        home: Container(
          width: largura_total,
          height: altura_total,
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage('assets/wallpaper-tela.jpg'),
                  //colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.75), BlendMode.modulate,),
                  fit: BoxFit.cover
              )
          ),
          child: LayoutBuilder(
              builder: (context, constraints){
                var largura = constraints.maxWidth;
                var altura = constraints.maxHeight;
                var largura_coluna = (largura - 240)/14; //15 x padding de 16
                if(largura>1400 && altura > 500){//tela pc
                  return Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        //backgroundColor: res.azul_escuro,
                        flexibleSpace: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment(-1,-1),
                                end: Alignment(1,2),
                                colors: <Color>[res.azul_escuro, res.azul_escuro, Color(0xff19558D)]),
                          ),
                        ),
                        toolbarHeight: altura*0.077,
                        title: Padding(
                          padding: EdgeInsets.only(left: largura_coluna + 32, right: largura_coluna + 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: AutoSizeText(
                                      'Simulador de Planos Unifique',
                                      style: res.texto_bold_branco_20,
                                      minFontSize: 8,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                              ),
                              Container(
                                height: altura*0.077,
                                width: altura*0.077,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 4, bottom: 4),
                                  child: SvgPicture.asset(
                                    "assets/logo-branca.svg",
                                    colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                    fit: BoxFit.contain,
                                  )
                                  ///Image(image: AssetImage("assets/logo-branca.svg"), fit: BoxFit.contain,)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      body: Obx(
                          () =>
                              AnimatedOpacity(
                                opacity: controller.opacidade_layout.value,
                                duration: Duration(seconds: 2),
                                curve: Curves.easeInExpo,
                                child: AnimatedSlide(
                                  duration: Duration(seconds: 2),
                                  curve: Curves.easeInExpo,
                                  offset: Offset(0, controller.opacidade_layout.value/4 - 0.25),
                                  child: Padding(
                                      padding: EdgeInsets.only(left: largura_coluna + 32, right: largura_coluna + 32, bottom: 16),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(left: largura_coluna + 16),
                                                      child: Container(
                                                        width: (largura_coluna*6) + 80,
                                                        child: PopoverWidget(0),
                                                      )
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                  child:Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          width: largura_coluna,
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                width: largura_coluna,
                                                                height: 50,
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: [
                                                                    Obx(() =>
                                                                        AutoSizeText(
                                                                          controller.desc_tipo_cliente.value,
                                                                          style: controller.tipo_cliente == 0
                                                                              ? res.texto_bold_azul_16
                                                                              : res.texto_bold_azul_claro_16,
                                                                          minFontSize: 8,
                                                                          textAlign: TextAlign.center,
                                                                          maxLines: 1,
                                                                          wrapWords: false,
                                                                          overflowReplacement: Text("...", style:  res.texto_bold_azul_16,),
                                                                        ).animate(
                                                                            controller: controller_animacao_tipo_cliente,
                                                                            onComplete: (controller) => controller.reverse()
                                                                        ).fadeOut(duration: Duration(milliseconds: 250), curve: Curves.easeOutQuint),
                                                                    ),
                                                                    Material(
                                                                        color: Colors.transparent,
                                                                        child: InkWell(
                                                                          onTap: (){},
                                                                          onHover: (value) async {
                                                                            if (value) {
                                                                              if (controller.lista_mostrar.length > 0 && controller.aviso_alteracao_tipo_cliente == 0) {
                                                                                //se houver essa alteração, os itens incluídos serão apagados para não haver incompatibilidade de valores
                                                                                mostrar_dialogo_alterar_tipo_cliente();
                                                                              }
                                                                            }
                                                                          },
                                                                          splashColor: Colors.transparent,
                                                                          hoverColor: Colors.transparent,
                                                                          highlightColor: Colors.transparent,
                                                                          child: Switcher(
                                                                            curveType: Curves.slowMiddle,
                                                                            animationDuration: Duration(milliseconds: 500),
                                                                            switcherRadius: 20,
                                                                            value: false,
                                                                            size: SwitcherSize.medium,
                                                                            switcherButtonRadius: 50,
                                                                            enabledSwitcherButtonRotate: true,
                                                                            iconOff: Icons.person,
                                                                            iconOn: Icons.factory_rounded,
                                                                            colorOff: res.azul_escuro,
                                                                            colorOn: res.azul_claro,
                                                                            switcherButtonColor: Colors.white,
                                                                            onChanged: (bool novo) async {
                                                                              controller_animacao_tipo_cliente.forward();
                                                                              controller_animacao_imagem.forward();
                                                                              Future.delayed(const Duration(milliseconds: 250), () {
                                                                                if(novo)
                                                                                  controller.alterar_tipo_cliente(1);
                                                                                else
                                                                                  controller.alterar_tipo_cliente(0);
                                                                              });
                                                                            },
                                                                          ),
                                                                        )
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(height:16),
                                                              Expanded(
                                                                child: ScrollConfiguration(
                                                                    behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                                                    child: GlowingOverscrollIndicator(
                                                                        axisDirection: AxisDirection.down,
                                                                        color: res.azul_claro.withOpacity(0.25),
                                                                        child: Obx(() =>
                                                                            ListView.builder(
                                                                              itemCount: controller.lista_produtos.length,
                                                                              shrinkWrap: true,
                                                                              scrollDirection: Axis.vertical,
                                                                              padding: EdgeInsets.zero,
                                                                              itemBuilder: (_, index){
                                                                                return Card(
                                                                                    shadowColor: res.azul_escuro.withOpacity(0.5),
                                                                                    elevation: 5,
                                                                                    margin: EdgeInsets.only(bottom: 16),
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(14),
                                                                                    ),
                                                                                    child: InkWell(
                                                                                        splashColor: Colors.white,
                                                                                        hoverColor: res.azul_claro,
                                                                                        onHover: (isHover){
                                                                                          if(isHover)
                                                                                            controller.alterar_hover_color_produtos(true, index);
                                                                                          else
                                                                                            controller.alterar_hover_color_produtos(false, index);
                                                                                        },
                                                                                        borderRadius: BorderRadius.circular(14),
                                                                                        onTap: (){
                                                                                          controller.alterar_indice_selecionado_produtos(index);
                                                                                          controller_animacao_imagem.forward();
                                                                                          Future.delayed(const Duration(milliseconds: 250), () {
                                                                                            controller.seleciona_produto(controller.lista_produtos[index]);
                                                                                          });
                                                                                        },
                                                                                        child: Container(
                                                                                          width: largura_coluna,
                                                                                          height: largura_coluna,
                                                                                          decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(14),
                                                                                              color: Colors.transparent
                                                                                          ),
                                                                                          child: Column(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            children: [
                                                                                              Expanded(
                                                                                                  child: Center(
                                                                                                    child: Container(
                                                                                                        width: largura_coluna*0.35,
                                                                                                        height: largura_coluna*0.35,
                                                                                                        child: Obx(() =>
                                                                                                            SvgPicture.asset(
                                                                                                              controller.hover_color_produtos == true
                                                                                                                  && controller.hover_color_produtos_index == index
                                                                                                                  ? controller.lista_produtos[index].icone_branco
                                                                                                                  : controller.lista_indice_selecionado == index
                                                                                                                  ? controller.lista_produtos[index].icone_azul_claro
                                                                                                                  : controller.lista_produtos[index].icone,
                                                                                                            )
                                                                                                        )
                                                                                                    ),
                                                                                                  )
                                                                                              ),
                                                                                              Padding(
                                                                                                  padding: EdgeInsets.only(left: 4, right: 4, bottom: 8),
                                                                                                  child: Obx(() =>
                                                                                                      AutoSizeText(
                                                                                                        controller.lista_produtos[index].descricao,
                                                                                                        style:
                                                                                                        controller.hover_color_produtos == true
                                                                                                            && controller.hover_color_produtos_index == index
                                                                                                            ? res.texto_bold_branco_16
                                                                                                            : controller.lista_indice_selecionado == index ? res.texto_bold_azul_claro_16 : res.texto_bold_azul_16,
                                                                                                        minFontSize: 8,
                                                                                                        textAlign: TextAlign.center,
                                                                                                        maxLines: 2,
                                                                                                        wrapWords: false,
                                                                                                        overflowReplacement: Text("...", style:  res.texto_bold_azul_16,),
                                                                                                      )
                                                                                                  )
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                        )
                                                                                    )
                                                                                );
                                                                              },
                                                                            )
                                                                        )
                                                                    )
                                                                ).animate(
                                                                    controller: controller_animacao_tipo_cliente,
                                                                    onComplete: (controller) => controller.reverse()
                                                                ).fadeOut(duration: Duration(milliseconds: 250), curve: Curves.easeOutQuint),
                                                              )
                                                            ],
                                                          )
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 16),
                                                        child: Container(
                                                            width: (largura_coluna*6) + 80,
                                                            //height: 500,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                    children: [
                                                                      //Container(color: Colors.blue, height: 50, width: 50,)
                                                                      Padding(
                                                                          padding: EdgeInsets.only(right: 16),
                                                                          child: Container(
                                                                              height: 50,
                                                                              width: largura_coluna*2 + 16,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                                                                gradient: LinearGradient(
                                                                                    begin: Alignment(0,-1),
                                                                                    end: Alignment(0,2),
                                                                                    colors: <Color>[res.azul_escuro, Color(0xff131934)]),
                                                                              ),
                                                                              child: Material(
                                                                                color: Colors.transparent,
                                                                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                                                                child: InkWell(
                                                                                    splashColor: Colors.white,
                                                                                    hoverColor: res.azul_claro,
                                                                                    borderRadius: BorderRadius.all(Radius.circular(16)),
                                                                                    onTap: (){
                                                                                      //mostrar.mostrar_dialogo_adicionar_item(context, DialogoCliente());
                                                                                      abrir_dialogo_adicionar_item();
                                                                                    },
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: <Widget>[
                                                                                        Padding(
                                                                                            padding:EdgeInsets.only(left: 16),
                                                                                            child: SvgPicture.asset(
                                                                                              "assets/icone-adicionar.svg",
                                                                                              height: 24,
                                                                                            )
                                                                                        ),
                                                                                        Container(
                                                                                          width: largura_coluna*2 - 88, //16 + 16 padding externo | 24 + 24 ícones | 4 + 4 padding interno
                                                                                          child: AutoSizeText(
                                                                                            "Adicionar Produto",
                                                                                            style: res.texto_branco_16,
                                                                                            minFontSize: 8,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            textAlign: TextAlign.center,
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                            padding:EdgeInsets.only(right: 16),
                                                                                            child: SvgPicture.asset(
                                                                                              "assets/icone-adicionar.svg",
                                                                                              height: 24,
                                                                                            )
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                ),
                                                                              )
                                                                          )
                                                                      ),
                                                                      Padding(
                                                                          padding: EdgeInsets.only(right: 16),
                                                                          child: Container(
                                                                              height: 50,
                                                                              width: largura_coluna*2 + 16,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                                                                gradient: LinearGradient(
                                                                                    begin: Alignment(0,-1),
                                                                                    end: Alignment(0,2),
                                                                                    colors: <Color>[res.azul_escuro, Color(0xff131934)]),
                                                                              ),
                                                                              child: Material(
                                                                                color: Colors.transparent,
                                                                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                                                                child: InkWell(
                                                                                    splashColor: Colors.white,
                                                                                    hoverColor: res.azul_claro,
                                                                                    borderRadius: BorderRadius.all(Radius.circular(16)),
                                                                                    onTap: (){
                                                                                      abrir_dialogo_remover_item(-1, 1);
                                                                                    },
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: <Widget>[
                                                                                        Padding(
                                                                                            padding:EdgeInsets.only(left: 16),
                                                                                            child: SvgPicture.asset(
                                                                                              "assets/icone-cancelar.svg",
                                                                                              height: 24,
                                                                                            )
                                                                                        ),
                                                                                        Container(
                                                                                          width: largura_coluna*2 - 88, //16 + 16 padding externo | 24 + 24 ícones | 4 + 4 padding interno
                                                                                          child: AutoSizeText(
                                                                                            "Remover Categoria",
                                                                                            style: res.texto_branco_16,
                                                                                            minFontSize: 8,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            textAlign: TextAlign.center,
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                            padding:EdgeInsets.only(right: 16),
                                                                                            child: SvgPicture.asset(
                                                                                              "assets/icone-cancelar.svg",
                                                                                              height: 24,
                                                                                            )
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                ),
                                                                              )
                                                                          )
                                                                      ),
                                                                      Padding(
                                                                          padding: EdgeInsets.only(right: 0),
                                                                          child: Container(
                                                                              height: 50,
                                                                              width: largura_coluna*2 + 16,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                                                                gradient: LinearGradient(
                                                                                    begin: Alignment(0,-1),
                                                                                    end: Alignment(0,2),
                                                                                    colors: <Color>[res.azul_escuro, Color(0xff131934)]),
                                                                              ),
                                                                              child: Material(
                                                                                color: Colors.transparent,
                                                                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                                                                child: InkWell(
                                                                                    splashColor: Colors.white,
                                                                                    hoverColor: res.azul_claro,
                                                                                    borderRadius: BorderRadius.all(Radius.circular(16)),
                                                                                    onTap: (){
                                                                                      abrir_dialogo_remover_item(-1, 2);
                                                                                    },
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: <Widget>[
                                                                                        Padding(
                                                                                            padding:EdgeInsets.only(left: 16),
                                                                                            child: SvgPicture.asset(
                                                                                              "assets/icone-limpar.svg",
                                                                                              height: 24,
                                                                                            )
                                                                                        ),
                                                                                        Container(
                                                                                          width: largura_coluna*2 - 88, //16 + 16 padding externo | 24 + 24 ícones | 4 + 4 padding interno
                                                                                          child: AutoSizeText(
                                                                                            "Limpar Plano",
                                                                                            style: res.texto_branco_16,
                                                                                            minFontSize: 8,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            textAlign: TextAlign.center,
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                            padding:EdgeInsets.only(right: 16),
                                                                                            child: SvgPicture.asset(
                                                                                              "assets/icone-limpar.svg",
                                                                                              height: 24,
                                                                                            )
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                ),
                                                                              )
                                                                          )
                                                                      ),
                                                                    ]
                                                                ),
                                                                Expanded(
                                                                    child: Padding(
                                                                        padding: EdgeInsets.only(top: 16, bottom: 16),
                                                                        child: ScrollConfiguration(
                                                                            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                                                            child: GlowingOverscrollIndicator(
                                                                                axisDirection: AxisDirection.down,
                                                                                color: res.azul_claro.withOpacity(0.25),
                                                                                child: Obx(() => controller.lista_mostrar.length > 0
                                                                                    ? GroupedListView<ItemMostrar, String>(
                                                                                  elements: controller.lista_mostrar,
                                                                                  groupBy: (ItemMostrar item) => item.grupo,
                                                                                  useStickyGroupSeparators: false,
                                                                                  stickyHeaderBackgroundColor: Colors.transparent,
                                                                                  groupSeparatorBuilder: (value) => Padding(
                                                                                    padding: EdgeInsets.only(bottom: 8, top: 8),
                                                                                    child: Container(
                                                                                      color: Colors.transparent,
                                                                                      child: Text(
                                                                                        value,
                                                                                        textAlign: TextAlign.left,
                                                                                        style: res.texto_bold_azul_16,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  shrinkWrap: true,
                                                                                  scrollDirection: Axis.vertical,
                                                                                  indexedItemBuilder: (_, item, index){
                                                                                    return WidgetItemLista(item, index, 50);
                                                                                  },
                                                                                )
                                                                                    : Center(child: SemDados()),
                                                                                )
                                                                            )
                                                                        )
                                                                    )
                                                                ),
                                                                Row(
                                                                    children: [
                                                                      Container(
                                                                          height: 50,
                                                                          width: largura_coluna,
                                                                          color: Colors.transparent,
                                                                          child: Column(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            children: [
                                                                              AutoSizeText(
                                                                                "Adesão",
                                                                                style: res.texto_azul_12,
                                                                                minFontSize: 8,
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                              Obx(() =>
                                                                                  Container(
                                                                                    child: AutoSizeText(
                                                                                      NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.adesao_com_fidelidade.value),
                                                                                      style: res.texto_bold_azul_20,
                                                                                      minFontSize: 8,
                                                                                      maxLines: 1,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      textAlign: TextAlign.center,
                                                                                    ),
                                                                                  )
                                                                              )
                                                                            ],
                                                                          )
                                                                      ),
                                                                      Padding(padding: EdgeInsets.only(left:16)),
                                                                      Container(
                                                                          height: 50,
                                                                          width: largura_coluna,
                                                                          color: Colors.transparent,
                                                                          child: Column(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            children: [
                                                                              AutoSizeText(
                                                                                "Mensalidade",
                                                                                style: res.texto_azul_12,
                                                                                minFontSize: 8,
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                              Obx(() =>
                                                                                  AutoSizeText(
                                                                                    NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.mensalidade.value),
                                                                                    style: res.texto_bold_azul_20,
                                                                                    minFontSize: 8,
                                                                                    maxLines: 1,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    textAlign: TextAlign.center,
                                                                                  )
                                                                              )
                                                                            ],
                                                                          )
                                                                      ),
                                                                      Padding(padding: EdgeInsets.only(left:16)),
                                                                      Container(
                                                                          height: 50,
                                                                          width: largura_coluna,
                                                                          color: Colors.transparent,
                                                                          child: Column(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            children: [
                                                                              AutoSizeText(
                                                                                "Adesão s/ Fid.",
                                                                                style: res.texto_azul_12,
                                                                                minFontSize: 8,
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                              Obx(() =>
                                                                                  AutoSizeText(
                                                                                    NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.adesao_sem_fidelidade.value),
                                                                                    style: res.texto_bold_azul_20,
                                                                                    minFontSize: 8,
                                                                                    maxLines: 1,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    textAlign: TextAlign.center,
                                                                                  )
                                                                              )
                                                                            ],
                                                                          )
                                                                      ),
                                                                      Padding(
                                                                          padding: EdgeInsets.only(left: 16),
                                                                          child: Container(
                                                                              height: 50,
                                                                              width: largura_coluna*3 + 32,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                                                                gradient: LinearGradient(
                                                                                    begin: Alignment(0,-1),
                                                                                    end: Alignment(0,2),
                                                                                    colors: <Color>[res.azul_escuro, Color(0xff131934)]),
                                                                              ),
                                                                              child: Material(
                                                                                color: Colors.transparent,
                                                                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                                                                child: InkWell(
                                                                                    splashColor: Colors.white,
                                                                                    hoverColor: res.azul_claro,
                                                                                    borderRadius: BorderRadius.all(Radius.circular(16)),
                                                                                    onTap: (){
                                                                                      if(controller.lista_mostrar.length > 0){
                                                                                        if(controller.lista_casa.isNotEmpty){
                                                                                          bool retorno = controller.verificar_mind_plus();
                                                                                          if(retorno){
                                                                                            mostrar.mostrar_dialogo_adicionar_item(context, DialogoGerarProposta());
                                                                                          }
                                                                                          else{
                                                                                            mostrar_dialogo_mind_ausente();
                                                                                          }
                                                                                        }
                                                                                        else{
                                                                                          mostrar.mostrar_dialogo_adicionar_item(context, DialogoGerarProposta());
                                                                                        }
                                                                                      }
                                                                                      else{
                                                                                        Flushbar(
                                                                                          backgroundColor: Colors.red,
                                                                                          messageText: Text('Não há itens inseridos para gerar uma proposta', style: res.texto_branco_16,),
                                                                                          duration: Duration(seconds: 2),
                                                                                        ).show(context);
                                                                                      }
                                                                                    },
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: <Widget>[
                                                                                        Padding(
                                                                                            padding:EdgeInsets.only(left: 16),
                                                                                            child: SvgPicture.asset(
                                                                                              "assets/icone-exportar.svg",
                                                                                              height: 24,
                                                                                            )
                                                                                        ),
                                                                                        Container(
                                                                                          width: largura_coluna*2 - 88, //16 + 16 padding externo | 24 + 24 ícones | 4 + 4 padding interno
                                                                                          child: AutoSizeText(
                                                                                            "Gerar Proposta",
                                                                                            style: res.texto_branco_16,
                                                                                            minFontSize: 8,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            textAlign: TextAlign.center,
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                            padding:EdgeInsets.only(right: 16),
                                                                                            child: SvgPicture.asset(
                                                                                              "assets/icone-exportar.svg",
                                                                                              height: 24,
                                                                                            )
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                ),
                                                                              )
                                                                          )
                                                                      ),
                                                                    ]
                                                                ),
                                                              ],
                                                            )
                                                        ),
                                                      )
                                                    ],
                                                  )
                                              )
                                            ],
                                          ),
                                          Padding(padding: EdgeInsets.only(left: 16)),
                                          Container(
                                            width: (largura_coluna*5) + 64,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    child: Center(
                                                        child: Container(
                                                          width: (largura_coluna*3) + 64,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Obx(() =>
                                                                  AutoSizeText(
                                                                    controller.produto_selecionado.value.descricao,
                                                                    style: res.texto_bold_azul_20,
                                                                    minFontSize: 8,
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    textAlign: TextAlign.center,
                                                                  )
                                                              ),
                                                              Obx(() =>
                                                                  Container(
                                                                    child: Image(image: AssetImage(controller.produto_selecionado.value.imagem), fit: BoxFit.contain,),
                                                                  )
                                                              )
                                                            ],
                                                          ),
                                                        ).animate(
                                                            controller: controller_animacao_imagem,
                                                            onComplete: (controller) => controller.reverse()
                                                        ).scaleXY(duration: Duration(milliseconds: 250), curve: Curves.easeInOutBack, begin: 1, end: 0)
                                                            .fadeOut(duration: Duration(milliseconds: 250), curve: Curves.easeInOutBack)
                                                    )
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(child: Container(color: Colors.transparent,)),
                                                    Container(
                                                      height: 50,
                                                      child: Image(image: AssetImage("assets/logo.png"), fit: BoxFit.contain,),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                )
                              )
                      )
                  );
                }
                else if(largura>1000 && largura<1400 && altura > 500){//tela média
                  return Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        //backgroundColor: res.azul_escuro,
                        flexibleSpace: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment(-1,-1),
                                end: Alignment(1,2),
                                colors: <Color>[res.azul_escuro, res.azul_escuro, Color(0xff19558D)]),
                          ),
                        ),
                        toolbarHeight: altura*0.077,
                        title: Padding(
                          padding: EdgeInsets.only(left: largura_coluna + 32, right: largura_coluna + 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: AutoSizeText(
                                      'Simulador de Planos Unifique',
                                      style: res.texto_bold_branco_20,
                                      minFontSize: 8,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                              ),
                              Container(
                                height: altura*0.077,
                                width: altura*0.077,
                                child: Padding(
                                    padding: EdgeInsets.only(top: 4, bottom: 4),
                                    child: SvgPicture.asset(
                                      "assets/logo-branca.svg",
                                      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                      fit: BoxFit.contain,
                                    )
                                  ///Image(image: AssetImage("assets/logo-branca.svg"), fit: BoxFit.contain,)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      body: Obx(
                              () =>
                              AnimatedOpacity(
                                  opacity: controller.opacidade_layout.value,
                                  duration: Duration(seconds: 2),
                                  curve: Curves.easeInExpo,
                                  child: AnimatedSlide(
                                    duration: Duration(seconds: 2),
                                    curve: Curves.easeInExpo,
                                    offset: Offset(0, controller.opacidade_layout.value/4 - 0.25),
                                    child: Padding(
                                        padding: EdgeInsets.only(left: largura_coluna + 32, right: largura_coluna + 32, bottom: 8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                        padding: EdgeInsets.only(left: largura_coluna + 16),
                                                        child: Container(
                                                          width: (largura_coluna*6) + 80,
                                                          child: PopoverWidget(0),
                                                        )
                                                    ),
                                                  ],
                                                ),
                                                Expanded(
                                                    child:Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                            width: largura_coluna,
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  width: largura_coluna,
                                                                  height: 40,
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: [
                                                                      Obx(() =>
                                                                          AutoSizeText(
                                                                            controller.desc_tipo_cliente.value,
                                                                            style: controller.tipo_cliente == 0
                                                                                ? res.texto_bold_azul_16
                                                                                : res.texto_bold_azul_claro_16,
                                                                            minFontSize: 8,
                                                                            textAlign: TextAlign.center,
                                                                            maxLines: 1,
                                                                            wrapWords: false,
                                                                            overflowReplacement: Text("...", style:  res.texto_bold_azul_16,),
                                                                          ).animate(
                                                                              controller: controller_animacao_tipo_cliente,
                                                                              onComplete: (controller) => controller.reverse()
                                                                          ).fadeOut(duration: Duration(milliseconds: 250), curve: Curves.easeOutQuint),
                                                                      ),
                                                                      Material(
                                                                          color: Colors.transparent,
                                                                          child: InkWell(
                                                                            onTap: (){},
                                                                            onHover: (value) async {
                                                                              if (value) {
                                                                                if (controller.lista_mostrar.length > 0 && controller.aviso_alteracao_tipo_cliente == 0) {
                                                                                  //se houver essa alteração, os itens incluídos serão apagados para não haver incompatibilidade de valores
                                                                                  mostrar_dialogo_alterar_tipo_cliente();
                                                                                }
                                                                              }
                                                                            },
                                                                            splashColor: Colors.transparent,
                                                                            hoverColor: Colors.transparent,
                                                                            highlightColor: Colors.transparent,
                                                                            child: Switcher(
                                                                              curveType: Curves.slowMiddle,
                                                                              animationDuration: Duration(milliseconds: 500),
                                                                              switcherRadius: 20,
                                                                              value: false,
                                                                              size: SwitcherSize.small,
                                                                              switcherButtonRadius: 45,
                                                                              enabledSwitcherButtonRotate: true,
                                                                              iconOff: Icons.person,
                                                                              iconOn: Icons.factory_rounded,
                                                                              colorOff: res.azul_escuro,
                                                                              colorOn: res.azul_claro,
                                                                              switcherButtonColor: Colors.white,
                                                                              onChanged: (bool novo) async {
                                                                                controller_animacao_tipo_cliente.forward();
                                                                                controller_animacao_imagem.forward();
                                                                                Future.delayed(const Duration(milliseconds: 250), () {
                                                                                  if(novo)
                                                                                    controller.alterar_tipo_cliente(1);
                                                                                  else
                                                                                    controller.alterar_tipo_cliente(0);
                                                                                });
                                                                              },
                                                                            ),
                                                                          )
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(height:8),
                                                                Expanded(
                                                                  child: ScrollConfiguration(
                                                                      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                                                      child: GlowingOverscrollIndicator(
                                                                          axisDirection: AxisDirection.down,
                                                                          color: res.azul_claro.withOpacity(0.25),
                                                                          child: Obx(() =>
                                                                              ListView.builder(
                                                                                itemCount: controller.lista_produtos.length,
                                                                                shrinkWrap: true,
                                                                                scrollDirection: Axis.vertical,
                                                                                padding: EdgeInsets.zero,
                                                                                itemBuilder: (_, index){
                                                                                  return Card(
                                                                                      shadowColor: res.azul_escuro.withOpacity(0.5),
                                                                                      elevation: 5,
                                                                                      margin: EdgeInsets.only(bottom: 8),
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(14),
                                                                                      ),
                                                                                      child: InkWell(
                                                                                          splashColor: Colors.white,
                                                                                          hoverColor: res.azul_claro,
                                                                                          onHover: (isHover){
                                                                                            if(isHover)
                                                                                              controller.alterar_hover_color_produtos(true, index);
                                                                                            else
                                                                                              controller.alterar_hover_color_produtos(false, index);
                                                                                          },
                                                                                          borderRadius: BorderRadius.circular(14),
                                                                                          onTap: (){
                                                                                            controller.alterar_indice_selecionado_produtos(index);
                                                                                            controller_animacao_imagem.forward();
                                                                                            Future.delayed(const Duration(milliseconds: 250), () {
                                                                                              controller.seleciona_produto(controller.lista_produtos[index]);
                                                                                            });
                                                                                          },
                                                                                          child: Container(
                                                                                            width: largura_coluna,
                                                                                            height: largura_coluna,
                                                                                            decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.circular(14),
                                                                                                color: Colors.transparent
                                                                                            ),
                                                                                            child: Column(
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                                              children: [
                                                                                                Expanded(
                                                                                                    child: Center(
                                                                                                      child: Container(
                                                                                                          width: largura_coluna*0.30,
                                                                                                          height: largura_coluna*0.30,
                                                                                                          child: Obx(() =>
                                                                                                              SvgPicture.asset(
                                                                                                                controller.hover_color_produtos == true
                                                                                                                    && controller.hover_color_produtos_index == index
                                                                                                                    ? controller.lista_produtos[index].icone_branco
                                                                                                                    : controller.lista_indice_selecionado == index
                                                                                                                    ? controller.lista_produtos[index].icone_azul_claro
                                                                                                                    : controller.lista_produtos[index].icone,
                                                                                                              )
                                                                                                          )
                                                                                                      ),
                                                                                                    )
                                                                                                ),
                                                                                                Padding(
                                                                                                    padding: EdgeInsets.only(left: 2, right: 2, bottom: 4),
                                                                                                    child: Obx(() =>
                                                                                                        AutoSizeText(
                                                                                                          controller.lista_produtos[index].descricao,
                                                                                                          style:
                                                                                                          controller.hover_color_produtos == true
                                                                                                              && controller.hover_color_produtos_index == index
                                                                                                              ? res.texto_bold_branco_16
                                                                                                              : controller.lista_indice_selecionado == index ? res.texto_bold_azul_claro_16 : res.texto_bold_azul_16,
                                                                                                          minFontSize: 8,
                                                                                                          textAlign: TextAlign.center,
                                                                                                          maxLines: 2,
                                                                                                          wrapWords: false,
                                                                                                          overflowReplacement: Text("...", style:  res.texto_bold_azul_16,),
                                                                                                        )
                                                                                                    )
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          )
                                                                                      )
                                                                                  );
                                                                                },
                                                                              )
                                                                          )
                                                                      )
                                                                  ).animate(
                                                                      controller: controller_animacao_tipo_cliente,
                                                                      onComplete: (controller) => controller.reverse()
                                                                  ).fadeOut(duration: Duration(milliseconds: 250), curve: Curves.easeOutQuint),
                                                                )
                                                              ],
                                                            )
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: 8),
                                                          child: Container(
                                                              width: (largura_coluna*6) + 80,
                                                              //height: 500,
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                      children: [
                                                                        //Container(color: Colors.blue, height: 50, width: 50,)
                                                                        Padding(
                                                                            padding: EdgeInsets.only(right: 16),
                                                                            child: Container(
                                                                                height: 40,
                                                                                width: largura_coluna*2 + 16,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(14)),
                                                                                  gradient: LinearGradient(
                                                                                      begin: Alignment(0,-1),
                                                                                      end: Alignment(0,2),
                                                                                      colors: <Color>[res.azul_escuro, Color(0xff131934)]),
                                                                                ),
                                                                                child: Material(
                                                                                  color: Colors.transparent,
                                                                                  borderRadius: BorderRadius.all(Radius.circular(14)),
                                                                                  child: InkWell(
                                                                                      splashColor: Colors.white,
                                                                                      hoverColor: res.azul_claro,
                                                                                      borderRadius: BorderRadius.all(Radius.circular(14)),
                                                                                      onTap: (){
                                                                                        //mostrar.mostrar_dialogo_adicionar_item(context, DialogoCliente());
                                                                                        abrir_dialogo_adicionar_item();
                                                                                      },
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        children: <Widget>[
                                                                                          Padding(
                                                                                              padding:EdgeInsets.only(left: 8, right: 8),
                                                                                              child: SvgPicture.asset(
                                                                                                "assets/icone-adicionar.svg",
                                                                                                height: 20,
                                                                                              )
                                                                                          ),
                                                                                          Container(
                                                                                            width: largura_coluna*2 - 52,
                                                                                            child: AutoSizeText(
                                                                                              "Adicionar Produto",
                                                                                              style: res.texto_branco_12,
                                                                                              minFontSize: 8,
                                                                                              maxLines: 2,
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                              textAlign: TextAlign.center,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      )
                                                                                  ),
                                                                                )
                                                                            )
                                                                        ),
                                                                        Padding(
                                                                            padding: EdgeInsets.only(right: 16),
                                                                            child: Container(
                                                                                height: 40,
                                                                                width: largura_coluna*2 + 16,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(14)),
                                                                                  gradient: LinearGradient(
                                                                                      begin: Alignment(0,-1),
                                                                                      end: Alignment(0,2),
                                                                                      colors: <Color>[res.azul_escuro, Color(0xff131934)]),
                                                                                ),
                                                                                child: Material(
                                                                                  color: Colors.transparent,
                                                                                  borderRadius: BorderRadius.all(Radius.circular(14)),
                                                                                  child: InkWell(
                                                                                      splashColor: Colors.white,
                                                                                      hoverColor: res.azul_claro,
                                                                                      borderRadius: BorderRadius.all(Radius.circular(14)),
                                                                                      onTap: (){
                                                                                        abrir_dialogo_remover_item(-1, 1);
                                                                                      },
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        children: <Widget>[
                                                                                          Padding(
                                                                                              padding:EdgeInsets.only(left: 8, right: 8),
                                                                                              child: SvgPicture.asset(
                                                                                                "assets/icone-cancelar.svg",
                                                                                                height: 20,
                                                                                              )
                                                                                          ),
                                                                                          Container(
                                                                                            width: largura_coluna*2 - 52,
                                                                                            child: AutoSizeText(
                                                                                              "Remover Categoria",
                                                                                              style: res.texto_branco_12,
                                                                                              minFontSize: 8,
                                                                                              maxLines: 2,
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                              textAlign: TextAlign.center,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      )
                                                                                  ),
                                                                                )
                                                                            )
                                                                        ),
                                                                        Padding(
                                                                            padding: EdgeInsets.only(right: 0),
                                                                            child: Container(
                                                                                height: 40,
                                                                                width: largura_coluna*2 + 16,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(14)),
                                                                                  gradient: LinearGradient(
                                                                                      begin: Alignment(0,-1),
                                                                                      end: Alignment(0,2),
                                                                                      colors: <Color>[res.azul_escuro, Color(0xff131934)]),
                                                                                ),
                                                                                child: Material(
                                                                                  color: Colors.transparent,
                                                                                  borderRadius: BorderRadius.all(Radius.circular(14)),
                                                                                  child: InkWell(
                                                                                      splashColor: Colors.white,
                                                                                      hoverColor: res.azul_claro,
                                                                                      borderRadius: BorderRadius.all(Radius.circular(14)),
                                                                                      onTap: (){
                                                                                        abrir_dialogo_remover_item(-1, 2);
                                                                                      },
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        children: <Widget>[
                                                                                          Padding(
                                                                                              padding:EdgeInsets.only(left: 8, right: 8),
                                                                                              child: SvgPicture.asset(
                                                                                                "assets/icone-limpar.svg",
                                                                                                height: 20,
                                                                                              )
                                                                                          ),
                                                                                          Container(
                                                                                            width: largura_coluna*2 - 52,
                                                                                            child: AutoSizeText(
                                                                                              "Limpar Plano",
                                                                                              style: res.texto_branco_12,
                                                                                              minFontSize: 8,
                                                                                              maxLines: 2,
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                              textAlign: TextAlign.center,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      )
                                                                                  ),
                                                                                )
                                                                            )
                                                                        ),
                                                                      ]
                                                                  ),
                                                                  Expanded(
                                                                      child: Padding(
                                                                          padding: EdgeInsets.only(top: 8, bottom: 8),
                                                                          child: ScrollConfiguration(
                                                                              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                                                              child: GlowingOverscrollIndicator(
                                                                                  axisDirection: AxisDirection.down,
                                                                                  color: res.azul_claro.withOpacity(0.25),
                                                                                  child: Obx(() => controller.lista_mostrar.length > 0
                                                                                      ? GroupedListView<ItemMostrar, String>(
                                                                                    elements: controller.lista_mostrar,
                                                                                    groupBy: (ItemMostrar item) => item.grupo,
                                                                                    useStickyGroupSeparators: false,
                                                                                    stickyHeaderBackgroundColor: Colors.transparent,
                                                                                    groupSeparatorBuilder: (value) => Padding(
                                                                                      padding: EdgeInsets.only(bottom: 8, top: 0),
                                                                                      child: Container(
                                                                                        color: Colors.transparent,
                                                                                        child: Text(
                                                                                          value,
                                                                                          textAlign: TextAlign.left,
                                                                                          style: res.texto_bold_azul_12,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    shrinkWrap: true,
                                                                                    scrollDirection: Axis.vertical,
                                                                                    indexedItemBuilder: (_, item, index){
                                                                                      return WidgetItemLista(item, index, 40);
                                                                                    },
                                                                                  )
                                                                                      : Center(child: SemDados()),
                                                                                  )
                                                                              )
                                                                          )
                                                                      )
                                                                  ),
                                                                  Row(
                                                                      children: [
                                                                        Container(
                                                                            height: 40,
                                                                            width: largura_coluna,
                                                                            color: Colors.transparent,
                                                                            child: Column(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                AutoSizeText(
                                                                                  "Adesão",
                                                                                  style: res.texto_azul_12,
                                                                                  minFontSize: 8,
                                                                                  maxLines: 1,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  textAlign: TextAlign.center,
                                                                                ),
                                                                                Obx(() =>
                                                                                    Container(
                                                                                      child: AutoSizeText(
                                                                                        NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.adesao_com_fidelidade.value),
                                                                                        style: res.texto_bold_azul_16,
                                                                                        minFontSize: 8,
                                                                                        maxLines: 1,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        textAlign: TextAlign.center,
                                                                                      ),
                                                                                    )
                                                                                )
                                                                              ],
                                                                            )
                                                                        ),
                                                                        Padding(padding: EdgeInsets.only(left:16)),
                                                                        Container(
                                                                            height: 40,
                                                                            width: largura_coluna,
                                                                            color: Colors.transparent,
                                                                            child: Column(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                AutoSizeText(
                                                                                  "Mensalidade",
                                                                                  style: res.texto_azul_12,
                                                                                  minFontSize: 8,
                                                                                  maxLines: 1,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  textAlign: TextAlign.center,
                                                                                ),
                                                                                Obx(() =>
                                                                                    AutoSizeText(
                                                                                      NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.mensalidade.value),
                                                                                      style: res.texto_bold_azul_16,
                                                                                      minFontSize: 8,
                                                                                      maxLines: 1,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      textAlign: TextAlign.center,
                                                                                    )
                                                                                )
                                                                              ],
                                                                            )
                                                                        ),
                                                                        Padding(padding: EdgeInsets.only(left:16)),
                                                                        Container(
                                                                            height: 40,
                                                                            width: largura_coluna,
                                                                            color: Colors.transparent,
                                                                            child: Column(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                AutoSizeText(
                                                                                  "Adesão s/ Fid.",
                                                                                  style: res.texto_azul_12,
                                                                                  minFontSize: 8,
                                                                                  maxLines: 1,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  textAlign: TextAlign.center,
                                                                                ),
                                                                                Obx(() =>
                                                                                    AutoSizeText(
                                                                                      NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.adesao_sem_fidelidade.value),
                                                                                      style: res.texto_bold_azul_16,
                                                                                      minFontSize: 8,
                                                                                      maxLines: 1,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      textAlign: TextAlign.center,
                                                                                    )
                                                                                )
                                                                              ],
                                                                            )
                                                                        ),
                                                                        Padding(
                                                                            padding: EdgeInsets.only(left: 16),
                                                                            child: Container(
                                                                                height: 40,
                                                                                width: largura_coluna*3 + 32,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(14)),
                                                                                  gradient: LinearGradient(
                                                                                      begin: Alignment(0,-1),
                                                                                      end: Alignment(0,2),
                                                                                      colors: <Color>[res.azul_escuro, Color(0xff131934)]),
                                                                                ),
                                                                                child: Material(
                                                                                  color: Colors.transparent,
                                                                                  borderRadius: BorderRadius.all(Radius.circular(14)),
                                                                                  child: InkWell(
                                                                                      splashColor: Colors.white,
                                                                                      hoverColor: res.azul_claro,
                                                                                      borderRadius: BorderRadius.all(Radius.circular(14)),
                                                                                      onTap: (){
                                                                                        if(controller.lista_mostrar.length > 0){
                                                                                          if(controller.lista_casa.isNotEmpty){
                                                                                            bool retorno = controller.verificar_mind_plus();
                                                                                            if(retorno){
                                                                                              mostrar.mostrar_dialogo_adicionar_item(context, DialogoGerarProposta());
                                                                                            }
                                                                                            else{
                                                                                              mostrar_dialogo_mind_ausente();
                                                                                            }
                                                                                          }
                                                                                          else{
                                                                                            mostrar.mostrar_dialogo_adicionar_item(context, DialogoGerarProposta());
                                                                                          }
                                                                                        }
                                                                                        else{
                                                                                          Flushbar(
                                                                                            backgroundColor: Colors.red,
                                                                                            messageText: Text('Não há itens inseridos para gerar uma proposta', style: res.texto_branco_16,),
                                                                                            duration: Duration(seconds: 2),
                                                                                          ).show(context);
                                                                                        }
                                                                                      },
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        children: <Widget>[
                                                                                          Padding(
                                                                                              padding:EdgeInsets.only(left: 8),
                                                                                              child: SvgPicture.asset(
                                                                                                "assets/icone-exportar.svg",
                                                                                                height: 20,
                                                                                              )
                                                                                          ),
                                                                                          Container(
                                                                                            child: AutoSizeText(
                                                                                              "Gerar Proposta",
                                                                                              style: res.texto_branco_12,
                                                                                              minFontSize: 8,
                                                                                              maxLines: 2,
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                              textAlign: TextAlign.center,
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                              padding:EdgeInsets.only(right: 8),
                                                                                              child: SvgPicture.asset(
                                                                                                "assets/icone-exportar.svg",
                                                                                                height: 20,
                                                                                              )
                                                                                          ),
                                                                                        ],
                                                                                      )
                                                                                  ),
                                                                                )
                                                                            )
                                                                        ),
                                                                      ]
                                                                  ),
                                                                ],
                                                              )
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                )
                                              ],
                                            ),
                                            Padding(padding: EdgeInsets.only(left: 16)),
                                            Container(
                                              width: (largura_coluna*5) + 64,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                      child: Center(
                                                          child: Container(
                                                            width: (largura_coluna*3) + 64,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Obx(() =>
                                                                    AutoSizeText(
                                                                      controller.produto_selecionado.value.descricao,
                                                                      style: res.texto_bold_azul_20,
                                                                      minFontSize: 8,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      textAlign: TextAlign.center,
                                                                    )
                                                                ),
                                                                Obx(() =>
                                                                    Container(
                                                                      child: Image(image: AssetImage(controller.produto_selecionado.value.imagem), fit: BoxFit.contain,),
                                                                    )
                                                                )
                                                              ],
                                                            ),
                                                          ).animate(
                                                              controller: controller_animacao_imagem,
                                                              onComplete: (controller) => controller.reverse()
                                                          ).scaleXY(duration: Duration(milliseconds: 250), curve: Curves.easeInOutBack, begin: 1, end: 0)
                                                              .fadeOut(duration: Duration(milliseconds: 250), curve: Curves.easeInOutBack)
                                                      )
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(child: Container(color: Colors.transparent,)),
                                                      Container(
                                                        height: 40,
                                                        child: Image(image: AssetImage("assets/logo.png"), fit: BoxFit.contain,),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                  )
                              )
                      )
                  );
                }
                else if(largura<1000 && altura > 500){//tela celular
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      //backgroundColor: res.azul_escuro,
                      flexibleSpace: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment(-1,-1),
                              end: Alignment(1,2),
                              colors: <Color>[res.azul_escuro, res.azul_escuro, Color(0xff19558D)]),
                        ),
                      ),
                      toolbarHeight: altura*0.05,
                      title: Padding(
                        padding: EdgeInsets.zero,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: AutoSizeText(
                                    'Simulador de Planos Unifique',
                                    style: res.texto_bold_branco_16,
                                    minFontSize: 8,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                            ),
                            Container(
                              height: altura*0.05,
                              width: altura*0.05,
                              child: Padding(
                                  padding: EdgeInsets.only(top: 4, bottom: 4),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: SvgPicture.asset(
                                        "assets/logo-branca.svg",
                                        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                        fit: BoxFit.contain,
                                      )
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    body: Obx(
                      () =>
                      AnimatedOpacity(
                        opacity: controller.opacidade_layout.value,
                        duration: Duration(seconds: 2),
                        curve: Curves.easeInExpo,
                        child: AnimatedSlide(
                          duration: Duration(seconds: 2),
                          curve: Curves.easeInExpo,
                          offset: Offset(0, controller.opacidade_layout.value/4 - 0.25),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:[
                                        Container(
                                            height: 50,
                                            width: 80,
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Obx(() =>
                                                        AutoSizeText(
                                                          controller.desc_tipo_cliente.value == "Pessoa Física"
                                                              ? "P.F."
                                                              : "P.J.",
                                                          style: controller.tipo_cliente == 0
                                                              ? res.texto_bold_azul_12
                                                              : res.texto_bold_azul_claro_12,
                                                          minFontSize: 8,
                                                          textAlign: TextAlign.center,
                                                          maxLines: 1,
                                                          wrapWords: false,
                                                          overflowReplacement: Text("...", style:  res.texto_bold_azul_12,),
                                                        ).animate(
                                                            controller: controller_animacao_tipo_cliente,
                                                            onComplete: (controller) => controller.reverse()
                                                        ).fadeOut(duration: Duration(milliseconds: 250), curve: Curves.easeOutQuint),
                                                    ),
                                                    Material(
                                                        color: Colors.transparent,
                                                        child: InkWell(
                                                          onTap: (){
                                                            if (controller.lista_mostrar.length > 0 && controller.aviso_alteracao_tipo_cliente == 0) {
                                                              //se houver essa alteração, os itens incluídos serão apagados para não haver incompatibilidade de valores
                                                              mostrar_dialogo_alterar_tipo_cliente();
                                                            }
                                                          },
                                                          onHover: (value) async {
                                                            if (value) {
                                                              if (controller.lista_mostrar.length > 0 && controller.aviso_alteracao_tipo_cliente == 0) {
                                                                //se houver essa alteração, os itens incluídos serão apagados para não haver incompatibilidade de valores
                                                                mostrar_dialogo_alterar_tipo_cliente();
                                                              }
                                                            }
                                                          },
                                                          splashColor: Colors.transparent,
                                                          hoverColor: Colors.transparent,
                                                          highlightColor: Colors.transparent,
                                                          child: Obx(
                                                            () =>
                                                              AbsorbPointer(
                                                                absorbing: controller.aviso_alteracao_tipo_cliente == 0 && controller.lista_mostrar.length > 0
                                                                    ? true
                                                                    : false,
                                                                child: Switcher(
                                                                  curveType: Curves.slowMiddle,
                                                                  animationDuration: Duration(milliseconds: 500),
                                                                  switcherRadius: 20,
                                                                  value: false,
                                                                  size: SwitcherSize.small,
                                                                  switcherButtonRadius: 20,
                                                                  enabledSwitcherButtonRotate: true,
                                                                  iconOff: Icons.person,
                                                                  iconOn: Icons.factory_rounded,
                                                                  colorOff: res.azul_escuro,
                                                                  colorOn: res.azul_claro,
                                                                  switcherButtonColor: Colors.white,
                                                                  onChanged: (bool novo) async {
                                                                    controller_animacao_tipo_cliente.forward();
                                                                    controller_animacao_imagem.forward();
                                                                    Future.delayed(const Duration(milliseconds: 250), () {
                                                                      if(novo)
                                                                        controller.alterar_tipo_cliente(1);
                                                                      else
                                                                        controller.alterar_tipo_cliente(0);
                                                                    });
                                                                  },
                                                                ),
                                                              )
                                                          )
                                                        )
                                                    )
                                                  ],
                                                ),
                                            )
                                        ),
                                        PopoverWidget(1),
                                        Container(
                                          height: 50,
                                          width: 80,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Obx(() =>
                                                Image(image: AssetImage(controller.produto_selecionado.value.imagem), fit: BoxFit.contain,),
                                            ).animate(
                                                controller: controller_animacao_imagem,
                                                onComplete: (controller) => controller.reverse()
                                            ).scaleXY(duration: Duration(milliseconds: 250), curve: Curves.easeInOutBack, begin: 1, end: 0)
                                                .fadeOut(duration: Duration(milliseconds: 250), curve: Curves.easeInOutBack)
                                          )
                                        )
                                      ]
                                    ),
                                    SizedBox(height:8),
                                    Container(
                                      height:altura/12 + 8,
                                      child: ScrollConfiguration(
                                          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                          child: GlowingOverscrollIndicator(
                                              axisDirection: AxisDirection.down,
                                              color: res.azul_claro.withOpacity(0.25),
                                              child: Obx(() =>
                                                  ListView.builder(
                                                    itemCount: controller.lista_produtos.length,
                                                    shrinkWrap: true,
                                                    scrollDirection: Axis.horizontal,
                                                    padding: EdgeInsets.zero,
                                                    itemBuilder: (_, index){
                                                      return Padding(
                                                        padding: EdgeInsets.only(bottom:8),
                                                        child: Card(
                                                            shadowColor: res.azul_escuro.withOpacity(0.5),
                                                            elevation: 5,
                                                            margin: EdgeInsets.only(right: 8),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(14),
                                                            ),
                                                            child: InkWell(
                                                                splashColor: Colors.white,
                                                                hoverColor: res.azul_claro,
                                                                onHover: (isHover){
                                                                  if(isHover)
                                                                    controller.alterar_hover_color_produtos(true, index);
                                                                  else
                                                                    controller.alterar_hover_color_produtos(false, index);
                                                                },
                                                                borderRadius: BorderRadius.circular(14),
                                                                onTap: (){
                                                                  controller.alterar_indice_selecionado_produtos(index);
                                                                  controller_animacao_imagem.forward();
                                                                  Future.delayed(const Duration(milliseconds: 250), () {
                                                                    controller.seleciona_produto(controller.lista_produtos[index]);
                                                                  });
                                                                },
                                                                child: Container(
                                                                  width: altura/12,
                                                                  height: altura/12,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(14),
                                                                      color: Colors.transparent
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: [
                                                                      Expanded(
                                                                          child: Center(
                                                                            child: Container(
                                                                                width: (altura/12)*0.35,
                                                                                height: (altura/12)*0.35,
                                                                                child: Obx(() =>
                                                                                    SvgPicture.asset(
                                                                                      controller.hover_color_produtos == true
                                                                                          && controller.hover_color_produtos_index == index
                                                                                          ? controller.lista_produtos[index].icone_branco
                                                                                          : controller.lista_indice_selecionado == index
                                                                                          ? controller.lista_produtos[index].icone_azul_claro
                                                                                          : controller.lista_produtos[index].icone,
                                                                                    )
                                                                                )
                                                                            ),
                                                                          )
                                                                      ),
                                                                      Padding(
                                                                          padding: EdgeInsets.only(left: 2, right: 2, bottom: 4),
                                                                          child: Obx(() =>
                                                                              AutoSizeText(
                                                                                controller.lista_produtos[index].descricao,
                                                                                style:
                                                                                controller.hover_color_produtos == true
                                                                                    && controller.hover_color_produtos_index == index
                                                                                    ? res.texto_bold_branco_16
                                                                                    : controller.lista_indice_selecionado == index ? res.texto_bold_azul_claro_16 : res.texto_bold_azul_16,
                                                                                minFontSize: 8,
                                                                                textAlign: TextAlign.center,
                                                                                maxLines: 2,
                                                                                wrapWords: false,
                                                                                overflowReplacement: Text("...", style:  res.texto_bold_azul_16,),
                                                                              )
                                                                          )
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                            )
                                                        )
                                                      );
                                                    },
                                                  )
                                              )
                                          )
                                      ).animate(
                                          controller: controller_animacao_tipo_cliente,
                                          onComplete: (controller) => controller.reverse()
                                        ).fadeOut(duration: Duration(milliseconds: 250), curve: Curves.easeOutQuint),
                                    ),
                                    Row(
                                        children: [
                                          //Container(color: Colors.blue, height: 50, width: 50,)
                                          Padding(
                                              padding: EdgeInsets.only(right: 8),
                                              child: Container(
                                                  height: 40,
                                                  width: largura/3 - 12,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(14)),
                                                    gradient: LinearGradient(
                                                        begin: Alignment(0,-1),
                                                        end: Alignment(0,2),
                                                        colors: <Color>[res.azul_escuro, Color(0xff131934)]),
                                                  ),
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    borderRadius: BorderRadius.all(Radius.circular(14)),
                                                    child: InkWell(
                                                        splashColor: Colors.white,
                                                        hoverColor: res.azul_claro,
                                                        borderRadius: BorderRadius.all(Radius.circular(14)),
                                                        onTap: (){
                                                          //mostrar.mostrar_dialogo_adicionar_item(context, DialogoCliente());
                                                          abrir_dialogo_adicionar_item();
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            Padding(
                                                                padding:EdgeInsets.only(left: 4, right: 2),
                                                                child: SvgPicture.asset(
                                                                  "assets/icone-adicionar.svg",
                                                                  height: 20,
                                                                )
                                                            ),
                                                            Container(
                                                              width: (largura/3 - 32) - 20 - 6,
                                                              child: AutoSizeText(
                                                                "Add Produto",
                                                                style: res.texto_branco_12,
                                                                minFontSize: 8,
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                    ),
                                                  )
                                              )
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(right: 8),
                                              child: Container(
                                                  height: 40,
                                                  width: largura/3 - 8,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(14)),
                                                    gradient: LinearGradient(
                                                        begin: Alignment(0,-1),
                                                        end: Alignment(0,2),
                                                        colors: <Color>[res.azul_escuro, Color(0xff131934)]),
                                                  ),
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    borderRadius: BorderRadius.all(Radius.circular(14)),
                                                    child: InkWell(
                                                        splashColor: Colors.white,
                                                        hoverColor: res.azul_claro,
                                                        borderRadius: BorderRadius.all(Radius.circular(14)),
                                                        onTap: (){
                                                          abrir_dialogo_remover_item(-1, 1);
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            Padding(
                                                                padding:EdgeInsets.only(left: 4, right: 2),
                                                                child: SvgPicture.asset(
                                                                  "assets/icone-cancelar.svg",
                                                                  height: 20,
                                                                )
                                                            ),
                                                            Container(
                                                              width: (largura/3 - 32) - 20 - 6,
                                                              child: AutoSizeText(
                                                                "Del Categoria",
                                                                style: res.texto_branco_12,
                                                                minFontSize: 8,
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                    ),
                                                  )
                                              )
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(right: 0),
                                              child: Container(
                                                  height: 40,
                                                  width: largura/3 - 12,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(14)),
                                                    gradient: LinearGradient(
                                                        begin: Alignment(0,-1),
                                                        end: Alignment(0,2),
                                                        colors: <Color>[res.azul_escuro, Color(0xff131934)]),
                                                  ),
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    borderRadius: BorderRadius.all(Radius.circular(14)),
                                                    child: InkWell(
                                                        splashColor: Colors.white,
                                                        hoverColor: res.azul_claro,
                                                        borderRadius: BorderRadius.all(Radius.circular(14)),
                                                        onTap: (){
                                                          abrir_dialogo_remover_item(-1, 2);
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            Padding(
                                                                padding:EdgeInsets.only(left: 4, right: 2),
                                                                child: SvgPicture.asset(
                                                                  "assets/icone-limpar.svg",
                                                                  height: 20,
                                                                )
                                                            ),
                                                            Container(
                                                              width: (largura/3 - 32) - 20 - 6,
                                                              child: AutoSizeText(
                                                                "Limpar Plano",
                                                                style: res.texto_branco_12,
                                                                minFontSize: 8,
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                    ),
                                                  )
                                              )
                                          ),
                                        ]
                                    ),
                                    Expanded(
                                        child: Padding(
                                            padding: EdgeInsets.only(top: 8, bottom: 8),
                                            child: ScrollConfiguration(
                                                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                                child: GlowingOverscrollIndicator(
                                                    axisDirection: AxisDirection.down,
                                                    color: res.azul_claro.withOpacity(0.25),
                                                    child: Obx(() => controller.lista_mostrar.length > 0
                                                        ? GroupedListView<ItemMostrar, String>(
                                                      elements: controller.lista_mostrar,
                                                      groupBy: (ItemMostrar item) => item.grupo,
                                                      useStickyGroupSeparators: false,
                                                      stickyHeaderBackgroundColor: Colors.transparent,
                                                      groupSeparatorBuilder: (value) => Padding(
                                                        padding: EdgeInsets.only(bottom: 4, top: 0),
                                                        child: Container(
                                                          color: Colors.transparent,
                                                          child: Text(
                                                            value,
                                                            textAlign: TextAlign.left,
                                                            style: res.texto_bold_azul_12,
                                                          ),
                                                        ),
                                                      ),
                                                      shrinkWrap: true,
                                                      scrollDirection: Axis.vertical,
                                                      indexedItemBuilder: (_, item, index){
                                                        return WidgetItemListaCelular(item, index);
                                                      },
                                                    )
                                                        : Center(child: SemDados()),
                                                    )
                                                )
                                            )
                                        )
                                    ),
                                    Row(
                                        children: [
                                          Container(
                                              height: 40,
                                              width: largura/3 - 12,
                                              color: Colors.transparent,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  AutoSizeText(
                                                    "Adesão",
                                                    style: res.texto_azul_12,
                                                    minFontSize: 8,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Obx(() =>
                                                      Container(
                                                        child: AutoSizeText(
                                                          NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.adesao_com_fidelidade.value),
                                                          style: res.texto_bold_azul_16,
                                                          minFontSize: 8,
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      )
                                                  )
                                                ],
                                              )
                                          ),
                                          SizedBox(width:8),
                                          Container(
                                              height: 40,
                                              width: largura/3 - 8,
                                              color: Colors.transparent,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  AutoSizeText(
                                                    "Mensalidade",
                                                    style: res.texto_azul_12,
                                                    minFontSize: 8,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Obx(() =>
                                                      AutoSizeText(
                                                        NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.mensalidade.value),
                                                        style: res.texto_bold_azul_16,
                                                        minFontSize: 8,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        textAlign: TextAlign.center,
                                                      )
                                                  )
                                                ],
                                              )
                                          ),
                                          SizedBox(width:8),
                                          Container(
                                              height: 40,
                                              width: largura/3 - 12,
                                              color: Colors.transparent,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  AutoSizeText(
                                                    "Adesão s/ Fid.",
                                                    style: res.texto_azul_12,
                                                    minFontSize: 8,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Obx(() =>
                                                      AutoSizeText(
                                                        NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.adesao_sem_fidelidade.value),
                                                        style: res.texto_bold_azul_16,
                                                        minFontSize: 8,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        textAlign: TextAlign.center,
                                                      )
                                                  )
                                                ],
                                              )
                                          ),
                                        ]
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(top:8),
                                        child: Container(
                                            height: 40,
                                            width: largura - 16,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(14)),
                                              gradient: LinearGradient(
                                                  begin: Alignment(0,-1),
                                                  end: Alignment(0,2),
                                                  colors: <Color>[res.azul_escuro, Color(0xff131934)]),
                                            ),
                                            child: Material(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.all(Radius.circular(14)),
                                              child: InkWell(
                                                  splashColor: Colors.white,
                                                  hoverColor: res.azul_claro,
                                                  borderRadius: BorderRadius.all(Radius.circular(14)),
                                                  onTap: (){
                                                    if(controller.lista_mostrar.length > 0){
                                                      if(controller.lista_casa.isNotEmpty){
                                                        bool retorno = controller.verificar_mind_plus();
                                                        if(retorno){
                                                          mostrar.mostrar_dialogo_adicionar_item(context, DialogoGerarProposta());
                                                        }
                                                        else{
                                                          mostrar_dialogo_mind_ausente();
                                                        }
                                                      }
                                                      else{
                                                        mostrar.mostrar_dialogo_adicionar_item(context, DialogoGerarProposta());
                                                      }
                                                    }
                                                    else{
                                                      Flushbar(
                                                        backgroundColor: Colors.red,
                                                        messageText: Text('Não há itens inseridos para gerar uma proposta', style: res.texto_branco_16,),
                                                        duration: Duration(seconds: 2),
                                                      ).show(context);
                                                    }
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Padding(
                                                          padding:EdgeInsets.only(left: 8),
                                                          child: SvgPicture.asset(
                                                            "assets/icone-exportar.svg",
                                                            height: 20,
                                                          )
                                                      ),
                                                      Container(
                                                        child: AutoSizeText(
                                                          "Gerar Proposta",
                                                          style: res.texto_branco_12,
                                                          minFontSize: 8,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding:EdgeInsets.only(right: 8),
                                                          child: SvgPicture.asset(
                                                            "assets/icone-exportar.svg",
                                                            height: 20,
                                                          )
                                                      ),
                                                    ],
                                                  )
                                              ),
                                            )
                                        )
                                    ),
                                ]
                            )
                          )
                        )
                      )
                    )
                  );
                }
                else{
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
          ),
        )
    );
  }

  //a definição de qual dialogo abrir é dada pelo id do produto.
  //0 - CASA INTELIGENTE
  //1 - CÂMERAS
  //2 - MESH
  //3 - CANAIS
  abrir_dialogo_adicionar_item(){
    Dialogos mostrar = Dialogos();
    switch(controller.produto_selecionado.value.id) {
      case 0:
        mostrar.mostrar_dialogo_adicionar_item(context, DialogoCasaInteligente());
        break;
      case 1:
        mostrar.mostrar_dialogo_adicionar_item(context, DialogoCamera());
        break;
      case 2:
        mostrar.mostrar_dialogo_adicionar_item(context, DialogoMesh());
        break;
      case 3:
        mostrar.mostrar_dialogo_adicionar_item(context, DialogoWifiBusiness());
        break;
      case 4:
        mostrar.mostrar_dialogo_adicionar_item(context, DialogoTelemedicina());
        break;
      case 5:
        mostrar.mostrar_dialogo_adicionar_item(context, DialogoInternet());
        break;
      case 6:
        mostrar.mostrar_dialogo_adicionar_item(context, DialogoTvHD());
        break;
      case 7:
        mostrar.mostrar_dialogo_adicionar_item(context, DialogoTelefonia());
        break;
      case 8:
        mostrar.mostrar_dialogo_adicionar_item(context, DialogoCombo());
        break;
      default:
        Res res = Res();
        Flushbar(
          backgroundColor: Colors.red,
          messageText: Text('Selecione um produto da lista para então inserir', style: res.texto_branco_16,),
          duration: Duration(seconds: 2),
        ).show(context);
        break;
    }
  }

  abrir_dialogo_remover_item(int indice, int parametro){
    if(controller.lista_mostrar.length == 0){
      Res res = Res();
      Flushbar(
        backgroundColor: Colors.red,
        messageText: Text('Não existem itens inseridos para excluir', style: res.texto_branco_16,),
        duration: Duration(seconds: 2),
      ).show(context);
    }
    else{
      Dialogos mostrar = Dialogos();
      switch(parametro) {
        case 1: {
          switch(controller.produto_selecionado.value.id) {
            case 0: {
              CasaInteligente dialogo = CasaInteligente();
              mostrar.mostrar_dialogo_remover_item(context, dialogo.titulo_excluir, dialogo.msg_excluir, indice, parametro);
            }
            break;
            case 1: {
              Camera dialogo = Camera();
              mostrar.mostrar_dialogo_remover_item(context, dialogo.titulo_excluir, dialogo.msg_excluir, indice, parametro);
            }
            break;
            case 2: {
              Mesh dialogo = Mesh();
              mostrar.mostrar_dialogo_remover_item(context, dialogo.titulo_excluir, dialogo.msg_excluir, indice, parametro);
            }
            break;
            case 3: {
              WifiBusiness dialogo = WifiBusiness();
              mostrar.mostrar_dialogo_remover_item(context, dialogo.titulo_excluir, dialogo.msg_excluir, indice, parametro);
            }
            break;
            case 4: {
              Telemedicina dialogo = Telemedicina();
              mostrar.mostrar_dialogo_remover_item(context, dialogo.titulo_excluir, dialogo.msg_excluir, indice, parametro);
            }
            break;
            case 5: {
              Internet dialogo = Internet();
              mostrar.mostrar_dialogo_remover_item(context, dialogo.titulo_excluir, dialogo.msg_excluir, indice, parametro);
            }
            break;
            case 6: {
              TvHd dialogo = TvHd();
              mostrar.mostrar_dialogo_remover_item(context, dialogo.titulo_excluir, dialogo.msg_excluir, indice, parametro);
            }
            break;
            case 7: {
              Telefone dialogo = Telefone();
              mostrar.mostrar_dialogo_remover_item(context, dialogo.titulo_excluir, dialogo.msg_excluir, indice, parametro);
            }
            break;
            case 8: {
              Combo dialogo = Combo();
              mostrar.mostrar_dialogo_remover_item(context, dialogo.titulo_excluir, dialogo.msg_excluir, indice, parametro);
            }
            break;
            default: {
              Res res = Res();
              Flushbar(
                backgroundColor: Colors.red,
                messageText: Text('Ocorreu um erro ao excluir', style: res.texto_branco_16,),
                duration: Duration(seconds: 2),
              ).show(context);
            }
            break;
          }
        }
        break;
        case 2: {
          String titulo = "Limpar Plano";
          String msg = "Deseja realmente remover todos os itens deste plano?";
          mostrar.mostrar_dialogo_remover_item(context, titulo, msg, indice, parametro);
        }
        break;
        default: {
          Res res = Res();
          Flushbar(
            backgroundColor: Colors.red,
            messageText: Text('Ocorreu um erro ao excluir', style: res.texto_branco_16,),
            duration: Duration(seconds: 2),
          ).show(context);
        }
        break;
      }
    }
  }
  mostrar_dialogo_alterar_tipo_cliente() async{
    Res res = Res();
    var largura = MediaQuery.of(context).size.width;
    String titulo = "Alterar Tipo de Cliente";
    String mensagem = "Ao alterar o tipo do cliente, todas as informações inseridas no plano serão excluídas. Isso acontece por incompatibilidade de planos, isto é, nem todos os planos e serviços ofertados para Pessoa Física existem para Pessoa Jurídica e vice-versa.\n\nDeseja realmente continuar?";
    await showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CustomDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: (largura > 1300) ? largura/2.5 : largura/1,
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
                              padding: EdgeInsets.all(16),
                              child: Text(
                                titulo,
                                style: res.texto_bold_azul_16,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16,0,16,0),
                              child: Text(
                                mensagem,
                                style: res.texto_azul_16,
                                textAlign: TextAlign.center,
                              ),
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
                                          onTap: (){
                                            controller.alterar_aviso_alteracao_tipo_cliente(0);
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
                                          onTap: (){
                                            controller.alterar_aviso_alteracao_tipo_cliente(1);
                                            Navigator.of(context).pop();
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
            )
        );
      },
      animationType: DialogTransitionType.fadeScale,
      curve: Curves.easeOutQuint,
      duration: Duration(milliseconds: 500),
    );
  }

  mostrar_dialogo_mind_ausente() {
    Res res = Res();
    var largura = MediaQuery.of(context).size.width;
    String titulo = "Mind Plus";
    String mensagem = "Está sendo gerado uma proposta com itens da Casa Inteligente sem o Mind Plus. O serviço só funcionará com o Mind Plus incluído.\nSe o cliente já possui o Mind Plus em sua residência, prossiga. Caso contrário, insira o Mind Plus.\n\nDeseja realmente continuar?";
    showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CustomDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: SingleChildScrollView(
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
                              padding: EdgeInsets.all(16),
                              child: Text(
                                titulo,
                                style: res.texto_bold_azul_16,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16,0,16,0),
                              child: Text(
                                mensagem,
                                style: res.texto_azul_16,
                                textAlign: TextAlign.center,
                              ),
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
                                          onTap: (){
                                            controller.alterar_aviso_alteracao_tipo_cliente(0);
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
                                          onTap: (){
                                            Navigator.of(context).pop();
                                            Future.delayed(const Duration(milliseconds: 400), () {
                                              mostrar.mostrar_dialogo_adicionar_item(context, DialogoGerarProposta());
                                            });
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
            )
        );
      },
      animationType: DialogTransitionType.fadeScale,
      curve: Curves.easeOutQuint,
      duration: Duration(milliseconds: 500),
    );
  }
}