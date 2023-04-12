import 'ValoresPF.dart';
import 'ValoresPJ.dart';

class TvHd {
  String _plano = "";
  num _mensalidade = 0.0;
  String _cliente_unifique = "";

  String get plano => _plano;

  set plano(String value) {
    _plano = value;
  }

  num get mensalidade => _mensalidade;

  set mensalidade(num value) {
    _mensalidade = value;
  }

  String get cliente_unifique => _cliente_unifique;

  set cliente_unifique(String value) {
    _cliente_unifique = value;
  }

  List<String> planos_tv = [
    "",
    "Ponto Adicional",
    "Fique TV Light",
    "Fique TV Essencial",
    "Fique TV Multi",
    "Fique TV Premium"
  ];

  List<String> cli_unifique = [
    "",
    "Não",
    "Sim"
  ];

  String msg_excluir = "Deseja realmente remover todos os planos e pontos adicionais de TV HD?\nEssa ação não afetará os combos.";
  String titulo_excluir = "Remover TV HD";

  var lista_tvhd_retorno;

  calcular_total_tvhd(List<TvHd> lista_tvhd, int classe_cliente, int tipo_cliente) {
    if(lista_tvhd == 0){//PF
      var retorno_tvhd = calcular_pf(lista_tvhd, classe_cliente, tipo_cliente);
      return [retorno_tvhd[0], retorno_tvhd[1], retorno_tvhd[2]];
    }
    else{//PJ
      var retorno_tvhd = calcular_pj(lista_tvhd, classe_cliente, tipo_cliente);
      return [retorno_tvhd[0], retorno_tvhd[1], retorno_tvhd[2]];
    }
  }

  calcular_pf(List<TvHd> lista_tvhd, int classe_cliente, int tipo_cliente){
    ValoresPF v = ValoresPF();
    List<TvHDValorPF> calculo = [];
    TvHDValorPF valores = TvHDValorPF.vazio();

    switch (classe_cliente) {
      case 0:
        calculo = v.tvhd_cli_0;
        break;
      case 1:
        calculo = v.tvhd_cli_1;
        break;
      case 2:
        calculo = v.tvhd_cli_2;
        break;
      case 3:
        calculo = v.tvhd_cli_3;
        break;
      case 4:
        calculo = v.tvhd_cli_4;
        break;
      case 5:
        calculo = v.tvhd_cli_5;
        break;
      case 6:
        calculo = v.tvhd_cli_6;
        break;
      case 99:
        calculo = v.tvhd_cli_99;
        break;
    }

    num mensalidade_item = 0.0;
    num mensalidade_total = 0.0;
    num valor_adesao = 0.0;
    num valor_adesao_sem_fid = 0.0;

    for (int i = 0; i < lista_tvhd.length; i++) {
      valores = calculo.firstWhere((e) => e.plano == lista_tvhd[i].plano);
      mensalidade_item = valores.mensal;
      valor_adesao_sem_fid += valores.adesao_sf;

      if (lista_tvhd[i].cliente_unifique == "Sim"){
        valor_adesao += mensalidade_item = valores.adesao_cf_cli_uni;
      }
      else{
        valor_adesao += mensalidade_item = valores.adesao_cf_n_cli;
      }

      mensalidade_total+=mensalidade_item;
      lista_tvhd[i].mensalidade = mensalidade_item;
    }
    lista_tvhd_retorno = lista_tvhd;
    return [valor_adesao, valor_adesao_sem_fid, mensalidade_total];
  }

  calcular_pj(List<TvHd> lista_tvhd, int classe_cliente, int tipo_cliente){
    ValoresPJ v = ValoresPJ();
    List<TvHDValorPJ> calculo = [];
    TvHDValorPJ valores = TvHDValorPJ.vazio();

    switch (classe_cliente) {
      case 0:
        calculo = v.tvhd_cli_0;
        break;
      case 1:
        calculo = v.tvhd_cli_1;
        break;
      case 2:
        calculo = v.tvhd_cli_2;
        break;
      case 3:
        calculo = v.tvhd_cli_3;
        break;
      case 4:
        calculo = v.tvhd_cli_4;
        break;
      case 5:
        calculo = v.tvhd_cli_5;
        break;
      case 6:
        calculo = v.tvhd_cli_6;
        break;
      case 99:
        calculo = v.tvhd_cli_99;
        break;
    }

    num mensalidade_item = 0.0;
    num mensalidade_total = 0.0;
    num valor_adesao = 0.0;
    num valor_adesao_sem_fid = 0.0;

    for (int i = 0; i < lista_tvhd.length; i++) {
      valores = calculo.firstWhere((e) => e.plano == lista_tvhd[i].plano);
      mensalidade_item = valores.mensal;
      valor_adesao_sem_fid += valores.adesao_sf;

      if (lista_tvhd[i].cliente_unifique == "Sim"){
        valor_adesao += mensalidade_item = valores.adesao_cf_cli_uni;
      }
      else{
        valor_adesao += mensalidade_item = valores.adesao_cf_n_cli;
      }

      mensalidade_total+=mensalidade_item;
      lista_tvhd[i].mensalidade = mensalidade_item;
    }
    lista_tvhd_retorno = lista_tvhd;
    return [valor_adesao, valor_adesao_sem_fid, mensalidade_total];
  }

  List<TvHdMostrar> preparar_lista_tvhd(List<TvHd> lista_tvhd){
    List<TvHdMostrar>tvhd_lista = [];
    for(TvHd item in lista_tvhd){
      if(tvhd_lista.length == 0){
        TvHdMostrar novo = TvHdMostrar();
        novo.plano = item.plano;
        novo.qtd = 1;
        tvhd_lista.add(novo);
      }
      else{
        String plano_atual = item.plano;
        int ind_enc = -1;
        for(int i = 0; i < tvhd_lista.length; i++){
          if(tvhd_lista[i].plano == plano_atual){
            ind_enc = i;
          }
        }
        if(ind_enc != -1){
          TvHdMostrar ja_existe = tvhd_lista[ind_enc];
          int indice = tvhd_lista.indexOf(ja_existe);
          int nova_qtd = ja_existe.qtd + 1;
          ja_existe.qtd = nova_qtd;
          tvhd_lista[indice] = ja_existe;
        }
        else{
          TvHdMostrar novo = TvHdMostrar();
          novo.plano = item.plano;
          novo.qtd = 1;
          tvhd_lista.add(novo);
        }
      }
    }
    return tvhd_lista;
  }
}

class TvHdMostrar extends TvHd{
  int qtd = 0;
}