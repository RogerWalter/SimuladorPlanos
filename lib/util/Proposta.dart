import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:simulador_unifique/model/CasaInteligente.dart';
import 'package:simulador_unifique/model/Combo.dart';
import 'package:simulador_unifique/model/Internet.dart';
import 'package:simulador_unifique/model/Telemedicina.dart';
import 'package:simulador_unifique/model/TvHd.dart';
import 'package:simulador_unifique/model/WifiBusiness.dart';
import 'package:simulador_unifique/util/Res.dart';

import '../model/Camera.dart';
import '../model/Mesh.dart';
import '../model/Telefone.dart';
import 'Controller.dart';


class Proposta{

  Proposta();

  Future<void> gerar_pdf() async{
    Controller controller = Get.find();
    Res res = Res();

    //CAMERA = AMBIENTE - ARMAZ. - LICENÇA - QUANTIDADE
    //COMBO = PLANO - QTD
    //INTERNET = PLANO QTD
    //MESH = PLANO - QTD
    //TELEFONE = PLANO - QTD
    //TELEMEDICINA = PLANO - QTD
    //TVHD = PLANO - QTD
    //WIFI-BUSINESS = AP/LINK - LICENÇA - QTD

    List<CameraMostrar> camera_lista = [];
    List<ComboMostrar> combo_lista = [];
    List<InternetMostrar> internet_lista = [];
    List<MeshMostrar> mesh_lista = [];
    List<TelefoneMostrar> telefone_lista = [];
    List<TelemedicinaMostrar> telemed_lista = [];
    List<TvHdMostrar> tvhd_lista = [];
    List<WifiBusinessMostrar> wifibusi_lista = [];
    List<CasaMostrar> casa_lista = [];

    //PREPARAÇÃO DAS LISTAS
    if(controller.lista_camera.isNotEmpty){
      camera_lista = Camera().preparar_lista_camera(controller.lista_camera);
    }
    if(controller.lista_combo.isNotEmpty){
      combo_lista = Combo().preparar_lista_combo(controller.lista_combo);
    }
    if(controller.lista_internet.isNotEmpty){
      internet_lista = Internet().preparar_lista_internet(controller.lista_internet);
    }
    if(controller.lista_mesh.isNotEmpty){
      mesh_lista = Mesh().preparar_lista_mesh(controller.lista_mesh);
    }
    if(controller.lista_telef.isNotEmpty){
      telefone_lista = Telefone().preparar_lista_telefone(controller.lista_telef);
    }
    if(controller.lista_telemedicina.isNotEmpty){
      telemed_lista = Telemedicina().preparar_lista_telemedicina(controller.lista_telemedicina);
    }
    if(controller.lista_tvhd.isNotEmpty){
      tvhd_lista = TvHd().preparar_lista_tvhd(controller.lista_tvhd);
    }
    if(controller.lista_tvhd.isNotEmpty){
      tvhd_lista = TvHd().preparar_lista_tvhd(controller.lista_tvhd);
    }
    if(controller.lista_wifibusiness.isNotEmpty){
      wifibusi_lista = WifiBusiness().preparar_lista_wifibusiness(controller.lista_wifibusiness);
    }
    if(controller.lista_casa.isNotEmpty){
      casa_lista = CasaInteligente().preparar_lista_casa(controller.lista_casa);
    }

    const PdfColor azul_escuro_pdf = PdfColor.fromInt(0xff232f66);
    const PdfColor azul_claro_pdf = PdfColor.fromInt(0xff00b1eb);
    const PdfColor branco_pdf = PdfColor.fromInt(0xffffffff);

    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await rootBundle.load("fonts/UniviaPro-Book.ttf");
    final font_bold = await rootBundle.load("fonts/UniviaPro-Bold.ttf");
    final ttf = pw.Font.ttf(font);
    final ttf_bold = pw.Font.ttf(font_bold);
    final image_header = await imageFromAssetBundle('assets/header.png');
    final image_bottom = await imageFromAssetBundle('assets/bottom.png');
    DateTime now = DateTime.now();
    String data_relatorio = DateFormat('dd/MM/yyyy kk:mm:ss').format(now);

    final texto_bold_20_azul_escuro = pw.TextStyle(font: ttf_bold, fontSize: 20, color: azul_escuro_pdf);
    final texto_bold_16_azul_escuro = pw.TextStyle(font: ttf_bold, fontSize: 16, color: azul_escuro_pdf);
    final texto_bold_12_azul_escuro = pw.TextStyle(font: ttf_bold, fontSize: 10.8, color: azul_escuro_pdf);
    final texto_bold_12_azul_claro = pw.TextStyle(font: ttf_bold, fontSize: 10.8, color: azul_claro_pdf);
    final texto_20_azul_escuro = pw.TextStyle(font: ttf, fontSize: 20, color: azul_escuro_pdf);
    final texto_16_azul_escuro = pw.TextStyle(font: ttf, fontSize: 16, color: azul_escuro_pdf);
    final texto_12_azul_escuro = pw.TextStyle(font: ttf, fontSize: 10.8, color: azul_escuro_pdf);
    final texto_8_azul_escuro = pw.TextStyle(font: ttf, fontSize: 8, color: azul_escuro_pdf);
    final texto_bold_20_branco = pw.TextStyle(font: ttf_bold, fontSize: 20, color: branco_pdf);
    final texto_bold_16_branco = pw.TextStyle(font: ttf_bold, fontSize: 16, color: branco_pdf);
    final texto_bold_12_branco = pw.TextStyle(font: ttf_bold, fontSize: 10.8, color: branco_pdf);
    final texto_bold_16_azul_escuro_sublinhado = pw.TextStyle(font: ttf_bold, fontSize: 16, color: azul_escuro_pdf, decoration: pw.TextDecoration.underline);

    const tableHeadersCameras = ['AMBIENTE', 'ARMAZENAMENTO', 'LICENÇA', 'QUANTIDADE'];
    const tableHeadersComum = ['PLANO', 'QUANTIDADE'];
    const tableHeadersWifiBusiness = ['ITEM', 'LICENÇA', 'QUANTIDADE'];

    pdf.addPage(
        pw.MultiPage(
            header: (pw.Context context){
              return pw.Image(image_header, fit: pw.BoxFit.scaleDown);
            },
            footer: (pw.Context context){
              return pw.Image(image_bottom, fit: pw.BoxFit.scaleDown);
            },
            pageFormat: PdfPageFormat.a4,
            margin: pw.EdgeInsets.fromLTRB(32, 8, 32, 8),
            build: (context) => [
              pw.Align(
                alignment: pw.Alignment.topLeft,
                child: pw.Padding(
                  padding: pw.EdgeInsets.only(top: 16, bottom: 8),
                  child: pw.Container(
                    child: pw.Text("Para: " + controller.cliente_nome + "\nProponente: Unifique Telecomunicações S.A." + "\nCNPJ: 02.25.187/0001-08\nConsultor: " + controller.consultor_nome +"\nData: " + data_relatorio,
                        style: texto_12_azul_escuro,
                        textAlign: pw.TextAlign.left
                    ),
                  ),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.topCenter,
                child: pw.Padding(
                  padding: pw.EdgeInsets.only(top: 8, bottom: 8),
                  child: pw.Container(
                    child: pw.Text("PROPOSTA COMERCIAL",
                        style: texto_bold_16_azul_escuro_sublinhado,
                        textAlign: pw.TextAlign.center
                    ),
                  ),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.topCenter,
                child: pw.Padding(
                  padding: pw.EdgeInsets.only(top: 8, bottom: 16),
                  child: pw.Container(
                    child: pw.Text("APRESENTAÇÃO",
                      style: texto_bold_12_azul_escuro,
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.topLeft,
                child: pw.Padding(
                  padding: pw.EdgeInsets.only(top: 0, bottom: 16),
                  child: pw.Container(
                    child: pw.Text("      Oferecendo soluções de comunicação para empresas, residências e até mesmo governos, unimos tecnologia de última geração a um relacionamento que faz toda a diferença. Afinal, mais do que serviços de excelência, nossa missão é facilitar seu dia a dia.",
                      style: texto_12_azul_escuro,
                      textAlign: pw.TextAlign.justify,
                    ),
                  ),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.topLeft,
                child: pw.Padding(
                  padding: pw.EdgeInsets.only(top: 0, bottom: 16),
                  child: pw.Container(
                    child: pw.Text("     Movida pelo desejo de um relacionamento próximo com nossos clientes, estamos sempre inaugurando lojas por todo o estado. Ao estar mais perto de você, garantimos a qualidade de nossos serviços e valorizamos ainda mais o relacionamento.",
                      style: texto_12_azul_escuro,
                      textAlign: pw.TextAlign.justify,
                    ),
                  ),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.topLeft,
                child: pw.Padding(
                  padding: pw.EdgeInsets.only(top: 0, bottom: 32),
                  child: pw.Container(
                    child: pw.Text("      Transparência, comprometimento real, internet banda larga, telefonia digital, TV por assinatura, serviços de Data Center, telefonia fixa e Câmeras. Hoje oferecemos tudo isso e muito mais! E cada um de nossos esforços tem uma só direção: conectar você a tudo aquilo que mais ama.",
                      style: texto_12_azul_escuro,
                      textAlign: pw.TextAlign.justify,
                    ),
                  ),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.topCenter,
                child: pw.Padding(
                  padding: pw.EdgeInsets.only(top: 0, bottom: 8),
                  child: pw.Container(
                    child: pw.Text("PRINCIPAIS VANTAGENS",
                      style: texto_bold_12_azul_escuro,
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ),
              ),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Align(
                              alignment: pw.Alignment.topCenter,
                              child: pw.Padding(
                                padding: pw.EdgeInsets.only(top: 4, bottom: 4),
                                child: pw.Container(
                                  child: pw.Bullet(
                                    bulletColor: azul_claro_pdf,
                                    text: "Suporte técnico 24 horas",
                                    style: texto_12_azul_escuro,
                                    textAlign: pw.TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.topCenter,
                              child: pw.Padding(
                                padding: pw.EdgeInsets.only(top: 4, bottom: 4),
                                child: pw.Container(
                                  child: pw.Bullet(
                                    bulletColor: azul_claro_pdf,
                                    text: "Produto com qualidade e confiabilidade Unifique",
                                    style: texto_12_azul_escuro,
                                    textAlign: pw.TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.topCenter,
                              child: pw.Padding(
                                padding: pw.EdgeInsets.only(top: 4, bottom: 4),
                                child: pw.Bullet(
                                  bulletColor: azul_claro_pdf,
                                  text: "Armazenamento da imagem em nuvem em um Datacenter Tier 3 (disponibilidade mínima de 99.982% no ano)",
                                  style: texto_12_azul_escuro,
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.topCenter,
                              child: pw.Padding(
                                padding: pw.EdgeInsets.only(top: 4, bottom: 4),
                                child: pw.Container(
                                  child: pw.Bullet(
                                    bulletColor: azul_claro_pdf,
                                    text: "Aplicativo leve e intuitivo",
                                    style: texto_12_azul_escuro,
                                    textAlign: pw.TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),
                    pw.Expanded(
                        child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            crossAxisAlignment: pw.CrossAxisAlignment.center,
                            children: [
                              pw.Align(
                                alignment: pw.Alignment.topCenter,
                                child: pw.Padding(
                                  padding: pw.EdgeInsets.only(top: 4, bottom: 4),
                                  child: pw.Container(
                                    child: pw.Bullet(
                                      bulletColor: azul_claro_pdf,
                                      text: "Planos modulares que se adequam à necessidade do cliente",
                                      style: texto_12_azul_escuro,
                                      textAlign: pw.TextAlign.left,
                                    ),
                                  ),
                                ),
                              ),
                              pw.Align(
                                alignment: pw.Alignment.topCenter,
                                child: pw.Padding(
                                  padding: pw.EdgeInsets.only(top: 4, bottom: 4),
                                  child: pw.Container(
                                    child: pw.Bullet(
                                      bulletColor: azul_claro_pdf,
                                      text: "Compartilhamento das câmeras com quem desejar",
                                      style: texto_12_azul_escuro,
                                      textAlign: pw.TextAlign.left,
                                    ),
                                  ),
                                ),
                              ),
                              pw.Align(
                                alignment: pw.Alignment.topCenter,
                                child: pw.Padding(
                                  padding: pw.EdgeInsets.only(top: 4, bottom: 4),
                                  child: pw.Container(
                                    child: pw.Bullet(
                                      bulletColor: azul_claro_pdf,
                                      text: "Qualidade de imagem e acesso em tempo real",
                                      style: texto_12_azul_escuro,
                                      textAlign: pw.TextAlign.left,
                                    ),
                                  ),
                                ),
                              ),
                            ]
                        )
                    )
                  ]
              ),
              pw.NewPage(),
              pw.Align(
                alignment: pw.Alignment.topCenter,
                child: pw.Padding(
                  padding: pw.EdgeInsets.only(top: 8, bottom: 8),
                  child: pw.Container(
                    child: pw.Text("PROPOSTA",
                        style: texto_bold_16_azul_escuro,
                        textAlign: pw.TextAlign.center
                    ),
                  ),
                ),
              ),
              if(camera_lista.isNotEmpty)
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.topCenter,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.only(top: 8, bottom: 2),
                          child: pw.Container(
                            child: pw.Text("UNIFIQUE CÂMERAS",
                                style: texto_12_azul_escuro,
                                textAlign: pw.TextAlign.left
                            ),
                          ),
                        ),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.topCenter,
                        child: pw.Padding(
                            padding: pw.EdgeInsets.only(top: 0, bottom: 0),
                            child: pw.Container(
                                width: 500,
                                child: pw.Table.fromTextArray(
                                  border: null,
                                  columnWidths: {
                                    0: const pw.FractionColumnWidth(0.25),
                                    1: const pw.FractionColumnWidth(0.35),
                                    2: const pw.FractionColumnWidth(0.20),
                                    3: const pw.FractionColumnWidth(0.20),
                                  },
                                  headers: tableHeadersCameras,
                                  headerAlignment: pw.Alignment.centerLeft,
                                  data: List<List<dynamic>>.generate(
                                    camera_lista.length,
                                        (index) => <dynamic>[
                                      camera_lista[index].tipo,
                                      camera_lista[index].armaz,
                                      camera_lista[index].licen,
                                      camera_lista[index].qtd.toString(),
                                    ],
                                  ),
                                  cellStyle: texto_12_azul_escuro,
                                  headerStyle: texto_bold_12_branco,
                                  headerDecoration: const pw.BoxDecoration(
                                      color: azul_claro_pdf
                                  ),
                                  rowDecoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: azul_claro_pdf,
                                      width: 1,
                                    ),
                                  ),
                                  cellAlignment: pw.Alignment.centerLeft,
                                  cellAlignments: {0: pw.Alignment.centerLeft},
                                )
                            )
                        ),
                      ),
                    ]
                ),
              if(casa_lista.isNotEmpty)
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.topCenter,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.only(top: 8, bottom: 2),
                          child: pw.Container(
                            child: pw.Text("UNIFIQUE CASA INTELIGENTE",
                                style: texto_12_azul_escuro,
                                textAlign: pw.TextAlign.left
                            ),
                          ),
                        ),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.topCenter,
                        child: pw.Padding(
                            padding: pw.EdgeInsets.only(top: 0, bottom: 0),
                            child: pw.Container(
                                width: 500,
                                child: pw.Table.fromTextArray(
                                  border: null,
                                  columnWidths: {
                                    0: const pw.FractionColumnWidth(0.75),
                                    1: const pw.FractionColumnWidth(0.25),
                                  },
                                  headers: tableHeadersComum,
                                  headerAlignment: pw.Alignment.centerLeft,
                                  data: List<List<dynamic>>.generate(
                                    casa_lista.length,
                                        (index) => <dynamic>[
                                      casa_lista[index].plano,
                                      casa_lista[index].qtd.toString(),
                                    ],
                                  ),
                                  cellStyle: texto_12_azul_escuro,
                                  headerStyle: texto_bold_12_branco,
                                  headerDecoration: const pw.BoxDecoration(
                                      color: azul_claro_pdf
                                  ),
                                  rowDecoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: azul_claro_pdf,
                                      width: 1,
                                    ),
                                  ),
                                  cellAlignment: pw.Alignment.centerLeft,
                                  cellAlignments: {0: pw.Alignment.centerLeft},
                                )
                            )
                        ),
                      ),
                    ]
                ),
              if(combo_lista.isNotEmpty)
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.topCenter,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.only(top: 8, bottom: 2),
                          child: pw.Container(
                            child: pw.Text("COMBO UNIFIQUE",
                                style: texto_12_azul_escuro,
                                textAlign: pw.TextAlign.left
                            ),
                          ),
                        ),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.topCenter,
                        child: pw.Padding(
                            padding: pw.EdgeInsets.only(top: 0, bottom: 0),
                            child: pw.Container(
                                width: 500,
                                child: pw.Table.fromTextArray(
                                  border: null,
                                  columnWidths: {
                                    0: const pw.FractionColumnWidth(0.75),
                                    1: const pw.FractionColumnWidth(0.25),
                                  },
                                  headers: tableHeadersComum,
                                  headerAlignment: pw.Alignment.centerLeft,
                                  data: List<List<dynamic>>.generate(
                                    combo_lista.length,
                                        (index) => <dynamic>[
                                      combo_lista[index].plano,
                                      combo_lista[index].qtd.toString(),
                                    ],
                                  ),
                                  cellStyle: texto_12_azul_escuro,
                                  headerStyle: texto_bold_12_branco,
                                  headerDecoration: const pw.BoxDecoration(
                                      color: azul_claro_pdf
                                  ),
                                  rowDecoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: azul_claro_pdf,
                                      width: 1,
                                    ),
                                  ),
                                  cellAlignment: pw.Alignment.centerLeft,
                                  cellAlignments: {0: pw.Alignment.centerLeft},
                                )
                            )
                        ),
                      ),
                    ]
                ),
              if(internet_lista.isNotEmpty)
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.topCenter,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.only(top: 8, bottom: 2),
                          child: pw.Container(
                            child: pw.Text("FIBRA ÓPTICA UNIFIQUE",
                                style: texto_12_azul_escuro,
                                textAlign: pw.TextAlign.left
                            ),
                          ),
                        ),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.topCenter,
                        child: pw.Padding(
                            padding: pw.EdgeInsets.only(top: 0, bottom: 0),
                            child: pw.Container(
                                width: 500,
                                child: pw.Table.fromTextArray(
                                  border: null,
                                  columnWidths: {
                                    0: const pw.FractionColumnWidth(0.75),
                                    1: const pw.FractionColumnWidth(0.25),
                                  },
                                  headers: tableHeadersComum,
                                  headerAlignment: pw.Alignment.centerLeft,
                                  data: List<List<dynamic>>.generate(
                                    internet_lista.length,
                                        (index) => <dynamic>[
                                      internet_lista[index].plano,
                                      internet_lista[index].qtd.toString(),
                                    ],
                                  ),
                                  cellStyle: texto_12_azul_escuro,
                                  headerStyle: texto_bold_12_branco,
                                  headerDecoration: const pw.BoxDecoration(
                                      color: azul_claro_pdf
                                  ),
                                  rowDecoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: azul_claro_pdf,
                                      width: 1,
                                    ),
                                  ),
                                  cellAlignment: pw.Alignment.centerLeft,
                                  cellAlignments: {0: pw.Alignment.centerLeft},
                                )
                            )
                        ),
                      ),
                    ]
                ),
              if(mesh_lista.isNotEmpty)
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.topCenter,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.only(top: 8, bottom: 2),
                          child: pw.Container(
                            child: pw.Text("WIFI MESH UNIFIQUE",
                                style: texto_12_azul_escuro,
                                textAlign: pw.TextAlign.left
                            ),
                          ),
                        ),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.topCenter,
                        child: pw.Padding(
                            padding: pw.EdgeInsets.only(top: 0, bottom: 0),
                            child: pw.Container(
                                width: 500,
                                child: pw.Table.fromTextArray(
                                  border: null,
                                  columnWidths: {
                                    0: const pw.FractionColumnWidth(0.75),
                                    1: const pw.FractionColumnWidth(0.25),
                                  },
                                  headers: tableHeadersComum,
                                  headerAlignment: pw.Alignment.centerLeft,
                                  data: List<List<dynamic>>.generate(
                                    mesh_lista.length,
                                        (index) => <dynamic>[
                                      mesh_lista[index].tipo,
                                      mesh_lista[index].qtd.toString(),
                                    ],
                                  ),
                                  cellStyle: texto_12_azul_escuro,
                                  headerStyle: texto_bold_12_branco,
                                  headerDecoration: const pw.BoxDecoration(
                                      color: azul_claro_pdf
                                  ),
                                  rowDecoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: azul_claro_pdf,
                                      width: 1,
                                    ),
                                  ),
                                  cellAlignment: pw.Alignment.centerLeft,
                                  cellAlignments: {0: pw.Alignment.centerLeft},
                                )
                            )
                        ),
                      ),
                    ]
                ),
              if(telefone_lista.isNotEmpty)
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.topCenter,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.only(top: 8, bottom: 2),
                          child: pw.Container(
                            child: pw.Text("TELEFONIA FIXA UNIFIQUE",
                                style: texto_12_azul_escuro,
                                textAlign: pw.TextAlign.left
                            ),
                          ),
                        ),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.topCenter,
                        child: pw.Padding(
                            padding: pw.EdgeInsets.only(top: 0, bottom: 0),
                            child: pw.Container(
                                width: 500,
                                child: pw.Table.fromTextArray(
                                  border: null,
                                  columnWidths: {
                                    0: const pw.FractionColumnWidth(0.75),
                                    1: const pw.FractionColumnWidth(0.25),
                                  },
                                  headers: tableHeadersComum,
                                  headerAlignment: pw.Alignment.centerLeft,
                                  data: List<List<dynamic>>.generate(
                                    telefone_lista.length,
                                        (index) => <dynamic>[
                                      telefone_lista[index].plano,
                                      telefone_lista[index].qtd.toString(),
                                    ],
                                  ),
                                  cellStyle: texto_12_azul_escuro,
                                  headerStyle: texto_bold_12_branco,
                                  headerDecoration: const pw.BoxDecoration(
                                      color: azul_claro_pdf
                                  ),
                                  rowDecoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: azul_claro_pdf,
                                      width: 1,
                                    ),
                                  ),
                                  cellAlignment: pw.Alignment.centerLeft,
                                  cellAlignments: {0: pw.Alignment.centerLeft},
                                )
                            )
                        ),
                      ),
                    ]
                ),
              if(telemed_lista.isNotEmpty)
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.topCenter,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.only(top: 8, bottom: 2),
                          child: pw.Container(
                            child: pw.Text("UNIFIQUE TELEMEDICINA",
                                style: texto_12_azul_escuro,
                                textAlign: pw.TextAlign.left
                            ),
                          ),
                        ),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.topCenter,
                        child: pw.Padding(
                            padding: pw.EdgeInsets.only(top: 0, bottom: 0),
                            child: pw.Container(
                                width: 500,
                                child: pw.Table.fromTextArray(
                                  border: null,
                                  columnWidths: {
                                    0: const pw.FractionColumnWidth(0.75),
                                    1: const pw.FractionColumnWidth(0.25),
                                  },
                                  headers: tableHeadersComum,
                                  headerAlignment: pw.Alignment.centerLeft,
                                  data: List<List<dynamic>>.generate(
                                    telemed_lista.length,
                                        (index) => <dynamic>[
                                      telemed_lista[index].plano,
                                      telemed_lista[index].qtd.toString(),
                                    ],
                                  ),
                                  cellStyle: texto_12_azul_escuro,
                                  headerStyle: texto_bold_12_branco,
                                  headerDecoration: const pw.BoxDecoration(
                                      color: azul_claro_pdf
                                  ),
                                  rowDecoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: azul_claro_pdf,
                                      width: 1,
                                    ),
                                  ),
                                  cellAlignment: pw.Alignment.centerLeft,
                                  cellAlignments: {0: pw.Alignment.centerLeft},
                                )
                            )
                        ),
                      ),
                    ]
                ),
              if(tvhd_lista.isNotEmpty)
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.topCenter,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.only(top: 8, bottom: 2),
                          child: pw.Container(
                            child: pw.Text("TV HD UNIFIQUE",
                                style: texto_12_azul_escuro,
                                textAlign: pw.TextAlign.left
                            ),
                          ),
                        ),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.topCenter,
                        child: pw.Padding(
                            padding: pw.EdgeInsets.only(top: 0, bottom: 0),
                            child: pw.Container(
                                width: 500,
                                child: pw.Table.fromTextArray(
                                  border: null,
                                  columnWidths: {
                                    0: const pw.FractionColumnWidth(0.75),
                                    1: const pw.FractionColumnWidth(0.25),
                                  },
                                  headers: tableHeadersComum,
                                  headerAlignment: pw.Alignment.centerLeft,
                                  data: List<List<dynamic>>.generate(
                                    tvhd_lista.length,
                                        (index) => <dynamic>[
                                      tvhd_lista[index].plano,
                                      tvhd_lista[index].qtd.toString(),
                                    ],
                                  ),
                                  cellStyle: texto_12_azul_escuro,
                                  headerStyle: texto_bold_12_branco,
                                  headerDecoration: const pw.BoxDecoration(
                                      color: azul_claro_pdf
                                  ),
                                  rowDecoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: azul_claro_pdf,
                                      width: 1,
                                    ),
                                  ),
                                  cellAlignment: pw.Alignment.centerLeft,
                                  cellAlignments: {0: pw.Alignment.centerLeft},
                                )
                            )
                        ),
                      ),
                    ]
                ),
              if(wifibusi_lista.isNotEmpty)
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.topCenter,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.only(top: 8, bottom: 2),
                          child: pw.Container(
                            child: pw.Text("UNIFIQUE WIFI BUSINESS",
                                style: texto_12_azul_escuro,
                                textAlign: pw.TextAlign.left
                            ),
                          ),
                        ),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.topCenter,
                        child: pw.Padding(
                            padding: pw.EdgeInsets.only(top: 0, bottom: 0),
                            child: pw.Container(
                                width: 500,
                                child: pw.Table.fromTextArray(
                                  border: null,
                                  columnWidths: {
                                    0: const pw.FractionColumnWidth(0.50),
                                    1: const pw.FractionColumnWidth(0.30),
                                    2: const pw.FractionColumnWidth(0.20),
                                  },
                                  headers: tableHeadersWifiBusiness,
                                  headerAlignment: pw.Alignment.centerLeft,
                                  data: List<List<dynamic>>.generate(
                                    wifibusi_lista.length,
                                        (index) => <dynamic>[
                                      wifibusi_lista[index].linha_ap != "" ? wifibusi_lista[index].linha_ap : wifibusi_lista[index].link,
                                      wifibusi_lista[index].linha_ap != "" ? wifibusi_lista[index].licen : "-",
                                      wifibusi_lista[index].qtd.toString(),
                                    ],
                                  ),
                                  cellStyle: texto_12_azul_escuro,
                                  headerStyle: texto_bold_12_branco,
                                  headerDecoration: const pw.BoxDecoration(
                                      color: azul_claro_pdf
                                  ),
                                  rowDecoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: azul_claro_pdf,
                                      width: 1,
                                    ),
                                  ),
                                  cellAlignment: pw.Alignment.centerLeft,
                                  cellAlignments: {0: pw.Alignment.centerLeft},
                                )
                            )
                        ),
                      ),
                    ]
                ),

              pw.Align(
                alignment: pw.Alignment.topCenter,
                child: pw.Padding(
                  padding: pw.EdgeInsets.only(top: 16, bottom: 16),
                  child: pw.Container(
                    child: pw.Text("TOTALIZADORES",
                        style: texto_bold_16_azul_escuro,
                        textAlign: pw.TextAlign.center
                    ),
                  ),
                ),
              ),

              if(camera_lista.isNotEmpty)
                pw.Align(
                  alignment: pw.Alignment.topCenter,
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Container(
                            width: 500,
                            decoration: pw.BoxDecoration(
                              color: azul_claro_pdf,
                              border: pw.Border.all(
                                  color: azul_claro_pdf,
                                  width: 1.0
                              ),
                            ),
                            child: pw.Padding(
                              padding: pw.EdgeInsets.all(4),
                              child: pw.Text(
                                  "UNIFIQUE CÂMERAS",
                                  style: texto_bold_12_branco,
                                  textAlign: pw.TextAlign.left
                              ),
                            )
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.only(top: 0, bottom: 0),
                          child: pw.Container(
                              width: 500,
                              child: pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.center,
                                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                                  children: [
                                    pw.Container(
                                        width: 500/6,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              color: azul_claro_pdf,
                                              width: 1.0
                                          ),
                                        ),
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.all(4),
                                          child: pw.Text(
                                              "Adesão",
                                              style: texto_12_azul_escuro,
                                              textAlign: pw.TextAlign.left
                                          ),
                                        )
                                    ),
                                    pw.Container(
                                        width: 500/6,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              color: azul_claro_pdf,
                                              width: 1.0
                                          ),
                                        ),
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.all(4),
                                          child: pw.Text(
                                              NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.camera_valor_adesao_cf),
                                              style: texto_bold_12_azul_claro,
                                              textAlign: pw.TextAlign.left
                                          ),
                                        )
                                    ),
                                    pw.Container(
                                        width: 500/6,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              color: azul_claro_pdf,
                                              width: 1.0
                                          ),
                                        ),
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.all(4),
                                          child: pw.Text(
                                              "Mensal.",
                                              style: texto_12_azul_escuro,
                                              textAlign: pw.TextAlign.left
                                          ),
                                        )
                                    ),
                                    pw.Container(
                                        width: 500/6,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              color: azul_claro_pdf,
                                              width: 1.0
                                          ),
                                        ),
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.all(4),
                                          child: pw.Text(
                                              NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.camera_valor_mensal),
                                              style: texto_bold_12_azul_claro,
                                              textAlign: pw.TextAlign.left
                                          ),
                                        )
                                    ),
                                    pw.Container(
                                        width: 500/6,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              color: azul_claro_pdf,
                                              width: 1.0
                                          ),
                                        ),
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.all(4),
                                          child: pw.Text(
                                              "Sem Fidel.",
                                              style: texto_12_azul_escuro,
                                              textAlign: pw.TextAlign.left
                                          ),
                                        )
                                    ),
                                    pw.Container(
                                        width: 500/6,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              color: azul_claro_pdf,
                                              width: 1.0
                                          ),
                                        ),
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.all(4),
                                          child: pw.Text(
                                              NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.camera_valor_adesao_sf),
                                              style: texto_bold_12_azul_claro,
                                              textAlign: pw.TextAlign.left
                                          ),
                                        )
                                    ),
                                  ]
                              )
                          ),
                        ),
                      ]
                  ),
                ),
              if(casa_lista.isNotEmpty)
                pw.Align(
                  alignment: pw.Alignment.topCenter,
                  child:pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Container(
                            width: 500,
                            decoration: pw.BoxDecoration(
                              color: azul_claro_pdf,
                              border: pw.Border.all(
                                  color: azul_claro_pdf,
                                  width: 1.0
                              ),
                            ),
                            child: pw.Padding(
                              padding: pw.EdgeInsets.all(4),
                              child: pw.Text(
                                  "UNIFIQUE CASA INTELIGENTE",
                                  style: texto_bold_12_branco,
                                  textAlign: pw.TextAlign.left
                              ),
                            )
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.only(top: 0, bottom: 0),
                          child: pw.Container(
                              width: 500,
                              child: pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.center,
                                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                                  children: [
                                    pw.Container(
                                        width: 500/6,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              color: azul_claro_pdf,
                                              width: 1.0
                                          ),
                                        ),
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.all(4),
                                          child: pw.Text(
                                              "Adesão",
                                              style: texto_12_azul_escuro,
                                              textAlign: pw.TextAlign.left
                                          ),
                                        )
                                    ),
                                    pw.Container(
                                        width: 500/6,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              color: azul_claro_pdf,
                                              width: 1.0
                                          ),
                                        ),
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.all(4),
                                          child: pw.Text(
                                              NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.casa_valor_adesao_cf),
                                              style: texto_bold_12_azul_claro,
                                              textAlign: pw.TextAlign.left
                                          ),
                                        )
                                    ),
                                    pw.Container(
                                        width: 500/6,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              color: azul_claro_pdf,
                                              width: 1.0
                                          ),
                                        ),
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.all(4),
                                          child: pw.Text(
                                              "Mensal.",
                                              style: texto_12_azul_escuro,
                                              textAlign: pw.TextAlign.left
                                          ),
                                        )
                                    ),
                                    pw.Container(
                                        width: 500/6,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              color: azul_claro_pdf,
                                              width: 1.0
                                          ),
                                        ),
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.all(4),
                                          child: pw.Text(
                                              NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.casa_valor_mensal),
                                              style: texto_bold_12_azul_claro,
                                              textAlign: pw.TextAlign.left
                                          ),
                                        )
                                    ),
                                    pw.Container(
                                        width: 500/6,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              color: azul_claro_pdf,
                                              width: 1.0
                                          ),
                                        ),
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.all(4),
                                          child: pw.Text(
                                              "Sem Fidel.",
                                              style: texto_12_azul_escuro,
                                              textAlign: pw.TextAlign.left
                                          ),
                                        )
                                    ),
                                    pw.Container(
                                        width: 500/6,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              color: azul_claro_pdf,
                                              width: 1.0
                                          ),
                                        ),
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.all(4),
                                          child: pw.Text(
                                              NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.casa_valor_adesao_sf),
                                              style: texto_bold_12_azul_claro,
                                              textAlign: pw.TextAlign.left
                                          ),
                                        )
                                    ),
                                  ]
                              )
                          ),
                        ),
                      ]
                  ),
                ),
              if(combo_lista.isNotEmpty)
                pw.Align(
                  alignment: pw.Alignment.topCenter,
                  child:pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Container(
                            width: 500,
                            decoration: pw.BoxDecoration(
                              color: azul_claro_pdf,
                              border: pw.Border.all(
                                  color: azul_claro_pdf,
                                  width: 1.0
                              ),
                            ),
                            child: pw.Padding(
                              padding: pw.EdgeInsets.all(4),
                              child: pw.Text(
                                  "COMBO UNIFIQUE",
                                  style: texto_bold_12_branco,
                                  textAlign: pw.TextAlign.left
                              ),
                            )
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.only(top: 0, bottom: 0),
                          child: pw.Container(
                              width: 500,
                              child: pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.center,
                                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                                  children: [
                                    pw.Container(
                                        width: 500/6,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              color: azul_claro_pdf,
                                              width: 1.0
                                          ),
                                        ),
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.all(4),
                                          child: pw.Text(
                                              "Adesão",
                                              style: texto_12_azul_escuro,
                                              textAlign: pw.TextAlign.left
                                          ),
                                        )
                                    ),
                                    pw.Container(
                                        width: 500/6,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              color: azul_claro_pdf,
                                              width: 1.0
                                          ),
                                        ),
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.all(4),
                                          child: pw.Text(
                                              NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.combo_valor_adesao_cf),
                                              style: texto_bold_12_azul_claro,
                                              textAlign: pw.TextAlign.left
                                          ),
                                        )
                                    ),
                                    pw.Container(
                                        width: 500/6,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              color: azul_claro_pdf,
                                              width: 1.0
                                          ),
                                        ),
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.all(4),
                                          child: pw.Text(
                                              "Mensal.",
                                              style: texto_12_azul_escuro,
                                              textAlign: pw.TextAlign.left
                                          ),
                                        )
                                    ),
                                    pw.Container(
                                        width: 500/6,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              color: azul_claro_pdf,
                                              width: 1.0
                                          ),
                                        ),
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.all(4),
                                          child: pw.Text(
                                              NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.combo_valor_mensal),
                                              style: texto_bold_12_azul_claro,
                                              textAlign: pw.TextAlign.left
                                          ),
                                        )
                                    ),
                                    pw.Container(
                                        width: 500/6,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              color: azul_claro_pdf,
                                              width: 1.0
                                          ),
                                        ),
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.all(4),
                                          child: pw.Text(
                                              "Sem Fidel.",
                                              style: texto_12_azul_escuro,
                                              textAlign: pw.TextAlign.left
                                          ),
                                        )
                                    ),
                                    pw.Container(
                                        width: 500/6,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              color: azul_claro_pdf,
                                              width: 1.0
                                          ),
                                        ),
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.all(4),
                                          child: pw.Text(
                                              NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.combo_valor_adesao_sf),
                                              style: texto_bold_12_azul_claro,
                                              textAlign: pw.TextAlign.left
                                          ),
                                        )
                                    ),
                                  ]
                              )
                          ),
                        ),
                      ]
                  ),
                ),
              if(internet_lista.isNotEmpty)
                pw.Align(
                    alignment: pw.Alignment.topCenter,
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Container(
                              width: 500,
                              decoration: pw.BoxDecoration(
                                color: azul_claro_pdf,
                                border: pw.Border.all(
                                    color: azul_claro_pdf,
                                    width: 1.0
                                ),
                              ),
                              child: pw.Padding(
                                padding: pw.EdgeInsets.all(4),
                                child: pw.Text(
                                    "FIBRA ÓPTICA UNIFIQUE",
                                    style: texto_bold_12_branco,
                                    textAlign: pw.TextAlign.left
                                ),
                              )
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.only(top: 0, bottom: 0),
                            child: pw.Container(
                                width: 500,
                                child: pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.center,
                                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                "Adesão",
                                                style: texto_12_azul_escuro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.internet_valor_adesao_cf),
                                                style: texto_bold_12_azul_claro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                "Mensal.",
                                                style: texto_12_azul_escuro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.internet_valor_mensal),
                                                style: texto_bold_12_azul_claro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                "Sem Fidel.",
                                                style: texto_12_azul_escuro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.internet_valor_adesao_sf),
                                                style: texto_bold_12_azul_claro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                    ]
                                )
                            ),
                          ),
                        ]
                    ),
                ),
              if(mesh_lista.isNotEmpty)
                pw.Align(
                    alignment: pw.Alignment.topCenter,
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Container(
                              width: 500,
                              decoration: pw.BoxDecoration(
                                color: azul_claro_pdf,
                                border: pw.Border.all(
                                    color: azul_claro_pdf,
                                    width: 1.0
                                ),
                              ),
                              child: pw.Padding(
                                padding: pw.EdgeInsets.all(4),
                                child: pw.Text(
                                    "WIFI MESH UNIFIQUE",
                                    style: texto_bold_12_branco,
                                    textAlign: pw.TextAlign.left
                                ),
                              )
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.only(top: 0, bottom: 0),
                            child: pw.Container(
                                width: 500,
                                child: pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.center,
                                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                "Adesão",
                                                style: texto_12_azul_escuro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.mesh_valor_adesao_cf),
                                                style: texto_bold_12_azul_claro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                "Mensal.",
                                                style: texto_12_azul_escuro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.mesh_valor_mensal),
                                                style: texto_bold_12_azul_claro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                "Sem Fidel.",
                                                style: texto_12_azul_escuro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.mesh_valor_adesao_sf),
                                                style: texto_bold_12_azul_claro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                    ]
                                )
                            ),
                          ),
                        ]
                    ),
                ),
              if(telefone_lista.isNotEmpty)
                pw.Align(
                    alignment: pw.Alignment.topCenter,
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Container(
                              width: 500,
                              decoration: pw.BoxDecoration(
                                color: azul_claro_pdf,
                                border: pw.Border.all(
                                    color: azul_claro_pdf,
                                    width: 1.0
                                ),
                              ),
                              child: pw.Padding(
                                padding: pw.EdgeInsets.all(4),
                                child: pw.Text(
                                    "TELEFONIA FIXA UNIFIQUE",
                                    style: texto_bold_12_branco,
                                    textAlign: pw.TextAlign.left
                                ),
                              )
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.only(top: 0, bottom: 0),
                            child: pw.Container(
                                width: 500,
                                child: pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.center,
                                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                "Adesão",
                                                style: texto_12_azul_escuro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.telef_valor_adesao_cf),
                                                style: texto_bold_12_azul_claro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                "Mensal.",
                                                style: texto_12_azul_escuro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.telef_valor_mensal),
                                                style: texto_bold_12_azul_claro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                "Sem Fidel.",
                                                style: texto_12_azul_escuro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.telef_valor_adesao_sf),
                                                style: texto_bold_12_azul_claro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                    ]
                                )
                            ),
                          ),
                        ]
                    ),
                ),
              if(telemed_lista.isNotEmpty)
                pw.Align(
                    alignment: pw.Alignment.topCenter,
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Container(
                              width: 500,
                              decoration: pw.BoxDecoration(
                                color: azul_claro_pdf,
                                border: pw.Border.all(
                                    color: azul_claro_pdf,
                                    width: 1.0
                                ),
                              ),
                              child: pw.Padding(
                                padding: pw.EdgeInsets.all(4),
                                child: pw.Text(
                                    "UNIFIQUE TELEMEDICINA",
                                    style: texto_bold_12_branco,
                                    textAlign: pw.TextAlign.left
                                ),
                              )
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.only(top: 0, bottom: 0),
                            child: pw.Container(
                                width: 500,
                                child: pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.center,
                                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                "Adesão",
                                                style: texto_12_azul_escuro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.telemed_valor_adesao_cf),
                                                style: texto_bold_12_azul_claro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                "Mensal.",
                                                style: texto_12_azul_escuro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.telemed_valor_mensal),
                                                style: texto_bold_12_azul_claro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                "Sem Fidel.",
                                                style: texto_12_azul_escuro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.telemed_valor_adesao_sf),
                                                style: texto_bold_12_azul_claro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                    ]
                                )
                            ),
                          ),
                        ]
                    ),
                ),
              if(tvhd_lista.isNotEmpty)
                pw.Align(
                    alignment: pw.Alignment.topCenter,
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Container(
                              width: 500,
                              decoration: pw.BoxDecoration(
                                color: azul_claro_pdf,
                                border: pw.Border.all(
                                    color: azul_claro_pdf,
                                    width: 1.0
                                ),
                              ),
                              child: pw.Padding(
                                padding: pw.EdgeInsets.all(4),
                                child: pw.Text(
                                    "TV HD UNIFIQUE",
                                    style: texto_bold_12_branco,
                                    textAlign: pw.TextAlign.left
                                ),
                              )
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.only(top: 0, bottom: 0),
                            child: pw.Container(
                                width: 500,
                                child: pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.center,
                                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                "Adesão",
                                                style: texto_12_azul_escuro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.tvhd_valor_adesao_cf),
                                                style: texto_bold_12_azul_claro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                "Mensal.",
                                                style: texto_12_azul_escuro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.tvhd_valor_mensal),
                                                style: texto_bold_12_azul_claro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                "Sem Fidel.",
                                                style: texto_12_azul_escuro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.tvhd_valor_adesao_sf),
                                                style: texto_bold_12_azul_claro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                    ]
                                )
                            ),
                          ),
                        ]
                    ),
                ),
              if(wifibusi_lista.isNotEmpty)
                pw.Align(
                    alignment: pw.Alignment.topCenter,
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Container(
                              width: 500,
                              decoration: pw.BoxDecoration(
                                color: azul_claro_pdf,
                                border: pw.Border.all(
                                    color: azul_claro_pdf,
                                    width: 1.0
                                ),
                              ),
                              child: pw.Padding(
                                padding: pw.EdgeInsets.all(4),
                                child: pw.Text(
                                    "UNIFIQUE WIFI BUSINESS",
                                    style: texto_bold_12_branco,
                                    textAlign: pw.TextAlign.left
                                ),
                              )
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.only(top: 0, bottom: 0),
                            child: pw.Container(
                                width: 500,
                                child: pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.center,
                                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                "Adesão",
                                                style: texto_12_azul_escuro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.wifibusi_adesao_24_meses),
                                                style: texto_bold_12_azul_claro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                "Mensal.",
                                                style: texto_12_azul_escuro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.wifibusi_valor_mensal),
                                                style: texto_bold_12_azul_claro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                "Sem Fidel.",
                                                style: texto_12_azul_escuro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                      pw.Container(
                                          width: 500/6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: azul_claro_pdf,
                                                width: 1.0
                                            ),
                                          ),
                                          child: pw.Padding(
                                            padding: pw.EdgeInsets.all(4),
                                            child: pw.Text(
                                                NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.wifibusi_valor_adesao_sf),
                                                style: texto_bold_12_azul_claro,
                                                textAlign: pw.TextAlign.left
                                            ),
                                          )
                                      ),
                                    ]
                                )
                            ),
                          ),
                        ]
                    ),
                ),

              pw.Align(
                alignment: pw.Alignment.topCenter,
                child: pw.Padding(
                  padding: pw.EdgeInsets.only(top: 16, bottom: 16),
                  child: pw.Container(
                    child: pw.Text("VALOR TOTAL DA PROPOSTA",
                        style: texto_bold_16_azul_escuro,
                        textAlign: pw.TextAlign.center
                    ),
                  ),
                ),
              ),

              pw.Align(
                alignment: pw.Alignment.topCenter,
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.zero,
                        child: pw.Container(
                            width: 250,
                            child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Container(
                                      width: 250,
                                      decoration: pw.BoxDecoration(
                                        color: azul_claro_pdf,
                                        border: pw.Border.all(
                                            color: azul_claro_pdf,
                                            width: 1.0
                                        ),
                                      ),
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.all(4),
                                        child: pw.Text(
                                            "Adesão Inicial",
                                            style: texto_bold_12_branco,
                                            textAlign: pw.TextAlign.left
                                        ),
                                      )
                                  ),
                                  pw.Container(
                                      width: 250,
                                      decoration: pw.BoxDecoration(
                                        color: azul_claro_pdf,
                                        border: pw.Border.all(
                                            color: azul_claro_pdf,
                                            width: 1.0
                                        ),
                                      ),
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.all(4),
                                        child: pw.Text(
                                            "Adesão da Proposta",
                                            style: texto_bold_12_branco,
                                            textAlign: pw.TextAlign.left
                                        ),
                                      )
                                  ),
                                  pw.Container(
                                      width: 250,
                                      decoration: pw.BoxDecoration(
                                        color: azul_claro_pdf,
                                        border: pw.Border.all(
                                            color: azul_claro_pdf,
                                            width: 1.0
                                        ),
                                      ),
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.all(4),
                                        child: pw.Text(
                                            "Mensalidade",
                                            style: texto_bold_12_branco,
                                            textAlign: pw.TextAlign.left
                                        ),
                                      )
                                  ),
                                  pw.Container(
                                      width: 250,
                                      decoration: pw.BoxDecoration(
                                        color: azul_claro_pdf,
                                        border: pw.Border.all(
                                            color: azul_claro_pdf,
                                            width: 1.0
                                        ),
                                      ),
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.all(4),
                                        child: pw.Text(
                                            "Adesão Sem Fidelidade",
                                            style: texto_bold_12_branco,
                                            textAlign: pw.TextAlign.left
                                        ),
                                      )
                                  ),
                                  pw.Container(
                                      width: 250,
                                      decoration: pw.BoxDecoration(
                                        color: azul_claro_pdf,
                                        border: pw.Border.all(
                                            color: azul_claro_pdf,
                                            width: 1.0
                                        ),
                                      ),
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.all(4),
                                        child: pw.Text(
                                            "Proposta válida para o CPF/CNPJ",
                                            style: texto_bold_12_branco,
                                            textAlign: pw.TextAlign.left
                                        ),
                                      )
                                  ),
                                  pw.Container(
                                      width: 250,
                                      decoration: pw.BoxDecoration(
                                        color: azul_claro_pdf,
                                        border: pw.Border.all(
                                            color: azul_claro_pdf,
                                            width: 1.0
                                        ),
                                      ),
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.all(4),
                                        child: pw.Text(
                                            "Validade da Proposta",
                                            style: texto_bold_12_branco,
                                            textAlign: pw.TextAlign.left
                                        ),
                                      )
                                  ),
                                ]
                            )
                        ),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.zero,
                        child: pw.Container(
                            width: 250,
                            child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Container(
                                      width: 250,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            color: azul_claro_pdf,
                                            width: 1.0
                                        ),
                                      ),
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.all(4),
                                        child: pw.Text(
                                            NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.adesao_com_fidelidade.value),
                                            style: texto_bold_12_azul_claro,
                                            textAlign: pw.TextAlign.left
                                        ),
                                      )
                                  ),
                                  pw.Container(
                                      width: 250,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            color: azul_claro_pdf,
                                            width: 1.0
                                        ),
                                      ),
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.all(4),
                                        child: pw.Text(
                                            NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.adesao_com_desconto),
                                            style: texto_bold_12_azul_claro,
                                            textAlign: pw.TextAlign.left
                                        ),
                                      )
                                  ),
                                  pw.Container(
                                      width: 250,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            color: azul_claro_pdf,
                                            width: 1.0
                                        ),
                                      ),
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.all(4),
                                        child: pw.Text(
                                            NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.mensalidade.value),
                                            style: texto_bold_12_azul_claro,
                                            textAlign: pw.TextAlign.left
                                        ),
                                      )
                                  ),
                                  pw.Container(
                                      width: 250,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            color: azul_claro_pdf,
                                            width: 1.0
                                        ),
                                      ),
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.all(4),
                                        child: pw.Text(
                                            NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.adesao_sem_fidelidade.value),
                                            style: texto_bold_12_azul_claro,
                                            textAlign: pw.TextAlign.left
                                        ),
                                      )
                                  ),
                                  pw.Container(
                                      width: 250,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            color: azul_claro_pdf,
                                            width: 1.0
                                        ),
                                      ),
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.all(4),
                                        child: pw.Text(
                                            controller.cliente_cpf_cnpj,
                                            style: texto_bold_12_azul_claro,
                                            textAlign: pw.TextAlign.left
                                        ),
                                      )
                                  ),
                                  pw.Container(
                                      width: 250,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            color: azul_claro_pdf,
                                            width: 1.0
                                        ),
                                      ),
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.all(4),
                                        child: pw.Text(
                                            "10 dias",
                                            style: texto_bold_12_azul_claro,
                                            textAlign: pw.TextAlign.left
                                        ),
                                      )
                                  ),
                                ]
                            )
                        ),
                      ),
                    ]
                ),
              ),
              pw.SizedBox(height: 8),
              if(camera_lista.isNotEmpty)
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.only(top: 8, bottom: 4),
                          child: pw.Container(
                            child: pw.Text("*Preços do Unifique Câmeras para contrato com 24 Meses de fidelidade",
                              style: texto_12_azul_escuro,
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.only(top: 4, bottom: 4),
                          child: pw.Container(
                            child: pw.Text("*Orçamento do Unifique Câmeras não incluí serviços adicionais como configuração de servidores, equipamentos de rede, computadores, etc.",
                              style: texto_12_azul_escuro,
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.only(top: 4, bottom: 8),
                          child: pw.Container(
                            child: pw.Text("*Câmera exposta tem um custo adicional de adesão de R\$ 249,99. A câmera exposta é a câmera que ficará afastada da casa/estabelecimento, portanto demandará materiais específicos para a instalação suportar as adversidades climáticas.",
                              style: texto_12_azul_escuro,
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
              if(casa_lista.isNotEmpty)
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.only(top: 8, bottom: 4),
                          child: pw.Container(
                            child: pw.Text("*Preços do Unifique Casa Inteligente para contrato com 12 Meses de fidelidade",
                              style: texto_12_azul_escuro,
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
              if(combo_lista.isNotEmpty)
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      if(controller.tipo_cliente == 0)
                        pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Padding(
                            padding: pw.EdgeInsets.only(top: 8, bottom: 4),
                            child: pw.Container(
                              child: pw.Text("*Preços de Combos para contrato com 12 Meses de fidelidade.",
                                style: texto_12_azul_escuro,
                                textAlign: pw.TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      if(controller.tipo_cliente == 1)
                        pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Padding(
                            padding: pw.EdgeInsets.only(top: 8, bottom: 4),
                            child: pw.Container(
                              child: pw.Text("*Preços para contrato com 24 Meses de fidelidade. É possível também contratar com 12 meses de fidelidade, onde o valor de adesão será de "
                                  + NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.combo_adesao_12_meses.value)
                                  + " e a mensalidade será de "
                                  + NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.combo_mensalidade_total_12_meses.value)
                                  + ". Se desejar alterar a fidelidade, informe ao consultor no momento da contratação",
                                style: texto_12_azul_escuro,
                                textAlign: pw.TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                    ]
                ),
              if(internet_lista.isNotEmpty)
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      if(controller.tipo_cliente == 0)
                        pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Padding(
                            padding: pw.EdgeInsets.only(top: 8, bottom: 4),
                            child: pw.Container(
                              child: pw.Text("*Preços de planos de Fibra Óptica para contrato com 12 Meses de fidelidade.",
                                style: texto_12_azul_escuro,
                                textAlign: pw.TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      if(controller.tipo_cliente == 1)
                        pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Padding(
                            padding: pw.EdgeInsets.only(top: 8, bottom: 4),
                            child: pw.Container(
                              child: pw.Text("*Preços para contrato com 24 Meses de fidelidade. É possível também contratar com 12 meses de fidelidade, onde o valor de adesão será de "
                                  + NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.internet_adesao_12_meses.value)
                                  + " e a mensalidade será de "
                                  + NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.internet_mensalidade_total_12_meses.value)
                                  + ". Se desejar alterar a fidelidade, informe ao consultor no momento da contratação",
                                style: texto_12_azul_escuro,
                                textAlign: pw.TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                    ]
                ),
              if(mesh_lista.isNotEmpty)
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.only(top: 8, bottom: 4),
                          child: pw.Container(
                            child: pw.Text("*A instalação do equipamento de Wifi Mesh possui limite de 20m de cabo. Se ultrapassado a quantidade máxima, será cobrado R\$2,00 por metro adicional.",
                              style: texto_12_azul_escuro,
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.only(top: 8, bottom: 4),
                          child: pw.Container(
                            child: pw.Text("*Preços de Wifi Mesh  para contrato com 12 Meses de fidelidade.",
                              style: texto_12_azul_escuro,
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
              if(telefone_lista.isNotEmpty)
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.only(top: 8, bottom: 4),
                          child: pw.Container(
                            child: pw.Text("*Preços de planos de Telefonia Fixa para contrato com 12 Meses de fidelidade.",
                              style: texto_12_azul_escuro,
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.only(top: 8, bottom: 4),
                          child: pw.Container(
                            child: pw.Text("*O cliente deverá solicitar o desbloqueio das chamadas a cobrar em seu telefone fixo, caso desejar. As chamadas a cobrar só poderão ser recebidas de ligações locais.",
                              style: texto_12_azul_escuro,
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
              if(telemed_lista.isNotEmpty)
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.only(top: 8, bottom: 4),
                          child: pw.Container(
                            child: pw.Text("*Preços de planos de Telemedicina para contrato com 12 Meses de fidelidade.",
                              style: texto_12_azul_escuro,
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
              if(tvhd_lista.isNotEmpty)
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.only(top: 8, bottom: 4),
                          child: pw.Container(
                            child: pw.Text("*Preços de planos TV HD para contrato com 12 Meses de fidelidade.",
                              style: texto_12_azul_escuro,
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
              if(wifibusi_lista.isNotEmpty)
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.only(top: 8, bottom: 4),
                          child: pw.Container(
                            child: pw.Text("*Preços para contrato com 24 Meses de fidelidade. É possível também contratar com 12 meses de fidelidade, onde o valor de adesão será de "
                                + NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.wifibusi_adesao_12_meses)
                                + ". Se desejar alterar a fidelidade, informe ao consultor no momento da contratação",
                              style: texto_12_azul_escuro,
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
              if(internet_lista.isNotEmpty || tvhd_lista.isNotEmpty || combo_lista.isNotEmpty || telefone_lista.isNotEmpty || mesh_lista.isNotEmpty)
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.only(top: 8, bottom: 4),
                          child: pw.Container(
                            child: pw.Text("*O prazo de instalação para os planos residenciais pode variar de acordo com a região do cliente e, ainda, com as condições climáticas. Em média, o prazo é de 20 dias úteis.",
                              style: texto_12_azul_escuro,
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ]
                ),

              pw.Align(
                alignment: pw.Alignment.topLeft,
                child: pw.Padding(
                  padding: pw.EdgeInsets.only(top: 32, bottom: 32),
                  child: pw.Container(
                    child: pw.Text("Confidencialidade: as partes concordam que todas as informações, valores e dados revelados e comunicados através desta proposta deverão ser mantidos em total e irrestrita confidencialidade, sob pena de multas e outras cobranças posteriormente fixadas, caso ocorram danos decorrentes de mau uso das informações compartilhadas.",
                      style: texto_8_azul_escuro,
                      textAlign: pw.TextAlign.justify,
                    ),
                  ),
                ),
              ),

            ]
        )
    );
    String data_formatada = DateFormat('yyyyMMdd-kkmmss').format(now);
    String nome_pdf = "proposta-" + data_formatada + "-" + controller.cliente_nome.toUpperCase();
    await Printing.sharePdf(bytes: await pdf.save(), filename: nome_pdf+'.pdf');
    //pdf_gerado = File.fromRawPath(await pdf.save());

    /*final output = await getTemporaryDirectory();
    final file = File('${output.path}/' + nome_pdf);
    pdf_gerado = await file.writeAsBytes(await pdf.save());*/
  }
}