import 'package:simulador_unifique/model/Produto.dart';
import 'package:simulador_unifique/model/ValoresPF.dart';
import 'package:simulador_unifique/model/ValoresPJ.dart';

class WifiBusiness {
  String _linha_ap = ""; //Light Indoor - Light Outdoor - Premium Indoor - Premium Outdoor
  String _licen = ""; //Standard - Full Web Filter
  String _link = ""; // 0 - 200 - 400 - 600 - 1000
  num _valor_mensalidade = 0.0;

  List<String> lista_linha_ap = [
    "",
    "Light Indoor",
    "Light Outdoor",
    "Premium Indoor",
    "Premium Outdoor"
  ];

  List<String> lista_licen = ["", "Standard", "Full Web Filter"];

  List<String> lista_link = ["", "200MB", "400MB", "600MB", "1000MB"];

  String msg_excluir = "Deseja realmente remover todos os itens do Wifi Business?";
  String titulo_excluir = "Remover Wifi Business";


  WifiBusiness();

  String get linha_ap => _linha_ap;

  set linha_ap(String value) {
    _linha_ap = value;
  }

  String get licen => _licen;

  num get valor_mensalidade => _valor_mensalidade;

  set valor_mensalidade(num value) {
    _valor_mensalidade = value;
  }

  String get link => _link;

  set link(String value) {
    _link = value;
  }

  set licen(String value) {
    _licen = value;
  }

  //VALOR RETORNADO PELA FUNÇÃO VERIFICA_VALOR_LINK
  WifiBusiValoresPJ link_internet = WifiBusiValoresPJ.vazio();

  var lista_wifibusi_retorno;

  verifica_valor_item(WifiBusiness item, int classeCliente, int tipo_cliente) {
    ValoresPJ v = ValoresPJ();

    switch (classeCliente) {
      case 0:
        if (item.link.isEmpty) {
          num valor_mensal_item = v.wifi_cli_0.firstWhere((e) => e.item == item.linha_ap).mensalidade;
          num valor_mensal_lice = v.wifi_cli_0.firstWhere((e) => e.item == item.licen).mensalidade;
          return valor_mensal_item + valor_mensal_lice;
        }
        else {
          num valor_link_salvar = 0.0;
          verificar_valor_link(item.link, classeCliente, tipo_cliente);;
          valor_link_salvar = link_internet.mensalidade;
          return valor_link_salvar;
        }
      case 1:
        if (item.link.isEmpty) {
          num valor_mensal_item = v.wifi_cli_1.firstWhere((e) => e.item == item.linha_ap).mensalidade;
          num valor_mensal_lice = v.wifi_cli_1.firstWhere((e) => e.item == item.licen).mensalidade;
          return valor_mensal_item + valor_mensal_lice;
        }
        else {
          num valor_link_salvar = 0.0;
          verificar_valor_link(item.link, classeCliente, tipo_cliente);;
          valor_link_salvar = link_internet.mensalidade;
          return valor_link_salvar;
        }
      case 2:
        if (item.link.isEmpty) {
          num valor_mensal_item = v.wifi_cli_2.firstWhere((e) => e.item == item.linha_ap).mensalidade;
          num valor_mensal_lice = v.wifi_cli_2.firstWhere((e) => e.item == item.licen).mensalidade;
          return valor_mensal_item + valor_mensal_lice;
        }
        else {
          num valor_link_salvar = 0.0;
          verificar_valor_link(item.link, classeCliente, tipo_cliente);;
          valor_link_salvar = link_internet.mensalidade;
          return valor_link_salvar;
        }
      case 3:
        if (item.link.isEmpty) {
          num valor_mensal_item = v.wifi_cli_3.firstWhere((e) => e.item == item.linha_ap).mensalidade;
          num valor_mensal_lice = v.wifi_cli_3.firstWhere((e) => e.item == item.licen).mensalidade;
          return valor_mensal_item + valor_mensal_lice;
        }
        else {
          num valor_link_salvar = 0.0;
          verificar_valor_link(item.link, classeCliente, tipo_cliente);;
          valor_link_salvar = link_internet.mensalidade;
          return valor_link_salvar;
        }
      case 4:
        if (item.link.isEmpty) {
          num valor_mensal_item = v.wifi_cli_4.firstWhere((e) => e.item == item.linha_ap).mensalidade;
          num valor_mensal_lice = v.wifi_cli_4.firstWhere((e) => e.item == item.licen).mensalidade;
          return valor_mensal_item + valor_mensal_lice;
        }
        else {
          num valor_link_salvar = 0.0;
          verificar_valor_link(item.link, classeCliente, tipo_cliente);;
          valor_link_salvar = link_internet.mensalidade;
          return valor_link_salvar;
        }
      case 5:
        if (item.link.isEmpty) {
          num valor_mensal_item = v.wifi_cli_5.firstWhere((e) => e.item == item.linha_ap).mensalidade;
          num valor_mensal_lice = v.wifi_cli_5.firstWhere((e) => e.item == item.licen).mensalidade;
          return valor_mensal_item + valor_mensal_lice;
        }
        else {
          num valor_link_salvar = 0.0;
          verificar_valor_link(item.link, classeCliente, tipo_cliente);;
          valor_link_salvar = link_internet.mensalidade;
          return valor_link_salvar;
        }
      case 6:
        if (item.link.isEmpty) {
          num valor_mensal_item = v.wifi_cli_6.firstWhere((e) => e.item == item.linha_ap).mensalidade;
          num valor_mensal_lice = v.wifi_cli_6.firstWhere((e) => e.item == item.licen).mensalidade;
          return valor_mensal_item + valor_mensal_lice;
        }
        else {
          num valor_link_salvar = 0.0;
          verificar_valor_link(item.link, classeCliente, tipo_cliente);;
          valor_link_salvar = link_internet.mensalidade;
          return valor_link_salvar;
        }
      default:
        return 0;
    }
  }

  verificar_valor_link(String link_escolhido, int classeCliente, int tipo_cliente) {
    ValoresPJ v = ValoresPJ();
    if (link_escolhido != "") {
      switch (classeCliente) {
        case 0:
          switch (link_escolhido) {
            case "200MB":
              link_internet = v.wifi_cli_0.firstWhere((e) => e.item == "200MB");
              break;
            case "400MB":
              link_internet = v.wifi_cli_0.firstWhere((e) => e.item == "400MB");
              break;
            case "600MB":
              link_internet = v.wifi_cli_0.firstWhere((e) => e.item == "600MB");
              break;
            case "1000MB":
              link_internet = v.wifi_cli_0.firstWhere((e) => e.item == "1000MB");
              break;
          }
          break;
        case 1:
          switch (link_escolhido) {
            case "200MB":
              link_internet = v.wifi_cli_1.firstWhere((e) => e.item == "200MB");
              break;
            case "400MB":
              link_internet = v.wifi_cli_1.firstWhere((e) => e.item == "400MB");
              break;
            case "600MB":
              link_internet = v.wifi_cli_1.firstWhere((e) => e.item == "600MB");
              break;
            case "1000MB":
              link_internet = v.wifi_cli_1.firstWhere((e) => e.item == "1000MB");
              break;
          }
          break;
        case 2:
          switch (link_escolhido) {
            case "200MB":
              link_internet = v.wifi_cli_2.firstWhere((e) => e.item == "200MB");
              break;
            case "400MB":
              link_internet = v.wifi_cli_2.firstWhere((e) => e.item == "400MB");
              break;
            case "600MB":
              link_internet = v.wifi_cli_2.firstWhere((e) => e.item == "600MB");
              break;
            case "1000MB":
              link_internet = v.wifi_cli_2.firstWhere((e) => e.item == "1000MB");
              break;
          }
          break;
        case 3:
          switch (link_escolhido) {
            case "200MB":
              link_internet = v.wifi_cli_3.firstWhere((e) => e.item == "200MB");
              break;
            case "400MB":
              link_internet = v.wifi_cli_3.firstWhere((e) => e.item == "400MB");
              break;
            case "600MB":
              link_internet = v.wifi_cli_3.firstWhere((e) => e.item == "600MB");
              break;
            case "1000MB":
              link_internet = v.wifi_cli_3.firstWhere((e) => e.item == "1000MB");
              break;
          }
          break;
        case 4:
          switch (link_escolhido) {
            case "200MB":
              link_internet = v.wifi_cli_4.firstWhere((e) => e.item == "200MB");
              break;
            case "400MB":
              link_internet = v.wifi_cli_4.firstWhere((e) => e.item == "400MB");
              break;
            case "600MB":
              link_internet = v.wifi_cli_4.firstWhere((e) => e.item == "600MB");
              break;
            case "1000MB":
              link_internet = v.wifi_cli_4.firstWhere((e) => e.item == "1000MB");
              break;
          }
          break;
        case 5:
          switch (link_escolhido) {
            case "200MB":
              link_internet = v.wifi_cli_5.firstWhere((e) => e.item == "200MB");
              break;
            case "400MB":
              link_internet = v.wifi_cli_5.firstWhere((e) => e.item == "400MB");
              break;
            case "600MB":
              link_internet = v.wifi_cli_5.firstWhere((e) => e.item == "600MB");
              break;
            case "1000MB":
              link_internet = v.wifi_cli_5.firstWhere((e) => e.item == "1000MB");
              break;
          }
          break;
        case 6:
          switch (link_escolhido) {
            case "200MB":
              link_internet = v.wifi_cli_6.firstWhere((e) => e.item == "200MB");
              break;
            case "400MB":
              link_internet = v.wifi_cli_6.firstWhere((e) => e.item == "400MB");
              break;
            case "600MB":
              link_internet = v.wifi_cli_6.firstWhere((e) => e.item == "600MB");
              break;
            case "1000MB":
              link_internet = v.wifi_cli_6.firstWhere((e) => e.item == "1000MB");
              break;
          }
          break;
      }
    }
  }
  calcular_total_wifi_business(List<WifiBusiness> lista_wifibusiness, int classe_cliente, int tipo_cliente) {
    ValoresPJ v = ValoresPJ();
    List<WifiBusiValoresPJ> calculo = [];
    switch(classe_cliente){
      case 0:
        calculo = v.wifi_cli_0;
        break;
      case 1:
        calculo = v.wifi_cli_1;
        break;
      case 2:
        calculo = v.wifi_cli_2;
        break;
      case 3:
        calculo = v.wifi_cli_3;
        break;
      case 4:
        calculo = v.wifi_cli_4;
        break;
      case 5:
        calculo = v.wifi_cli_5;
        break;
      case 6:
        calculo = v.wifi_cli_6;
        break;
      case 99:
        calculo = v.wifi_cli_99;
        break;
    }
    //PERCENTUAIS DE CALCULO
    num porc_12_meses = v.wifi_porc_12_meses;
    num porc_sem_fide = v.wifi_porc_sem_fide;
    //PRODUTOS E VALORES
    WifiBusiValoresPJ item_ap_lg_in = calculo.firstWhere((e) => e.item == "Light Indoor"); //AP Light Indoor
    WifiBusiValoresPJ item_ap_lg_ou = calculo.firstWhere((e) => e.item == "Light Outdoor"); //AP Light Indoor
    WifiBusiValoresPJ item_ap_pr_in = calculo.firstWhere((e) => e.item == "Premium Indoor"); //AP Light Indoor
    WifiBusiValoresPJ item_ap_pr_ou = calculo.firstWhere((e) => e.item == "Premium Outdoor"); //AP Light Indoor
    WifiBusiValoresPJ item_lc_st = calculo.firstWhere((e) => e.item == "Standard"); //AP Light Indoor
    WifiBusiValoresPJ item_lc_fw = calculo.firstWhere((e) => e.item == "Full Web Filter"); //AP Light Indoor
    //SUBTOTAIS DO BENEFICIO POR ITEM
    num tot_lg_in = 0.0; //total AP Light Indoor
    num tot_lg_ou = 0.0; //total AP Light Outdoor
    num tot_pr_in = 0.0; //total AP Premium Indoor
    num tot_pr_ou = 0.0; //total AP Premium Outdoor
    num tot_lc_st = 0.0; //total Licença Standard
    num tot_lc_fw = 0.0; //total Licença Full Web Filter
    //SUBTOTAIS DA MENSALIDADE POR ITEM
    num men_lg_in = 0.0; //mensalidade AP Light Indoor
    num men_lg_ou = 0.0; //mensalidade AP Light Outdoor
    num men_pr_in = 0.0; //mensalidade AP Premium Indoor
    num men_pr_ou = 0.0; //mensalidade AP Premium Outdoor
    num men_lc_st = 0.0; //mensalidade Licença Standard
    num men_lc_fw = 0.0; //mensalidade Licença Full Web Filter
    //SUBTOTAIS ADESÃO POR ITEM
    num tot_ade_lg_in_24 = 0.0; //total de adesão AP Light Indoor
    num tot_ade_lg_ou_24 = 0.0; //total de adesão AP Light Outdoor
    num tot_ade_pr_in_24 = 0.0; //total de adesão AP Premium Indoor
    num tot_ade_pr_ou_24 = 0.0; //total de adesão AP Premium Outdoor
    //TOTALIZADORES
    num beneficio = 0.0;
    num mensalidade = 0.0;
    num adesao_12 = 0.0;
    num adesao_24 = 0.0;
    num adesao_sf = 0.0;
    //QTD DE ITENS INDIVIDUAIS
    int qtd_lg_in = lista_wifibusiness.where((e) => e._linha_ap == "Light Indoor").length; //qtd AP Light Indoor
    int qtd_lg_ou = lista_wifibusiness.where((e) => e._linha_ap == "Light Outdoor").length; //qtd AP Light Outdoor
    int qtd_pr_in = lista_wifibusiness.where((e) => e._linha_ap == "Premium Indoor").length; //qtd AP Premium Indoor
    int qtd_pr_ou = lista_wifibusiness.where((e) => e._linha_ap == "Premium Outdoor").length; //qtd AP Premium Outdoor
    int qtd_lc_st = lista_wifibusiness.where((e) => e._licen == "Standard").length; //qtd Licença Standard
    int qtd_lc_fw = lista_wifibusiness.where((e) => e._licen == "Full Web Filter").length; //qtd Licença Full Web Filter
    //VERIFICAÇÃO DO LINK
    String link_escolhido = "";
    try {
      link_escolhido = lista_wifibusiness
          .firstWhere((e) => e._link != "")
          ._link;
    } catch (e) {
      link_escolhido = "";
    }
    if(link_escolhido != "")
      verificar_valor_link(link_escolhido, classe_cliente, tipo_cliente);
    //CALCULO DO BENEFICIO E DA MENSALIDADE
    if (qtd_lg_in > 0) {
      tot_lg_in = qtd_lg_in * item_ap_lg_in.custo;
      men_lg_in = qtd_lg_in * item_ap_lg_in.mensalidade;
      tot_ade_lg_in_24 = qtd_lg_in * item_ap_lg_in.adesao;
    }
    if (qtd_lg_ou > 0) {
      tot_lg_ou = qtd_lg_ou * item_ap_lg_ou.custo;
      men_lg_ou = qtd_lg_ou * item_ap_lg_ou.mensalidade;
      tot_ade_lg_ou_24 = qtd_lg_ou * item_ap_lg_ou.adesao;
    }
    if (qtd_pr_in > 0) {
      tot_pr_in = qtd_pr_in * item_ap_pr_in.custo;
      men_pr_in = qtd_pr_in * item_ap_pr_in.mensalidade;
      tot_ade_pr_in_24 = qtd_pr_in * item_ap_pr_in.adesao;
    }
    if (qtd_pr_ou > 0) {
      tot_pr_ou = qtd_pr_ou * item_ap_pr_ou.custo;
      men_pr_ou = qtd_pr_ou * item_ap_pr_ou.mensalidade;
      tot_ade_pr_ou_24 = qtd_pr_ou * item_ap_pr_ou.adesao;
    }
    if (qtd_lc_st > 0) {
      tot_lc_st = qtd_lc_st * item_lc_st.custo;
      men_lc_st = qtd_lc_st * item_lc_st.mensalidade;
    }
    if (qtd_lc_fw > 0) {
      tot_lc_fw = qtd_lc_fw * item_lc_fw.custo;
      men_lc_fw = qtd_lc_fw * item_lc_fw.mensalidade;
    }
    //CALCULO DOS TOTALIZADORES INDIVIDUAIS
    beneficio = tot_lg_in + tot_lg_ou + tot_pr_in + tot_pr_ou + tot_lc_st +
        tot_lc_fw + link_internet.custo;
    mensalidade = men_lg_in + men_lg_ou + men_pr_in + men_pr_ou + men_lc_st +
        men_lc_fw + link_internet.mensalidade;
    adesao_24 = tot_ade_lg_in_24 + tot_ade_lg_ou_24 + tot_ade_pr_in_24 +
        tot_ade_pr_ou_24 + link_internet.custo;
    adesao_12 = beneficio * porc_12_meses;
    adesao_sf = beneficio + (beneficio * porc_sem_fide);

    for(int i = 0; i < lista_wifibusiness.length; i++){
      num vlr_men_ap = 0.0;
      num vlr_men_lc = 0.0;
      num vlr_update = 0.0;
      if(lista_wifibusiness[i].linha_ap != "" && lista_wifibusiness[i].link == ""){//é ap
        if(lista_wifibusiness[i].linha_ap == "Light Indoor")
          vlr_men_ap = item_ap_lg_in.mensalidade;
        if(lista_wifibusiness[i].linha_ap == "Light Outdoor")
          vlr_men_ap = item_ap_lg_ou.mensalidade;
        if(lista_wifibusiness[i].linha_ap == "Premium Indoor")
          vlr_men_ap = item_ap_pr_in.mensalidade;
        if(lista_wifibusiness[i].linha_ap == "Premium Outdoor")
          vlr_men_ap = item_ap_pr_ou.mensalidade;
        if(lista_wifibusiness[i].licen == "Standard")
          vlr_men_lc = item_lc_st.mensalidade;
        if(lista_wifibusiness[i].licen == "Full Web Filter")
          vlr_men_lc = item_lc_fw.mensalidade;
        vlr_update = vlr_men_ap + vlr_men_lc;
        lista_wifibusiness[i].valor_mensalidade = vlr_update;
      }
      if(lista_wifibusiness[i].linha_ap == "" && lista_wifibusiness[i].link != ""){//é link
        verificar_valor_link(lista_wifibusiness[i].link, classe_cliente, tipo_cliente);
        vlr_update = link_internet.mensalidade;
        lista_wifibusiness[i].valor_mensalidade = vlr_update;
      }
    }
    lista_wifibusi_retorno = lista_wifibusiness;
    return [adesao_24, adesao_sf, mensalidade, adesao_12];
  }

  List<WifiBusinessMostrar> preparar_lista_wifibusiness(List<WifiBusiness> lista_wifibusiness){
    List<WifiBusinessMostrar>wifibusiness_lista = [];
    for(WifiBusiness item in lista_wifibusiness){
      if(wifibusiness_lista.length == 0){
        WifiBusinessMostrar nova = WifiBusinessMostrar();
        nova.linha_ap = item.linha_ap;
        nova.link = item.link;
        nova.licen = item.licen;
        nova.qtd = 1;
        wifibusiness_lista.add(nova);
      }
      else{
        String linha_ap_atual = item.linha_ap;
        String link_internet_atual = item.link;
        String lice_atual = item.licen;
        int ind_enc = -1;
        for(int i = 0; i < wifibusiness_lista.length; i++){
          if(wifibusiness_lista[i].linha_ap == linha_ap_atual){
            if(wifibusiness_lista[i].link == link_internet_atual){
              if(wifibusiness_lista[i].licen == lice_atual){
                ind_enc = i;
              }
            }
          }
        }
        if(ind_enc != -1){
          WifiBusinessMostrar ja_existe = wifibusiness_lista[ind_enc];
          int indice = wifibusiness_lista.indexOf(ja_existe);
          int nova_qtd = ja_existe.qtd + 1;
          ja_existe.qtd = nova_qtd;
          wifibusiness_lista[indice] = ja_existe;
        }
        else{
          WifiBusinessMostrar nova = WifiBusinessMostrar();
          nova.linha_ap = item.linha_ap;
          nova.link = item.link;
          nova.licen = item.licen;
          nova.qtd = 1;
          wifibusiness_lista.add(nova);
        }
      }
    }
    return wifibusiness_lista;
  }
}

class WifiBusinessMostrar extends WifiBusiness{
  int qtd = 0;
}