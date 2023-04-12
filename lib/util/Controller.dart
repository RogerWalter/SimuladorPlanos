import 'package:get/get.dart';
import 'package:simulador_unifique/model/CasaInteligente.dart';
import 'package:simulador_unifique/model/Combo.dart';
import 'package:simulador_unifique/model/ItemMostrar.dart';
import 'package:simulador_unifique/model/Mesh.dart';
import 'package:intl/intl.dart';
import 'package:simulador_unifique/model/Telefone.dart';
import 'package:simulador_unifique/model/Telemedicina.dart';
import 'package:simulador_unifique/model/TvHd.dart';
import 'package:simulador_unifique/model/ValoresPJ.dart';
import 'package:simulador_unifique/model/WifiBusiness.dart';
import '../model/Camera.dart';
import '../model/Internet.dart';
import '../model/Produto.dart';
import '../model/ValoresPF.dart';

class Controller extends GetxController{

  var opacidade_layout = 0.0.obs;
  //##################TELA-LOGIN##################
  var visibilidade_senha = true.obs;

  altera_visib_senha() {
    visibilidade_senha.value = !visibilidade_senha.value;
  }

  //##################CLASSE-CLIENTE##################
  var classe_cliente = 9.obs;

  altera_classe_cliente(int novo) async{
    classe_cliente.value = novo;
    if(opacidade_layout.value == 0.0){
      opacidade_layout.value = 1.0;
    }
    recalcular_total();
  }

  //##################TIPO-CLIENTE##################
  String cliente_cpf_cnpj = "";
  String cliente_nome = "";
  String consultor_nome = "";
  var cliente_score = true.obs; //retornado pela consulta de score e usado para definir as tabelas de cálculo
  var cliente_unifique = false.obs; //se é cliente Unifique ou Não
  var tipo_cliente = 0.obs; //0 - pessoa física | 1 - pessoa jurídica
  var desc_tipo_cliente = "Pessoa Física".obs;
  var aviso_alteracao_tipo_cliente = 0.obs; //usado para verificar se o diálogo de aviso já foi mostrado - 0 = NÃO MOSTRADO - 1 = MOSTRADO

  alterar_tipo_cliente(int novo) {
    lista_indice_selecionado = -1;
    seleciona_produto(Produto(99, "", "assets/icone-casa-azul.svg", "assets/icone-casa-branco.svg", "assets/icone-casa-azul-claro.svg", "assets/logo-bem-vindo.png", 0));
    mostrar_limpar_plano();
    recalcular_total();
    alterar_aviso_alteracao_tipo_cliente(0);
    tipo_cliente.value = novo;
    alterar_lista_produtos();
    if(novo == 0)
      desc_tipo_cliente.value = "Pessoa Física";
    else
      desc_tipo_cliente.value = "Pessoa Jurídica";
  }

  alterar_dados_proposta(String cliente, String consultor){
    cliente_nome = cliente;
    consultor_nome = consultor;
  }

  alterar_aviso_alteracao_tipo_cliente(int novo){
    aviso_alteracao_tipo_cliente.value = novo;
  }

  alterar_cliente_unifique(bool novo){
    cliente_unifique.value = novo;
  }

  alterar_cliente_score(bool novo){
    cliente_score.value = novo;
  }



  //##################LISTA-PRODUTOS##################
  var lista_produtos = <Produto>[//lista com os produtos do menu lateral
  Produto(0, "Casa Inteligente", "assets/icone-casa-azul.svg", "assets/icone-casa-branco.svg", "assets/icone-casa-azul-claro.svg", "assets/logo-casa.png", 0),
  Produto(1, "Câmeras", "assets/icone-camera-azul.svg","assets/icone-camera-branco.svg", "assets/icone-camera-azul-claro.svg", "assets/logo-cameras.png", 0),
  Produto(2, "Mesh", "assets/icone-mesh-azul.svg", "assets/icone-mesh-branco.svg", "assets/icone-mesh-azul-claro.svg","assets/logo-mesh.png", 0),
  //Produto(3, "Wifi Business", "assets/icone-wifi-business-azul.svg", "assets/icone-wifi-business-branco.svg", "assets/icone-wifi-business-azul-claro.svg","assets/logo-wifi-business.png", 2),
  Produto(4, "Telemedicina", "assets/icone-telemedicina-azul.svg", "assets/icone-telemedicina-branco.svg", "assets/icone-telemedicina-azul-claro.svg","assets/logo-telemedicina.png", 0),
  Produto(5, "Internet", "assets/icone-internet-azul.svg", "assets/icone-internet-branco.svg", "assets/icone-internet-azul-claro.svg","assets/logo-internet.png", 0),
  Produto(6, "TV HD", "assets/icone-tv-azul.svg", "assets/icone-tv-branco.svg", "assets/icone-tv-azul-claro.svg","assets/logo-tv.png", 0),
  Produto(7, "Telefonia", "assets/icone-telefonia-azul.svg", "assets/icone-telefonia-branco.svg", "assets/icone-telefonia-azul-claro.svg","assets/logo-telefonia.png", 0),
  Produto(8, "Combo", "assets/icone-combo-azul.svg", "assets/icone-combo-branco.svg", "assets/icone-combo-azul-claro.svg","assets/logo-combo.png", 0)
  ].obs;
  var lista_init = <Produto>[
    Produto(0, "Casa Inteligente", "assets/icone-casa-azul.svg", "assets/icone-casa-branco.svg", "assets/icone-casa-azul-claro.svg", "assets/logo-casa.png", 0),
    Produto(1, "Câmeras", "assets/icone-camera-azul.svg","assets/icone-camera-branco.svg", "assets/icone-camera-azul-claro.svg", "assets/logo-cameras.png", 0),
    Produto(2, "Mesh", "assets/icone-mesh-azul.svg", "assets/icone-mesh-branco.svg", "assets/icone-mesh-azul-claro.svg","assets/logo-mesh.png", 0),
    Produto(3, "Wifi Business", "assets/icone-wifi-business-azul.svg", "assets/icone-wifi-business-branco.svg", "assets/icone-wifi-business-azul-claro.svg","assets/logo-wifi-business.png", 2),
    Produto(4, "Telemedicina", "assets/icone-telemedicina-azul.svg", "assets/icone-telemedicina-branco.svg", "assets/icone-telemedicina-azul-claro.svg","assets/logo-telemedicina.png", 0),
    Produto(5, "Internet", "assets/icone-internet-azul.svg", "assets/icone-internet-branco.svg", "assets/icone-internet-azul-claro.svg","assets/logo-internet.png", 0),
    Produto(6, "TV HD", "assets/icone-tv-azul.svg", "assets/icone-tv-branco.svg", "assets/icone-tv-azul-claro.svg","assets/logo-tv.png", 0),
    Produto(7, "Telefonia", "assets/icone-telefonia-azul.svg", "assets/icone-telefonia-branco.svg", "assets/icone-telefonia-azul-claro.svg","assets/logo-telefonia.png", 0),
    Produto(8, "Combo", "assets/icone-combo-azul.svg", "assets/icone-combo-branco.svg", "assets/icone-combo-azul-claro.svg","assets/logo-combo.png", 0)
  ].obs;


  var lista_indice_selecionado = -1.obs;
  var lista_produtos_pf = <Produto>[].obs; //lista com os produtos voltados a pessoa fisica
  var lista_produtos_pj = <Produto>[].obs; //lista com os produtos voltados a pessoa juridica
  var hover_color_produtos = false
      .obs; //usado para setar a cor do hover no menu lateral
  int hover_color_produtos_index = -1
      .obs; //usado para identificar qual indice devemos alterar a cor
  var produto_selecionado = Produto(99, "", "assets/icone-casa-azul.svg",
      "assets/icone-casa-branco.svg", "assets/icone-casa-azul-claro.svg", "assets/logo-bem-vindo.png", 0).obs;

  alterar_hover_color_produtos(bool novo, int index) {
    hover_color_produtos.value = novo;
    hover_color_produtos_index = index;
  }

  alterar_indice_selecionado_produtos(int index) {
    lista_indice_selecionado = index;
  }

  seleciona_produto(var novo) {
    produto_selecionado.value = novo;
  }

  alterar_lista_produtos(){
    lista_produtos.clear();
    for(Produto item in lista_init){
      if((item.tipo_cliente == 0 || item.tipo_cliente == 1) && tipo_cliente.value == 0)
        lista_produtos.add(item);
      if((item.tipo_cliente == 0 || item.tipo_cliente == 2) && tipo_cliente.value == 1)
        lista_produtos.add(item);
    }
  }

  //##################LISTA-MOSTRAR##################
  var lista_mostrar = <ItemMostrar>[].obs;

  mostrar_adicionar(ItemMostrar novo) {
    lista_mostrar.add(novo);
  }

  mostrar_remover_item(ItemMostrar item) {
    int indice = -1;
    try{
      indice = lista_mostrar.indexOf(item);
      lista_mostrar.removeAt(indice);
    }catch(e){
      return;
    }

    if (item.grupo == "Câmeras") {
      Camera remover = Camera();
      remover.tipo = item.info_1;
      remover.armaz = item.info_2;
      remover.licen = item.info_3;
      remover.valor_mensalidade = double.parse(item.info_4.replaceRange(0, 2, "").replaceAll('.', '').replaceAll(',', '.'));
      int index = lista_camera.indexWhere((e) =>
                                                  e.tipo == remover.tipo &&
                                                  e.armaz == remover.armaz &&
                                                  e.licen == remover.licen &&
                                                  e.valor_mensalidade == remover.valor_mensalidade);
      lista_camera.removeAt(index);
      lista_camera.sort((a, b) => a.tipo.compareTo(b.tipo));
    }

    if (item.grupo == "Mesh") {
      Mesh remover = Mesh();
      remover.tipo = item.info_1;
      remover.valor_mensalidade = double.parse(item.info_2.replaceRange(0, 2, "").replaceAll('.', '').replaceAll(',', '.'));
      int index = lista_mesh.indexWhere((e) =>
          e.tipo == remover.tipo &&
          e.valor_mensalidade == remover.valor_mensalidade);
      lista_mesh.removeAt(index);
      lista_mesh.sort((a, b) => a.tipo.compareTo(b.tipo));
    }

    if (item.grupo == "Wifi Business") {
      WifiBusiness remover = WifiBusiness();
      if(item.info_3 == ""){//é link de internet
        remover.link = item.info_1.replaceAll("Link de ", "");
        remover.valor_mensalidade = double.parse(item.info_2.replaceRange(0, 2, "").replaceAll('.', '').replaceAll(',', '.'));
        int index = lista_wifibusiness.indexWhere((e) =>
            e.link == remover.link &&
            e.valor_mensalidade == remover.valor_mensalidade);
        lista_wifibusiness.removeAt(index);
        lista_wifibusiness.sort((a, b) => a.linha_ap.compareTo(b.linha_ap));
      }
      else{//é ap
        remover.linha_ap = item.info_1;
        remover.licen = item.info_2;
        remover.valor_mensalidade = double.parse(item.info_3.replaceRange(0, 2, "").replaceAll('.', '').replaceAll(',', '.'));
        int index = lista_wifibusiness.indexWhere((e) =>
            e.linha_ap == remover.linha_ap &&
            e.licen == remover.licen &&
            e.valor_mensalidade == remover.valor_mensalidade);
        lista_wifibusiness.removeAt(index);
        lista_wifibusiness.sort((a, b) => a.linha_ap.compareTo(b.linha_ap));
      }
    }
    if (item.grupo == "Telemedicina") {
      Telemedicina remover = Telemedicina();
      remover.plano = item.info_1;
      remover.valor_mensalidade = double.parse(item.info_2.replaceRange(0, 2, "").replaceAll('.', '').replaceAll(',', '.'));
      int index = lista_telemedicina.indexWhere((e) =>
          e.plano == remover.plano &&
          e.valor_mensalidade == remover.valor_mensalidade);
      lista_telemedicina.removeAt(index);
      lista_telemedicina.sort((a, b) => a.plano.compareTo(b.plano));
    }

    if (item.grupo == "Internet") {
      Internet remover = Internet();
      remover.plano = item.info_1;
      int index = lista_internet.indexWhere((e) => e.plano == remover.plano);
      lista_internet.removeAt(index);
      lista_internet.sort((a, b) => a.plano.compareTo(b.plano));
    }

    if (item.grupo == "TV HD") {
      TvHd remover = TvHd();
      remover.plano = item.info_1;
      int index = lista_tvhd.indexWhere((e) => e.plano == remover.plano);
      lista_tvhd.removeAt(index);
      lista_tvhd.sort((a, b) => a.plano.compareTo(b.plano));
    }

    if (item.grupo == "Telefonia") {
      Telefone remover = Telefone();
      remover.plano = item.info_1;
      int index = lista_telef.indexWhere((e) => e.plano == remover.plano);
      lista_telef.removeAt(index);
      lista_telef.sort((a, b) => a.plano.compareTo(b.plano));
    }

    if (item.grupo == "Combo") {
      Combo remover = Combo();
      remover.plano = item.info_1;
      int index = lista_combo.indexWhere((e) => e.plano == remover.plano);
      lista_combo.removeAt(index);
      lista_combo.sort((a, b) => a.plano.compareTo(b.plano));
    }

    if (item.grupo == "Casa Inteligente") {
      CasaInteligente remover = CasaInteligente();
      remover.plano = item.info_1;
      int index = lista_casa.indexWhere((e) => e.plano == remover.plano);
      lista_casa.removeAt(index);
      lista_casa.sort((a, b) => a.plano.compareTo(b.plano));
    }

    recalcular_total();
  }

  mostrar_remover_categoria() {
    String grupo = produto_selecionado.value.descricao;
    if (grupo == "Câmeras")
      camera_limpar_lista();
    if (grupo == "Mesh")
      mesh_limpar_lista();
    if (grupo == "Wifi Business")
      wifibusi_limpar_lista();
    if (grupo == "Telemedicina")
      telemed_limpar_lista();
    if (grupo == "Internet")
      internet_limpar_lista();
    if (grupo == "TV HD")
      tvhd_limpar_lista();
    if (grupo == "Telefonia")
      telef_limpar_lista();
    if (grupo == "Combo")
      combo_limpar_lista();
    if (grupo == "Casa Inteligente")
      casa_limpar_lista();
    lista_mostrar.removeWhere((element) => element.grupo == grupo);
  }

  mostrar_limpar_plano() {
    lista_camera.clear();
    lista_mesh.clear();
    lista_wifibusiness.clear();
    lista_telemedicina.clear();
    lista_mostrar.clear();
    lista_internet.clear();
    lista_tvhd.clear();
    lista_telef.clear();
    lista_combo.clear();
    lista_casa.clear();
    recalcular_total();
    seleciona_produto(Produto(99, "", "assets/icone-casa-azul.svg", "assets/icone-casa-branco.svg", "assets/icone-casa-azul-claro.svg", "assets/logo-bem-vindo.png", 0));
    lista_indice_selecionado = -1;
  }

  //##################LISTA-CAMERAS##################
  num camera_valor_adesao_cf = 0.0;
  num camera_valor_adesao_sf = 0.0;
  num camera_valor_mensal = 0.0;
  var camera_qtd_adicionar = 1.obs;
  var lista_camera = <Camera>[].obs;
  var camera_tipo_selecionado_dropdown = "".obs;
  var camera_armz_selecionado_dropdown = "".obs;
  var camera_lice_selecionado_dropdown = "".obs;

  camera_limpar_dialogo(){
    camera_tipo_selecionado_dropdown.value = "";
    camera_armz_selecionado_dropdown.value = "";
    camera_lice_selecionado_dropdown.value = "";
    camera_qtd_adicionar.value = 1;
  }

  camera_bt_add_qtd() {
    if (camera_qtd_adicionar < 99)
      camera_qtd_adicionar++;
  }

  camera_bt_rem_qtd() {
    if (camera_qtd_adicionar > 1)
      camera_qtd_adicionar--;
  }

  camera_rst_qtd() {
    camera_qtd_adicionar.value = 1;
  }

  camera_adicionar(Camera nova) {
    lista_camera.add(nova);
  }

  camera_seleciona_tipo(var tipo) {
    camera_tipo_selecionado_dropdown.value = tipo;
  }

  camera_seleciona_armz(var armz) {
    camera_armz_selecionado_dropdown.value = armz;
  }

  camera_seleciona_lice(var lice) {
    camera_lice_selecionado_dropdown.value = lice;
  }

  camera_remover(int indice) {
    lista_camera.removeAt(indice);
    recalcular_total();
  }

  camera_limpar_lista() {
    lista_camera.clear();
    recalcular_total();
  }

  //##################LISTA-MESH##################
  num mesh_valor_adesao_cf = 0.0;
  num mesh_valor_adesao_sf = 0.0;
  num mesh_valor_mensal = 0.0;
  var mesh_tipo_selecionado_dropdown = "".obs;
  var mesh_qtd_adicionar = 1.obs;
  var lista_mesh = <Mesh>[].obs;

  mesh_seleciona_tipo(var tipo) {
    mesh_tipo_selecionado_dropdown.value = tipo;
  }

  mesh_limpar_dialogo(){
    mesh_tipo_selecionado_dropdown.value = "";
    mesh_qtd_adicionar.value = 1;
  }

  mesh_bt_add_qtd() {
    if (mesh_qtd_adicionar < 99)
      mesh_qtd_adicionar++;
  }

  mesh_bt_rem_qtd() {
    if (mesh_qtd_adicionar > 1)
      mesh_qtd_adicionar--;
  }

  mesh_rst_qtd() {
    mesh_qtd_adicionar.value = 1;
  }

  mesh_adicionar(Mesh novo) {
    lista_mesh.add(novo);
  }

  mesh_remover(int indice) {
    lista_mesh.removeAt(indice);
    recalcular_total();
  }

  mesh_limpar_lista() {
    lista_mesh.clear();
    recalcular_total();
  }

  //##################LISTA-WIFI-BUSINESS##################
  num wifibusi_adesao_24_meses = 0.0;
  num wifibusi_valor_adesao_sf = 0.0;
  num wifibusi_valor_mensal = 0.0;
  var lista_wifibusiness = <WifiBusiness>[].obs;
  num wifibusi_adesao_12_meses = 0.0;
  var wifibusi_linha_ap_selecionado_dropdown = "".obs;
  var wifibusi_licen_selecionado_dropdown = "".obs;
  var wifibusi_link_selecionado_dropdown = "".obs;
  var wifibusi_qtd_adicionar = 1.obs;

  wifibusi_seleciona_linha_ap(var tipo) {
    wifibusi_linha_ap_selecionado_dropdown.value = tipo;
  }
  wifibusi_seleciona_licen(var tipo) {
    wifibusi_licen_selecionado_dropdown.value = tipo;
  }
  wifibusi_seleciona_link(var tipo) {
    wifibusi_link_selecionado_dropdown.value = tipo;
  }

  wifibusi_limpar_dialogo(){
    wifibusi_linha_ap_selecionado_dropdown.value = "";
    wifibusi_licen_selecionado_dropdown.value = "";
    wifibusi_link_selecionado_dropdown.value = "";
    wifibusi_qtd_adicionar.value = 1;
  }

  wifibusi_bt_add_qtd() {
    if (wifibusi_qtd_adicionar < 99)
      wifibusi_qtd_adicionar++;
  }

  wifibusi_bt_rem_qtd() {
    if (wifibusi_qtd_adicionar > 1)
      wifibusi_qtd_adicionar--;
  }

  wifibusi_rst_qtd() {
    wifibusi_qtd_adicionar.value = 1;
  }

  wifibusi_adicionar(WifiBusiness novo) {
    lista_wifibusiness.add(novo);
  }

  wifibusi_remover(int indice) {
    lista_wifibusiness.removeAt(indice);
    recalcular_total();
  }

  wifibusi_limpar_lista() {
    lista_wifibusiness.clear();
    recalcular_total();
  }

  //##################LISTA-TELEMEDICINA##################
  num telemed_valor_adesao_cf = 0.0;
  num telemed_valor_adesao_sf = 0.0;
  num telemed_valor_mensal = 0.0;
  var lista_telemedicina = <Telemedicina>[].obs;
  var telemed_plano_selecionado_dropdown = "".obs;
  var telemed_cli_unifique_selecionado_dropdown = "".obs;
  var telemed_qtd_adicionar = 1.obs;

  telemed_seleciona_plano(var tipo) {
    telemed_plano_selecionado_dropdown.value = tipo;
  }

  telemed_seleciona_cli_unifique(var tipo) {
    telemed_cli_unifique_selecionado_dropdown.value = tipo;
  }

  telemed_limpar_dialogo(){
    telemed_plano_selecionado_dropdown.value = "";
    telemed_cli_unifique_selecionado_dropdown.value = "";
    telemed_qtd_adicionar.value = 1;
  }

  telemed_bt_add_qtd() {
    if (telemed_qtd_adicionar < 99)
      telemed_qtd_adicionar++;
  }

  telemed_bt_rem_qtd() {
    if (telemed_qtd_adicionar > 1)
      telemed_qtd_adicionar--;
  }

  telemed_rst_qtd() {
    telemed_qtd_adicionar.value = 1;
  }

  telemed_adicionar(Telemedicina novo) {
    lista_telemedicina.add(novo);
  }

  telemed_remover(int indice) {
    lista_telemedicina.removeAt(indice);
    recalcular_total();
  }

  telemed_limpar_lista() {
    lista_telemedicina.clear();
    recalcular_total();
  }

  //##################LISTA-INTERNET##################
  num internet_valor_adesao_cf = 0.0;
  num internet_valor_adesao_sf = 0.0;
  num internet_valor_mensal = 0.0;
  var internet_adesao_12_meses = 0.0.obs;
  var internet_mensalidade_total_12_meses = 0.0.obs;
  var lista_internet = <Internet>[].obs;
  var internet_plano_selecionado_dropdown = "".obs;
  var internet_upg_selecionado_dropdown = "Não".obs;
  var internet_fidelidade_selecionado_dropdown = "".obs;
  var internet_qtd_adicionar = 1.obs;

  internet_seleciona_plano(var tipo) {
    internet_plano_selecionado_dropdown.value = tipo;
  }

  internet_seleciona_upgrade(var tipo) {
    internet_upg_selecionado_dropdown.value = tipo;
  }

  internet_fidelidade_plano(var tipo) {
    internet_fidelidade_selecionado_dropdown.value = tipo;
  }


  internet_limpar_dialogo(){
    internet_plano_selecionado_dropdown.value = "";
    internet_upg_selecionado_dropdown.value = "Não";
    internet_qtd_adicionar.value = 1;
  }

  internet_bt_add_qtd() {
    if (internet_qtd_adicionar < 99)
      internet_qtd_adicionar++;
  }

  internet_bt_rem_qtd() {
    if (internet_qtd_adicionar > 1)
      internet_qtd_adicionar--;
  }

  internet_rst_qtd() {
    internet_qtd_adicionar.value = 1;
  }

  internet_adicionar(Internet novo) {
    lista_internet.add(novo);
  }

  internet_remover(int indice) {
    lista_internet.removeAt(indice);
    recalcular_total();
  }

  internet_limpar_lista() {
    lista_internet.clear();
    recalcular_total();
  }

  //##################LISTA-TV##################
  num tvhd_valor_adesao_cf = 0.0;
  num tvhd_valor_adesao_sf = 0.0;
  num tvhd_valor_mensal = 0.0;
  var lista_tvhd = <TvHd>[].obs;
  var tvhd_plano_selecionado_dropdown = "".obs;
  var tvhd_cli_unifique_selecionado_dropdown = "".obs;
  var tvhd_qtd_adicionar = 1.obs;

  tvhd_seleciona_plano(var tipo) {
    tvhd_plano_selecionado_dropdown.value = tipo;
  }

  tvhd_seleciona_cliente(var tipo) {
    tvhd_cli_unifique_selecionado_dropdown.value = tipo;
  }


  tvhd_limpar_dialogo(){
    tvhd_plano_selecionado_dropdown.value = "";
    tvhd_cli_unifique_selecionado_dropdown.value = "";
    tvhd_qtd_adicionar.value = 1;
  }

  tvhd_bt_add_qtd() {
    if (tvhd_qtd_adicionar < 99)
      tvhd_qtd_adicionar++;
  }

  tvhd_bt_rem_qtd() {
    if (tvhd_qtd_adicionar > 1)
      tvhd_qtd_adicionar--;
  }

  tvhd_rst_qtd() {
    tvhd_qtd_adicionar.value = 1;
  }

  tvhd_adicionar(TvHd novo) {
    lista_tvhd.add(novo);
  }

  tvhd_remover(int indice) {
    lista_tvhd.removeAt(indice);
    recalcular_total();
  }

  tvhd_limpar_lista() {
    lista_tvhd.clear();
    recalcular_total();
  }

  //##################LISTA-TELEFONE##################
  num telef_valor_adesao_cf = 0.0;
  num telef_valor_adesao_sf = 0.0;
  num telef_valor_mensal = 0.0;
  var lista_telef = <Telefone>[].obs;
  var telef_plano_selecionado_dropdown = "".obs;
  var telef_cli_unifique_selecionado_dropdown = "".obs;
  var telef_qtd_adicionar = 1.obs;

  telef_seleciona_plano(var tipo) {
    telef_plano_selecionado_dropdown.value = tipo;
  }

  telef_seleciona_cliente(var tipo) {
    telef_cli_unifique_selecionado_dropdown.value = tipo;
  }


  telef_limpar_dialogo(){
    telef_plano_selecionado_dropdown.value = "";
    telef_cli_unifique_selecionado_dropdown.value = "";
    telef_qtd_adicionar.value = 1;
  }

  telef_bt_add_qtd() {
    if (telef_qtd_adicionar < 99)
      telef_qtd_adicionar++;
  }

  telef_bt_rem_qtd() {
    if (telef_qtd_adicionar > 1)
      telef_qtd_adicionar--;
  }

  telef_rst_qtd() {
    telef_qtd_adicionar.value = 1;
  }

  telef_adicionar(Telefone novo) {
    lista_telef.add(novo);
  }

  telef_remover(int indice) {
    lista_telef.removeAt(indice);
    recalcular_total();
  }

  telef_limpar_lista() {
    lista_telef.clear();
    recalcular_total();
  }

  //##################LISTA-COMBO##################
  num combo_valor_adesao_cf = 0.0;
  num combo_valor_adesao_sf = 0.0;
  num combo_valor_mensal = 0.0;
  var combo_adesao_12_meses = 0.0.obs;
  var combo_mensalidade_total_12_meses = 0.0.obs;
  var lista_combo = <Combo>[].obs;
  var combo_inte_selecionado_dropdown = "".obs;
  var combo_tvhd_selecionado_dropdown = "".obs;
  var combo_telf_selecionado_dropdown = "".obs;

  combo_seleciona_internet(var tipo) {
    combo_inte_selecionado_dropdown.value = tipo;
  }

  combo_seleciona_tvhd(var tipo) {
    combo_tvhd_selecionado_dropdown.value = tipo;
  }

  combo_seleciona_telefone(var tipo) {
    combo_telf_selecionado_dropdown.value = tipo;
  }


  combo_limpar_dialogo(){
    combo_inte_selecionado_dropdown.value = "";
    combo_tvhd_selecionado_dropdown.value = "";
    combo_telf_selecionado_dropdown.value = "";
  }

  combo_adicionar(Combo novo) {
    lista_combo.add(novo);
  }

  combo_remover(int indice) {
    lista_combo.removeAt(indice);
    recalcular_total();
  }

  combo_limpar_lista() {
    lista_combo.clear();
    recalcular_total();
  }

  //##################LISTA-CASA-INTELIGENTE##################
  num casa_valor_adesao_cf = 0.0;
  num casa_valor_adesao_sf = 0.0;
  num casa_valor_mensal = 0.0;
  var casa_plano_selecionado_dropdown = "".obs;
  var casa_qtd_adicionar = 1.obs;
  var lista_casa = <CasaInteligente>[].obs;

  casa_seleciona_plano(var plano) {
    casa_plano_selecionado_dropdown.value = plano;
  }

  casa_limpar_dialogo(){
    casa_plano_selecionado_dropdown.value = "";
    casa_qtd_adicionar.value = 1;
  }

  casa_bt_add_qtd() {
    if (casa_qtd_adicionar < 99)
      casa_qtd_adicionar++;
  }

  casa_bt_rem_qtd() {
    if (casa_qtd_adicionar > 1)
      casa_qtd_adicionar--;
  }

  casa_rst_qtd() {
    casa_qtd_adicionar.value = 1;
  }

  casa_adicionar(CasaInteligente novo) {
    lista_casa.add(novo);
  }

  casa_remover(int indice) {
    lista_casa.removeAt(indice);
    recalcular_total();
  }

  casa_limpar_lista() {
    lista_casa.clear();
    recalcular_total();
  }

  //##################TOTALIZADORES##################
  var adesao_com_fidelidade = 0.0.obs;
  var adesao_sem_fidelidade = 0.0.obs;
  var mensalidade = 0.0.obs;
  num adesao_com_desconto = 0.0;
  var nome_cliente = "".obs;

  alterar_nome_cliente(String novo) {
    nome_cliente.value = novo;
  }

  var nome_consultor = "".obs;

  alterar_nome_consultor(String novo) {
    nome_consultor.value = novo;
  }

  recalcular_total() {
    if(tipo_cliente == 0){
      verificar_combo();
    }

    if(lista_casa.isNotEmpty && lista_casa.length > 1){
      verificar_casa_inteligente();
    }

    lista_mostrar.clear();

    adesao_com_fidelidade.value = 0;
    adesao_sem_fidelidade.value = 0;
    mensalidade.value = 0;

    List<num> adesoes_com_fidelidade = [];
    List<num> adesoes_com_fidelidade_24 = [];
    List<num> adesoes_sem_fidelidade = [];
    List<num> mensalidades = [];

    //calculo casa
    if (lista_casa.length > 0) {
      CasaInteligente calcular = CasaInteligente();
      var retorno_casa = calcular.calcular_total_casa(lista_casa, classe_cliente.value, tipo_cliente.value);
      lista_casa = calcular.lista_casa_retorno;
      adesoes_com_fidelidade.add(retorno_casa[0]);
      adesoes_sem_fidelidade.add(retorno_casa[1]);
      mensalidades.add(retorno_casa[2]);
      casa_valor_adesao_cf = retorno_casa[0];
      casa_valor_adesao_sf = retorno_casa[1];
      casa_valor_mensal = retorno_casa[2];
      //atualizar a lista_mostrar
      lista_casa.sort((a, b) => a.plano.compareTo(b.plano));
      for (CasaInteligente item in lista_casa) {
        ItemMostrar novo = ItemMostrar(
            "assets/icone-casa-branco.svg",
            item.plano,
            "",
            "",
            NumberFormat.simpleCurrency(locale: 'pt_BR').format(item.mensalidade),
            "Casa Inteligente");
        mostrar_adicionar(novo);
      }
    }
    //calculo câmeras
    if (lista_camera.length > 0) {
      Camera calcular = Camera();
      var retorno_cameras = calcular.calcular_total_cameras(lista_camera, classe_cliente.value, tipo_cliente.value);
      lista_camera = calcular.lista_camera_retorno;
      adesoes_com_fidelidade.add(retorno_cameras[0]);
      adesoes_sem_fidelidade.add(retorno_cameras[1]);
      mensalidades.add(retorno_cameras[2]);
      camera_valor_adesao_cf = retorno_cameras[0];
      camera_valor_adesao_sf = retorno_cameras[1];
      camera_valor_mensal = retorno_cameras[2];
      //atualizar a lista_mostrar
      lista_camera.sort((a, b) => a.tipo.compareTo(b.tipo));
      for (Camera item in lista_camera) {
        ItemMostrar novo = ItemMostrar(
            "assets/icone-camera-branco.svg",
            item.tipo,
            item.armaz,
            item.licen,
            NumberFormat.simpleCurrency(locale: 'pt_BR').format(item.valor_mensalidade),
            "Câmeras");
        mostrar_adicionar(novo);
      }
    }
    //calculo mesh
    if (lista_mesh.length > 0) {
      Mesh calcular = Mesh();
      var retorno_mesh = calcular.calcular_total_mesh(lista_mesh, classe_cliente.value, tipo_cliente.value);
      lista_mesh = calcular.lista_mesh_retorno;
      adesoes_com_fidelidade.add(retorno_mesh[0]);
      adesoes_sem_fidelidade.add(retorno_mesh[1]);
      mensalidades.add(retorno_mesh[2]);
      mesh_valor_adesao_cf = retorno_mesh[0];
      mesh_valor_adesao_sf = retorno_mesh[1];
      mesh_valor_mensal = retorno_mesh[2];
      //atualizar a lista_mostrar
      lista_mesh.sort((a, b) => a.tipo.compareTo(b.tipo));
      for (Mesh item in lista_mesh) {
        ItemMostrar novo = ItemMostrar(
            "assets/icone-mesh-branco.svg",
            item.tipo,
            NumberFormat.simpleCurrency(locale: 'pt_BR').format(item.valor_mensalidade),
            "",
            "",
            "Mesh");
        mostrar_adicionar(novo);
      }
    }
    //calculo Wifi Business
    if (lista_wifibusiness.length > 0) {
      WifiBusiness calcular = WifiBusiness();
      var retorno_wifibusi = calcular.calcular_total_wifi_business(lista_wifibusiness, classe_cliente.value, tipo_cliente.value);
      lista_wifibusiness = calcular.lista_wifibusi_retorno;
      adesoes_com_fidelidade.add(retorno_wifibusi[0]);
      adesoes_sem_fidelidade.add(retorno_wifibusi[1]);
      mensalidades.add(retorno_wifibusi[2]);
      wifibusi_adesao_12_meses = retorno_wifibusi[3];
      wifibusi_adesao_24_meses = retorno_wifibusi[0];
      wifibusi_valor_adesao_sf = retorno_wifibusi[1];
      wifibusi_valor_mensal = retorno_wifibusi[2];
      lista_wifibusiness.sort((a, b) => a.linha_ap.compareTo(b.linha_ap)); //apenas para fins estéticos
      //atualizar a lista_mostrar
      lista_wifibusiness.sort((a, b) => a.linha_ap.compareTo(b.linha_ap));
      for (WifiBusiness item in lista_wifibusiness) {
        if(item.linha_ap != ""){ //é o registro de um AP
          ItemMostrar novo = ItemMostrar(
              "assets/icone-wifi-business-branco.svg",
              item.linha_ap,
              item.licen,
              NumberFormat.simpleCurrency(locale: 'pt_BR').format(item.valor_mensalidade),
              "",
              "Wifi Business");
          mostrar_adicionar(novo);
        }
        if(item.linha_ap == ""){ //é o registro do link de internet no produto wifi-business
          ItemMostrar novo = ItemMostrar(
              "assets/icone-wifi-business-branco.svg",
              "Link de " + item.link,
              NumberFormat.simpleCurrency(locale: 'pt_BR').format(item.valor_mensalidade),
              "",
              "",
              "Wifi Business");
          mostrar_adicionar(novo);
        }
      }
    }
    //calculo Telemedicina
    if (lista_telemedicina.length > 0) {
      Telemedicina calcular = Telemedicina();
      var retorno_telemedicina = calcular.calcular_total_telemedicina(lista_telemedicina, classe_cliente.value, tipo_cliente.value);
      lista_telemedicina = calcular.lista_telemedicina_retorno;
      adesoes_com_fidelidade.add(retorno_telemedicina[0]);
      adesoes_sem_fidelidade.add(retorno_telemedicina[1]);
      mensalidades.add(retorno_telemedicina[2]);
      telemed_valor_adesao_cf = retorno_telemedicina[0];
      telemed_valor_adesao_sf = retorno_telemedicina[1];
      telemed_valor_mensal = retorno_telemedicina[2];
      //atualizar a lista_mostrar
      lista_telemedicina.sort((a, b) => a.plano.compareTo(b.plano));
      if(tipo_cliente == 0){
        for (Telemedicina item in lista_telemedicina) {
          ItemMostrar novo = ItemMostrar(
              "assets/icone-telemedicina-branco.svg",
              item.plano,
              NumberFormat.simpleCurrency(locale: 'pt_BR').format(item.valor_mensalidade),
              item.cliente_unifique == "Sim" ? "Cliente Unifique" : "Não é Cliente",
              "",
              "Telemedicina");
          mostrar_adicionar(novo);
        }
      }
      else{
        for (Telemedicina item in lista_telemedicina) {
          ItemMostrar novo = ItemMostrar(
              "assets/icone-telemedicina-branco.svg",
              item.plano,
              NumberFormat.simpleCurrency(locale: 'pt_BR').format(item.valor_mensalidade),
              "",
              "",
              "Telemedicina");
          mostrar_adicionar(novo);
        }
      }
    }
    //calculo Internet
    if (lista_internet.length > 0) {
      Internet calcular = Internet();
      var retorno_internet = calcular.calcular_total_internet(lista_internet, classe_cliente.value, tipo_cliente.value, cliente_score.value, cliente_unifique.value);
      lista_internet = calcular.lista_internet_retorno;
      adesoes_com_fidelidade.add(retorno_internet[0]);
      adesoes_sem_fidelidade.add(retorno_internet[1]);
      mensalidades.add(retorno_internet[2]);
      internet_valor_adesao_cf = retorno_internet[0];
      internet_valor_adesao_sf = retorno_internet[1];
      internet_valor_mensal = retorno_internet[2];
      //atualizar a lista_mostrar
      lista_internet.sort((a, b) => a.plano.compareTo(b.plano));
      if(tipo_cliente == 0){
        for (Internet item in lista_internet) {
          ItemMostrar novo = ItemMostrar(
              "assets/icone-internet-branco.svg",
              item.plano,
              item.mensal_fid_24 > 0.0
                  ? NumberFormat.simpleCurrency(locale: 'pt_BR').format(item.mensal_fid_24)
                  : "Adesão de " + NumberFormat.simpleCurrency(locale: 'pt_BR').format(ValoresPF().internet_upg_eqpto.adesao_cf),
              "",
              "",
              "Internet");
          mostrar_adicionar(novo);
        }
      }
      else{
        for (Internet item in lista_internet) {
          internet_adesao_12_meses.value = retorno_internet[3];
          internet_mensalidade_total_12_meses.value = retorno_internet[4];
          ItemMostrar novo = ItemMostrar(
              "assets/icone-internet-branco.svg",
              item.plano,
              item.mensal_fid_24 > 0.0
                  ? NumberFormat.simpleCurrency(locale: 'pt_BR').format(item.mensal_fid_24) + " (2 anos)"
                  : "Adesão de " + NumberFormat.simpleCurrency(locale: 'pt_BR').format(ValoresPJ().internet_upg_eqpto.adesao_cf_24),
              item.mensal_fid_12 > 0.0
                  ? NumberFormat.simpleCurrency(locale: 'pt_BR').format(item.mensal_fid_12) + " (1 ano)"
                  : "",
              "",
              "Internet");
          mostrar_adicionar(novo);
        }
      }
    }
    //calculo TV HD
    if (lista_tvhd.length > 0) {
      TvHd calcular = TvHd();
      var retorno_tvhd = calcular.calcular_total_tvhd(lista_tvhd, classe_cliente.value, tipo_cliente.value);
      lista_tvhd = calcular.lista_tvhd_retorno;
      adesoes_com_fidelidade.add(retorno_tvhd[0]);
      adesoes_sem_fidelidade.add(retorno_tvhd[1]);
      mensalidades.add(retorno_tvhd[2]);
      tvhd_valor_adesao_cf = retorno_tvhd[0];
      tvhd_valor_adesao_sf = retorno_tvhd[1];
      tvhd_valor_mensal = retorno_tvhd[2];
      //atualizar a lista_mostrar
      lista_tvhd.sort((a, b) => a.plano.compareTo(b.plano));
      for (TvHd item in lista_tvhd) {
        ItemMostrar novo = ItemMostrar(
            "assets/icone-tv-branco.svg",
            item.plano,
            NumberFormat.simpleCurrency(locale: 'pt_BR').format(item.mensalidade),
            item.cliente_unifique == "Sim" ? "Cliente Unifique" : "Não é Cliente",
            "",
            "TV HD");
        mostrar_adicionar(novo);
      }
    }
    //calculo telefonia
    if (lista_telef.length > 0) {
      Telefone calcular = Telefone();
      var retorno_telef = calcular.calcular_total_telefonia(lista_telef, classe_cliente.value, tipo_cliente.value, cliente_score.value, cliente_unifique.value);
      lista_telef = calcular.lista_telef_retorno;
      adesoes_com_fidelidade.add(retorno_telef[0]);
      adesoes_sem_fidelidade.add(retorno_telef[1]);
      mensalidades.add(retorno_telef[2]);
      telef_valor_adesao_cf = retorno_telef[0];
      telef_valor_adesao_sf = retorno_telef[1];
      telef_valor_mensal = retorno_telef[2];
      //atualizar a lista_mostrar
      lista_telef.sort((a, b) => a.plano.compareTo(b.plano));
      for (Telefone item in lista_telef) {
        ItemMostrar novo = ItemMostrar(
            "assets/icone-telefonia-branco.svg",
            item.plano,
            NumberFormat.simpleCurrency(locale: 'pt_BR').format(item.mensalidade),
            item.cliente_unifique == "Sim" ? "Cliente Unifique" : "Não é Cliente",
            "",
            "Telefonia");
        mostrar_adicionar(novo);
      }
    }
    //calculo combo
    if (lista_combo.length > 0) {
      Combo calcular = Combo();
      var retorno_combo = calcular.calcular_total_combo(lista_combo, classe_cliente.value, tipo_cliente.value, cliente_score.value, cliente_unifique.value);
      lista_combo = calcular.lista_combo_retorno;
      adesoes_com_fidelidade.add(retorno_combo[0]);
      adesoes_sem_fidelidade.add(retorno_combo[1]);
      mensalidades.add(retorno_combo[2]);
      combo_valor_adesao_cf = retorno_combo[0];
      combo_valor_adesao_sf = retorno_combo[1];
      combo_valor_mensal = retorno_combo[2];
      //atualizar a lista_mostrar
      lista_combo.sort((a, b) => a.plano.compareTo(b.plano));
      if(tipo_cliente == 0){
        for (Combo item in lista_combo) {
          ItemMostrar novo = ItemMostrar(
              "assets/icone-combo-branco.svg",
              item.plano,
              "",
              NumberFormat.simpleCurrency(locale: 'pt_BR').format(item.mensalidade),
              "",
              "Combo");
          mostrar_adicionar(novo);
        }
      }
      else{
        combo_adesao_12_meses.value = retorno_combo[3];
        combo_mensalidade_total_12_meses.value = retorno_combo[4];
        num mensalidade_item_12_meses = retorno_combo[4]/lista_combo.length;
        for (Combo item in lista_combo) {
          ItemMostrar novo = ItemMostrar(
              "assets/icone-combo-branco.svg",
              item.plano,
              NumberFormat.simpleCurrency(locale: 'pt_BR').format(item.mensalidade) + " (2 anos)",
              "",
              NumberFormat.simpleCurrency(locale: 'pt_BR').format(mensalidade_item_12_meses) + " (1 ano)",
              "Combo");
          mostrar_adicionar(novo);
        }
      }
    }
    //calculo dos valores totais
    //total de adesao com fidelidade
    if (adesoes_com_fidelidade.length > 0) {
      adesao_com_fidelidade.value = 0;
      for (num valor_cf in adesoes_com_fidelidade)
        adesao_com_fidelidade.value += valor_cf;
    }
    //total de adesao sem fidelidade
    if (adesoes_sem_fidelidade.length > 0) {
      adesao_sem_fidelidade.value = 0;
      for (num valor_sf in adesoes_sem_fidelidade)
        adesao_sem_fidelidade.value += valor_sf;
    }
    //total de mensalidades
    if (mensalidades.length > 0) {
      mensalidade.value = 0;
      for (num valor_ms in mensalidades)
        mensalidade.value += valor_ms;
    }
  }

  bool verificar_mind_plus(){
    int qtd_1com = lista_casa.where((e) => e.plano == "Kit 1 Cômodo").length;
    int qtd_3com = lista_casa.where((e) => e.plano == "Kit 3 Cômodos").length;
    int qtd_8com = lista_casa.where((e) => e.plano == "Kit 8 Cômodos").length;
    int qtd_mind = lista_casa.where((e) => e.plano == "Mind Plus").length;
    int valor = qtd_1com + qtd_3com + qtd_8com + qtd_mind;
    if(valor > 0){
      return true;
    }
    else{
      return false;
    }
  }

  verificar_casa_inteligente(){
    CasaInteligente listas = CasaInteligente();
    List<CasaInteligente> lista_upd = [];
    int qtd_1com = lista_casa.where((e) => e.plano == "Kit 1 Cômodo").length;
    int qtd_3com = lista_casa.where((e) => e.plano == "Kit 3 Cômodos").length;
    int qtd_8com = lista_casa.where((e) => e.plano == "Kit 8 Cômodos").length;
    int qtd_mind = lista_casa.where((e) => e.plano == "Mind Plus").length;
    int qtd_play = lista_casa.where((e) => e.plano == "Play").length;
    int qtd_power = lista_casa.where((e) => e.plano == "Power").length;

    if(qtd_1com > 0){
      int cont_mind = 0;
      int cont_power = 0;
      for(int i = 0; i < qtd_1com; i++){
        cont_mind+=1;
        cont_power+=1;
      }
      qtd_1com = 0;
      qtd_mind+=cont_mind;
      qtd_power+=cont_power;
    }
    if(qtd_3com > 0){
      int cont_mind = 0;
      int cont_play = 0;
      int cont_power = 0;
      for(int i = 0; i < qtd_3com; i++){
        cont_mind+=1;
        cont_play+=1;
        cont_power+=3;
      }
      qtd_3com = 0;
      qtd_mind+=cont_mind;
      qtd_play+=cont_play;
      qtd_power+=cont_power;
    }
    if(qtd_8com > 0){
      int cont_mind = 0;
      int cont_play = 0;
      int cont_power = 0;
      for(int i = 0; i < qtd_8com; i++){
        cont_mind+=1;
        cont_play+=3;
        cont_power+=8;
      }
      qtd_8com = 0;
      qtd_mind+=cont_mind;
      qtd_play+=cont_play;
      qtd_power+=cont_power;
    }

    ComposicaoCasaIntel kit_1_comodo = ComposicaoCasaIntel.vazio();
    ComposicaoCasaIntel kit_3_comodo = ComposicaoCasaIntel.vazio();
    ComposicaoCasaIntel kit_8_comodo = ComposicaoCasaIntel.vazio();

    try{
      kit_1_comodo = listas.kit_casa_inteligente.firstWhere((e) => e.plano == "Kit 1 Cômodo");
    }catch(e){
      kit_1_comodo = ComposicaoCasaIntel.vazio();
    }

    try{
      kit_3_comodo = listas.kit_casa_inteligente.firstWhere((e) => e.plano == "Kit 3 Cômodos");
    }catch(e){
      kit_3_comodo = ComposicaoCasaIntel.vazio();
    }

    try{
      kit_8_comodo = listas.kit_casa_inteligente.firstWhere((e) => e.plano == "Kit 8 Cômodos");
    }catch(e){
      kit_8_comodo = ComposicaoCasaIntel.vazio();
    }

    int qtd_mind_for_8c = qtd_mind;
    for(int i = 0; i < qtd_mind_for_8c; i++){
      if(qtd_mind >= kit_8_comodo.qtd_mind && qtd_play >= kit_8_comodo.qtd_play && qtd_power >= kit_8_comodo.qtd_power){
        CasaInteligente novo = CasaInteligente();
        novo.plano = kit_8_comodo.plano;
        novo.mensalidade = 0.0;
        lista_upd.add(novo);
        qtd_mind-=1;
        qtd_play-=3;
        qtd_power-=8;
      }
    }

    int qtd_mind_for_3c = qtd_mind;
    for(int i = 0; i < qtd_mind_for_3c; i++){
      if(qtd_mind >= kit_3_comodo.qtd_mind && qtd_play >= kit_3_comodo.qtd_play && qtd_power >= kit_3_comodo.qtd_power){
        CasaInteligente novo = CasaInteligente();
        novo.plano = kit_3_comodo.plano;
        novo.mensalidade = 0.0;
        lista_upd.add(novo);
        qtd_mind-=1;
        qtd_play-=1;
        qtd_power-=3;
      }
    }

    int qtd_mind_for_1c = qtd_mind;
    for(int i = 0; i < qtd_mind_for_1c; i++){
      if(qtd_mind >= kit_1_comodo.qtd_mind && qtd_play >= kit_1_comodo.qtd_play && qtd_power >= kit_1_comodo.qtd_power){
        CasaInteligente novo = CasaInteligente();
        novo.plano = kit_1_comodo.plano;
        novo.mensalidade = 0.0;
        lista_upd.add(novo);
        qtd_mind-=1;
        qtd_power-=1;
      }
    }

    if(qtd_mind > 0){
      for(int i = 0; i < qtd_mind; i++){
        CasaInteligente novo = CasaInteligente();
        novo.plano = "Mind Plus";
        novo.mensalidade = 0.0;
        lista_upd.add(novo);
      }
    }
    if(qtd_play > 0){
      for(int i = 0; i < qtd_play; i++){
        CasaInteligente novo = CasaInteligente();
        novo.plano = "Play";
        novo.mensalidade = 0.0;
        lista_upd.add(novo);
      }
    }
    if(qtd_power > 0){
      for(int i = 0; i < qtd_power; i++){
        CasaInteligente novo = CasaInteligente();
        novo.plano = "Power";
        novo.mensalidade = 0.0;
        lista_upd.add(novo);
      }
    }

    lista_casa.value = lista_upd;
  }

  verificar_combo(){//USADO PARA CONVERTER ITENS AVULSOS EM COMBOS
    Combo listas = Combo();
    ComposicaoCombo busca = ComposicaoCombo.vazio();
    String nome_combo = "";
    if(lista_internet.isNotEmpty && lista_tvhd.isNotEmpty && lista_telef.isEmpty){
      //INTERNET + TV -> COMBO
      ComposicaoCombo busca = ComposicaoCombo.vazio();
      int ind_exc_internet = 0;
      int ind_exc_tv = 0;
      for(int i = 0; i < lista_internet.length; i++){
        for(int j = 0; j < lista_tvhd.length; j++){
          try{
            busca = listas.composicoes_dois_itens
                .firstWhere((e) =>
                  e.internet == lista_internet[i].plano &&
                  e.tv == lista_tvhd[j].plano);
            nome_combo = busca.nome_combo;
            ind_exc_internet = i;
            ind_exc_tv = j;
            break;
          }catch(e){
            continue;
          }
        }
      }
      if(nome_combo.isNotEmpty){
        if(cliente_score.value || cliente_unifique.value){
          lista_internet.removeAt(ind_exc_internet);
          lista_tvhd.removeAt(ind_exc_tv);
          Combo novo = Combo();
          novo.plano = nome_combo;
          novo.mensalidade = 0;
          combo_adicionar(novo);
          recalcular_total();
        }
        else{
          String pesquisa = "";
          try{
            ComboValorPF busca = ValoresPF().combo_cli_inad.firstWhere((e) => e.plano == nome_combo);
            pesquisa = busca.plano;
          }catch(e){
            pesquisa = "";
          }
          if(pesquisa == ""){
            return;
          }
          else{
            lista_internet.removeAt(ind_exc_internet);
            lista_tvhd.removeAt(ind_exc_tv);
            Combo novo = Combo();
            novo.plano = nome_combo;
            novo.mensalidade = 0;
            combo_adicionar(novo);
            recalcular_total();
          }
        }
      }
      return;
    }
    if(lista_internet.isNotEmpty && lista_tvhd.isNotEmpty && lista_telef.isNotEmpty){
      //INTERNET + TV + TELEFONE -> COMBO
      ComposicaoCombo busca = ComposicaoCombo.vazio();
      int ind_exc_internet = 0;
      int ind_exc_tv = 0;
      int ind_exc_telefone = 0;
      for(int i = 0; i < lista_internet.length; i++){
        for(int j = 0; j < lista_tvhd.length; j++){
          for(int k = 0; k < lista_telef.length; k++){
            try{
              busca = listas.composicoes_tres_itens
                  .firstWhere((e) =>
                    e.internet == lista_internet[i].plano &&
                    e.tv == lista_tvhd[j].plano &&
                    e.telefone == lista_telef[k].plano);
              nome_combo = busca.nome_combo;
              ind_exc_internet = i;
              ind_exc_tv = j;
              ind_exc_telefone = k;
              break;
            }catch(e){
              continue;
            }
          }
        }
      }
      if(nome_combo.isNotEmpty){
        if(cliente_score.value || cliente_unifique.value){
          lista_internet.removeAt(ind_exc_internet);
          lista_tvhd.removeAt(ind_exc_tv);
          lista_telef.removeAt(ind_exc_telefone);
          Combo novo = Combo();
          novo.plano = nome_combo;
          novo.mensalidade = 0;
          combo_adicionar(novo);
          recalcular_total();
        }
        else{
          String pesquisa = "";
          try{
            ComboValorPF busca = ValoresPF().combo_cli_inad.firstWhere((e) => e.plano == nome_combo);
            pesquisa = busca.plano;
          }catch(e){
            pesquisa = "";
          }
          if(pesquisa == ""){
            return;
          }
          else{
            lista_internet.removeAt(ind_exc_internet);
            lista_tvhd.removeAt(ind_exc_tv);
            lista_telef.removeAt(ind_exc_telefone);
            Combo novo = Combo();
            novo.plano = nome_combo;
            novo.mensalidade = 0;
            combo_adicionar(novo);
            recalcular_total();
          }
        }
      }
      return;
    }
    if(lista_internet.isEmpty && lista_tvhd.isEmpty && lista_telef.isNotEmpty && lista_combo.isNotEmpty){
      //COMBO(INTERNET + TV) + TELEFONE -> COMBO
      ComposicaoCombo combo_inserido = ComposicaoCombo.vazio();
      List<ComposicaoCombo> combos_inseridos = [];

      for(int i = 0; i < lista_combo.length; i++){
        try{
          combo_inserido = listas.composicoes_dois_itens
              .firstWhere((e) =>
                e.nome_combo == lista_combo[i].plano);
          combos_inseridos.add(combo_inserido);
        }catch(e){
          continue;
        }
      }

      ComposicaoCombo busca = ComposicaoCombo.vazio();
      int ind_exc_combo = 0;
      int ind_exc_telefone = 0;
      for(int i = 0; i < combos_inseridos.length; i++){
        for(int j = 0; j < lista_telef.length; j++){
          try{
            busca = listas.composicoes_tres_itens
                .firstWhere((e) =>
                  e.internet == combos_inseridos[i].internet &&
                  e.tv == combos_inseridos[i].tv &&
                  e.telefone == lista_telef[j].plano);
            nome_combo = busca.nome_combo;
            Combo buscar = lista_combo.firstWhere((e) => e.plano == combos_inseridos[i].nome_combo);
            ind_exc_combo = lista_combo.indexOf(buscar);
            ind_exc_telefone = j;
            break;
          }catch(e){
            continue;
          }
        }
      }
      if(nome_combo.isNotEmpty){
        if(cliente_score.value || cliente_unifique.value){
          lista_combo.removeAt(ind_exc_combo);
          lista_telef.removeAt(ind_exc_telefone);
          Combo novo = Combo();
          novo.plano = nome_combo;
          novo.mensalidade = 0;
          combo_adicionar(novo);
          recalcular_total();
        }
        else{
          String pesquisa = "";
          try{
            ComboValorPF busca = ValoresPF().combo_cli_inad.firstWhere((e) => e.plano == nome_combo);
            pesquisa = busca.plano;
          }catch(e){
            pesquisa = "";
          }
          if(pesquisa == ""){
            return;
          }
          else{
            lista_combo.removeAt(ind_exc_combo);
            lista_telef.removeAt(ind_exc_telefone);
            Combo novo = Combo();
            novo.plano = nome_combo;
            novo.mensalidade = 0;
            combo_adicionar(novo);
            recalcular_total();
          }
        }
      }
      return;
    }
  }

  //##################EXCLUSÃO##################
  efetivar_exclusao(int parametro){
    switch(parametro) {
      case 1: {//exclusão de categoria
        mostrar_remover_categoria();
      }
      break;
      case 2: {//exclusão do plano
        mostrar_limpar_plano();
      }
      break;
      default: {

      }
      break;
    }
  }
}