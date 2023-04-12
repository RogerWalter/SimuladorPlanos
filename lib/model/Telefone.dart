import 'package:simulador_unifique/model/ValoresPJ.dart';

import 'ValoresPF.dart';

class Telefone{
  String _plano = "";
  num _mensalidade = 0.0;
  String _cliente_unifique = "";

  String get plano => _plano;

  set plano(String value) {
    _plano = value;
  }

  num get mensalidade => _mensalidade;

  String get cliente_unifique => _cliente_unifique;

  set cliente_unifique(String value) {
    _cliente_unifique = value;
  }

  set mensalidade(num value) {
    _mensalidade = value;
  }

  List<String> planos_pf = [
    "",
    "Fique Fale Mais 80 Minutos",
    "Fique Fale Mais 2200 Minutos",
    "Fique Fale Mais 4400 Minutos",
    "Fique Fale Mais Ilimitado Total"
  ];

  List<String> planos_pj = [
    "",
    "Uni Ilim. Local LDN SC 1 Linha",
    "Uni Ilim. Local LDN SC 2 Linhas",
    "Uni Fixo 400 minutos 1 Linha",
    "Uni Fixo 400 minutos 2 Linhas"
  ];

  List<String> cli_unifique = [
    "",
    "Não",
    "Sim"
  ];

  String msg_excluir = "Deseja realmente remover todos os planos de Telefonia?\nEssa ação não afetará os combos.";
  String titulo_excluir = "Remover Telefonia";

  var lista_telef_retorno;

  calcular_total_telefonia(List<Telefone> lista_telefonia, int classe_cliente, int tipo_cliente, bool cliente_score, bool cliente_unifique){
    if(tipo_cliente == 0){//PF
      var retorno_telefonia = calcular_pf(lista_telefonia, classe_cliente, tipo_cliente, cliente_score, cliente_unifique);
      return [retorno_telefonia[0], retorno_telefonia[1], retorno_telefonia[2]];
    }
    else{//PJ
      var retorno_telefonia = calcular_pj(lista_telefonia, classe_cliente, tipo_cliente, cliente_score, cliente_unifique);
      return [retorno_telefonia[0], retorno_telefonia[1], retorno_telefonia[2]];
    }
  }

  calcular_pf(List<Telefone> lista_telefone, int classe_cliente, int tipo_cliente, bool cliente_score, bool cliente_unifique){
    ValoresPF v = ValoresPF();
    List<TelefoniaValorPF> calculos = [];
    TelefoniaValorPF valores = TelefoniaValorPF.vazio();

    if(cliente_score || cliente_unifique){
      switch(classe_cliente){
        case 0:
          calculos = v.telef_cli_0;
          break;
        case 1:
          calculos = v.telef_cli_1;
          break;
        case 2:
          calculos = v.telef_cli_2;
          break;
        case 3:
          calculos = v.telef_cli_3;
          break;
        case 4:
          calculos = v.telef_cli_4;
          break;
        case 5:
          calculos = v.telef_cli_5;
          break;
        case 6:
          calculos = v.telef_cli_6;
          break;
        case 99:
          calculos = v.telef_cli_99;
          break;
      }
    }
    else{
      calculos = v.telef_cli_inad;
    }

    num mensalidade_item = 0.0;
    num mensalidade_total = 0.0;
    num valor_adesao = 0.0;
    num valor_adesao_sem_fid = 0.0;

    for (int i = 0; i < lista_telefone.length; i++) {
      valores = calculos.firstWhere((e) => e.plano == lista_telefone[i].plano);

      if (lista_telefone[i].cliente_unifique == "Sim") {
        mensalidade_item = valores.mensal_sim_uni;
        valor_adesao += valores.adesao_cf_sim_cli;
        valor_adesao_sem_fid += valores.adesao_sf_sim_cli;
      }
      else {
        mensalidade_item = valores.mensal_nao_cli;
        valor_adesao += valores.adesao_cf_nao_cli;
        valor_adesao_sem_fid += valores.adesao_sf_nao_cli;
      }

      mensalidade_total+=mensalidade_item;
      lista_telefone[i].mensalidade = mensalidade_item;
    }
    lista_telef_retorno = lista_telefone;
    return [valor_adesao, valor_adesao_sem_fid, mensalidade_total];
  }

  calcular_pj(List<Telefone> lista_telefone, int classe_cliente, int tipo_cliente, bool cliente_score, bool cliente_unifique){
    ValoresPJ v = ValoresPJ();
    List<TelefoniaValorPJ> calculos = [];
    TelefoniaValorPJ valores = TelefoniaValorPJ.vazio();

    switch(classe_cliente){
      case 0:
        calculos = v.telef_cli_0;
        break;
      case 1:
        calculos = v.telef_cli_1;
        break;
      case 2:
        calculos = v.telef_cli_2;
        break;
      case 3:
        calculos = v.telef_cli_3;
        break;
      case 4:
        calculos = v.telef_cli_4;
        break;
      case 5:
        calculos = v.telef_cli_5;
        break;
      case 6:
        calculos = v.telef_cli_6;
        break;
      case 99:
        calculos = v.telef_cli_99;
        break;
    }

    num mensalidade_item = 0.0;
    num mensalidade_total = 0.0;
    num valor_adesao = 0.0;
    num valor_adesao_sem_fid = 0.0;

    for (int i = 0; i < lista_telefone.length; i++) {
      valores = calculos.firstWhere((e) => e.plano == lista_telefone[i].plano);

      if (lista_telefone[i].cliente_unifique == "Sim") {
        mensalidade_item = valores.mensal_sim_cli;
        valor_adesao += valores.adesao_cf_sim_cli;
        valor_adesao_sem_fid += valores.adesao_sf_sim_cli;
      }
      else {
        mensalidade_item = valores.mensal_nao_cli;
        valor_adesao += valores.adesao_cf_nao_cli;
        valor_adesao_sem_fid += valores.adesao_sf_nao_cli;
      }

      mensalidade_total+=mensalidade_item;
      lista_telefone[i].mensalidade = mensalidade_item;
    }
    lista_telef_retorno = lista_telefone;
    return [valor_adesao, valor_adesao_sem_fid, mensalidade_total];
  }

  List<TelefoneMostrar> preparar_lista_telefone(List<Telefone> lista_telefone){
    List<TelefoneMostrar>telefone_lista = [];
    for(Telefone item in lista_telefone){
      if(telefone_lista.length == 0){
        TelefoneMostrar novo = TelefoneMostrar();
        novo.plano = item.plano;
        novo.qtd = 1;
        telefone_lista.add(novo);
      }
      else{
        String plano_atual = item.plano;
        int ind_enc = -1;
        for(int i = 0; i < telefone_lista.length; i++){
          if(telefone_lista[i].plano == plano_atual){
            ind_enc = i;
          }
        }
        if(ind_enc != -1){
          TelefoneMostrar ja_existe = telefone_lista[ind_enc];
          int indice = telefone_lista.indexOf(ja_existe);
          int nova_qtd = ja_existe.qtd + 1;
          ja_existe.qtd = nova_qtd;
          telefone_lista[indice] = ja_existe;
        }
        else{
          TelefoneMostrar novo = TelefoneMostrar();
          novo.plano = item.plano;
          novo.qtd = 1;
          telefone_lista.add(novo);
        }
      }
    }
    return telefone_lista;
  }
}

class TelefoneMostrar extends Telefone{
  int qtd = 0;
}