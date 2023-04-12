import 'package:simulador_unifique/model/ValoresPF.dart';
import 'package:simulador_unifique/model/ValoresPJ.dart';

class Internet{
  String _plano = "";
  num _mensal_fid_12 = 0.0;
  num _mensal_fid_24 = 0.0;

  String get plano => _plano;

  set plano(String value) {
    _plano = value;
  }

  num get mensal_fid_12 => _mensal_fid_12;

  set mensal_fid_12(num value) {
    _mensal_fid_12 = value;
  }

  num get mensal_fid_24 => _mensal_fid_24;

  set mensal_fid_24(num value) {
    _mensal_fid_24 = value;
  }

  List<String> planos_pf = [
    "",
    "Fique Cond. FTTB Play 6 Mega",
    "Fique Cond. FTTB Play 15 Mega",
    "Fique Cond. FTTB Play 25 Mega",
    "Fique Cond. FTTB Play 100 Mega",
    "Fique Fibra Play 250 Mega",
    "Fique Fibra Play 400 Mega",
    "Fique Fibra Play 600 Mega",
    "Fique Fibra Play 1000 Mega",
    "Fique Fibra Play 2048 Mega"
  ];

  List<String> planos_pf_cli_inadimplente = [
    "",
    "Fique Cond. FTTB Play 50 Mega",
    "Fique Cond. FTTB Play 100 Mega",
    "Fique Fibra Play 250 Mega",
    "Fique Fibra Play 400 Mega",
    "Fique Fibra Play 600 Mega",
    "Fique Fibra Play 1000 Mega",
    "Fique Fibra Play 2048 Mega",
  ];

  List<String> planos_pj = [
    "",
    "Uni Fibra 50 Mega",
    "Uni Fibra 80 Mega",
    "Uni Fibra 200 Mega",
    "Uni Fibra 400 Mega",
    "Uni Fibra 600 Mega",
    "Uni Fibra 1 Giga",
    "Uni Fibra 2 Giga"
  ];

  List<String> planos_pj_cli_inadimplente = [
    "",
    "Uni Fibra 50 Mega",
    "Uni Fibra 80 Mega",
    "Uni Fibra 200 Mega",
    "Uni Fibra 400 Mega",
    "Uni Fibra 600 Mega",
    "Uni Fibra 1 Giga",
    "Uni Fibra 2 Giga"
  ];

  String msg_excluir = "Deseja realmente remover todos os planos de Internet?\nEssa ação não afetará os combos.";
  String titulo_excluir = "Remover Internet";

  var lista_internet_retorno;

  calcular_total_internet(List<Internet> lista_internet, int classe_cliente, int tipo_cliente, bool cliente_score, bool cliente_unifique){
    if(tipo_cliente == 0){//PF
      var retorno_internet = calcular_pf(lista_internet, classe_cliente, tipo_cliente, cliente_score, cliente_unifique);
      return [retorno_internet[0], retorno_internet[1], retorno_internet[2]];
    }
    else{//PJ
      var retorno_internet = calcular_pj(lista_internet, classe_cliente, tipo_cliente, cliente_score, cliente_unifique);
      return [retorno_internet[0], retorno_internet[1], retorno_internet[2], retorno_internet[3], retorno_internet[4]];
    }
  }

  calcular_pf(List<Internet> lista_internet, int classe_cliente, int tipo_cliente, bool cliente_score, bool cliente_unifique){
    ValoresPF v = ValoresPF();
    List<InternetValorPF> calculo = [];
    InternetValorPF valores = InternetValorPF.vazio();

    if(cliente_score || cliente_unifique){
      switch(classe_cliente){
        case 0:
          calculo = v.internet_cli_0;
          break;
        case 1:
          calculo = v.internet_cli_1;
          break;
        case 2:
          calculo = v.internet_cli_2;
          break;
        case 3:
          calculo = v.internet_cli_3;
          break;
        case 4:
          calculo = v.internet_cli_4;
          break;
        case 5:
          calculo = v.internet_cli_5;
          break;
        case 6:
          calculo = v.internet_cli_6;
          break;
        case 99:
          calculo = v.internet_cli_99;
          break;
      }
    }
    else{
      calculo = v.internet_cli_inad;
    }

    num mensalidade_item = 0.0;
    num mensalidade_total = 0.0;
    num valor_adesao = 0.0;
    num valor_adesao_sem_fid = 0.0;

    for(int i = 0; i < lista_internet.length; i++){
      try{
        valores = calculo.firstWhere((e) => e.plano == lista_internet[i].plano);
        mensalidade_item = valores.mensal;
        valor_adesao+=valores.adesao_cf;
        valor_adesao_sem_fid+=valores.adesao_sf;
        mensalidade_total+=mensalidade_item;
        lista_internet[i].mensal_fid_24 = mensalidade_item;
      }catch(e){
        InternetValorPF upg_eqpto = v.internet_upg_eqpto;
        mensalidade_item = upg_eqpto.mensal;
        valor_adesao+=upg_eqpto.adesao_cf;
        valor_adesao_sem_fid+=upg_eqpto.adesao_sf;
        mensalidade_total+=mensalidade_item;
        lista_internet[i].mensal_fid_24 = mensalidade_item;
      }
    }

    lista_internet_retorno = lista_internet;
    return [valor_adesao, valor_adesao_sem_fid, mensalidade_total];
  }

  calcular_pj(List<Internet> lista_internet, int classe_cliente, int tipo_cliente, bool cliente_score, bool cliente_unifique){
    ValoresPJ v = ValoresPJ();
    List<InternetValorPJ> calculo = [];
    InternetValorPJ valores = InternetValorPJ.vazio();

    if(cliente_score || cliente_unifique){
      switch(classe_cliente){
        case 0:
          calculo = v.internet_cli_0;
          break;
        case 1:
          calculo = v.internet_cli_1;
          break;
        case 2:
          calculo = v.internet_cli_2;
          break;
        case 3:
          calculo = v.internet_cli_3;
          break;
        case 4:
          calculo = v.internet_cli_4;
          break;
        case 5:
          calculo = v.internet_cli_5;
          break;
        case 6:
          calculo = v.internet_cli_6;
          break;
        case 99:
          calculo = v.internet_cli_99;
          break;
      }
    }
    else{
      calculo = v.internet_cli_inad;
    }

    num mensalidade_item_24m = 0.0;
    num mensalidade_item_12m = 0.0;
    num mensalidade_total_24m = 0.0;
    num mensalidade_total_12m = 0.0;
    num valor_adesao_24 = 0.0;
    num valor_adesao_12 = 0.0;
    num valor_adesao_sem_fid = 0.0;

    for(int i = 0; i < lista_internet.length; i++){
      try{
        valores = calculo.firstWhere((e) => e.plano == lista_internet[i].plano);
        mensalidade_item_24m = valores.mensal_24;
        mensalidade_item_12m = valores.mensal_12;

        valor_adesao_24+=valores.adesao_cf_24;
        valor_adesao_12+=valores.adesao_cf_12;
        valor_adesao_sem_fid+=valores.adesao_sf;

        mensalidade_total_24m+= mensalidade_item_24m;
        mensalidade_total_12m+= mensalidade_item_12m;
        lista_internet[i].mensal_fid_24 = mensalidade_item_24m;
        lista_internet[i].mensal_fid_12 = mensalidade_item_12m;
      }catch(e){
        InternetValorPJ upg_plano = v.internet_upg_eqpto;
        mensalidade_item_24m = upg_plano.mensal_24;
        mensalidade_item_12m = upg_plano.mensal_12;

        valor_adesao_24+=upg_plano.adesao_cf_24;
        valor_adesao_12+=upg_plano.adesao_cf_12;
        valor_adesao_sem_fid+=upg_plano.adesao_sf;

        mensalidade_total_24m+= mensalidade_item_24m;
        mensalidade_total_12m+= mensalidade_item_12m;
        lista_internet[i].mensal_fid_24 = mensalidade_item_24m;
        lista_internet[i].mensal_fid_12 = mensalidade_item_12m;
      }
    }

    lista_internet_retorno = lista_internet;
    return [valor_adesao_24, valor_adesao_sem_fid, mensalidade_total_24m, valor_adesao_12, mensalidade_total_12m];
  }

  List<InternetMostrar> preparar_lista_internet(List<Internet> lista_internet){
    List<InternetMostrar>internet_lista = [];
    for(Internet item in lista_internet){
      if(internet_lista.length == 0){
        InternetMostrar novo = InternetMostrar();
        novo.plano = item.plano;
        novo.qtd = 1;
        internet_lista.add(novo);
      }
      else{
        String plano_atual = item.plano;
        int ind_enc = -1;
        for(int i = 0; i < internet_lista.length; i++){
          if(internet_lista[i].plano == plano_atual){
            ind_enc = i;
          }
        }
        if(ind_enc != -1){
          InternetMostrar ja_existe = internet_lista[ind_enc];
          int indice = internet_lista.indexOf(ja_existe);
          int nova_qtd = ja_existe.qtd + 1;
          ja_existe.qtd = nova_qtd;
          internet_lista[indice] = ja_existe;
        }
        else{
          InternetMostrar novo = InternetMostrar();
          novo.plano = item.plano;
          novo.qtd = 1;
          internet_lista.add(novo);
        }
      }
    }
    return internet_lista;
  }
}

class InternetMostrar extends Internet{
  int qtd = 0;
}