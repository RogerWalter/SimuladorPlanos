import 'ValoresPF.dart';
import 'ValoresPJ.dart';

class Combo{
  String _plano = "";
  num _mensalidade = 0.0;

  num get mensalidade => _mensalidade;

  set mensalidade(num value) {
    _mensalidade = value;
  }
  String get plano => _plano;

  set plano(String value) {
    _plano = value;
  }

  String msg_excluir = "Deseja realmente remover todos os Combos?";
  String titulo_excluir = "Remover Combo";

  List<ComposicaoCombo> composicoes_dois_itens = [
    ComposicaoCombo.dois_itens("Combo Fibra 400 Mega Light", "Fique Fibra Play 400 Mega", "Fique TV Light"),
    ComposicaoCombo.dois_itens("Combo Fibra 600 Mega Light", "Fique Fibra Play 600 Mega", "Fique TV Light"),
    ComposicaoCombo.dois_itens("Combo Fibra 1000 Mega Light", "Fique Fibra Play 1000 Mega", "Fique TV Light"),
    ComposicaoCombo.dois_itens("Combo Fibra 400 Mega Essencial", "Fique Fibra Play 400 Mega", "Fique TV Essencial"),
    ComposicaoCombo.dois_itens("Combo Fibra 600 Mega Essencial", "Fique Fibra Play 600 Mega", "Fique TV Essencial"),
    ComposicaoCombo.dois_itens("Combo Fibra 1000 Mega Essencial", "Fique Fibra Play 1000 Mega", "Fique TV Essencial"),
    ComposicaoCombo.dois_itens("Combo Fibra 400 Mega Multi", "Fique Fibra Play 400 Mega", "Fique TV Multi"),
    ComposicaoCombo.dois_itens("Combo Fibra 600 Mega Multi", "Fique Fibra Play 600 Mega", "Fique TV Multi"),
    ComposicaoCombo.dois_itens("Combo Fibra 1000 Mega Multi", "Fique Fibra Play 1000 Mega", "Fique TV Multi"),
    ComposicaoCombo.dois_itens("Combo Fibra 400 Mega Premium", "Fique Fibra Play 400 Mega", "Fique TV Premium"),
    ComposicaoCombo.dois_itens("Combo Fibra 600 Mega Premium", "Fique Fibra Play 600 Mega", "Fique TV Premium"),
    ComposicaoCombo.dois_itens("Combo Fibra 1000 Mega Premium", "Fique Fibra Play 1000 Mega", "Fique TV Premium"),
    ComposicaoCombo.dois_itens("Combo Fibra 2 Giga Premium", "Fique Fibra Play 2048 Mega", "Fique TV Premium"),
  ];

  List<ComposicaoCombo> composicoes_tres_itens = [
    ComposicaoCombo.tres_itens("Combo Fibra 400 Mega Light 2200 Min", "Fique Fibra Play 400 Mega", "Fique TV Light", "Fique Fale Mais 2200 Minutos"),
    ComposicaoCombo.tres_itens("Combo Fibra 600 Mega Light Lig. Ilim.", "Fique Fibra Play 600 Mega", "Fique TV Light", "Fique Fale Mais Ilimitado Total"),
    ComposicaoCombo.tres_itens("Combo Fibra 1000 Mega Light Lig. Ilim.", "Fique Fibra Play 1000 Mega", "Fique TV Light", "Fique Fale Mais Ilimitado Total"),
    ComposicaoCombo.tres_itens("Combo Fibra 2000 Mega Light Lig. Ilim.", "Fique Fibra Play 2048 Mega", "Fique TV Light", "Fique Fale Mais Ilimitado Total"),
    ComposicaoCombo.tres_itens("Combo Fibra 400 Mega Essencial 2200 Min", "Fique Fibra Play 400 Mega", "Fique TV Essencial", "Fique Fale Mais 2200 Minutos"),
    ComposicaoCombo.tres_itens("Combo Fibra 600 Mega Essencial Lig. Ilim.", "Fique Fibra Play 600 Mega", "Fique TV Essencial", "Fique Fale Mais Ilimitado Total"),
    ComposicaoCombo.tres_itens("Combo Fibra 1000 Mega Essencial Lig. Ilim.", "Fique Fibra Play 1000 Mega", "Fique TV Essencial", "Fique Fale Mais Ilimitado Total"),
    ComposicaoCombo.tres_itens("Combo Fibra 2000 Mega Essencial Lig. Ilim.", "Fique Fibra Play 2048 Mega", "Fique TV Essencial", "Fique Fale Mais Ilimitado Total"),
    ComposicaoCombo.tres_itens("Combo Fibra 400 Mega Multi 2200 Min", "Fique Fibra Play 400 Mega", "Fique TV Multi", "Fique Fale Mais 2200 Minutos"),
    ComposicaoCombo.tres_itens("Combo Fibra 600 Mega Multi Lig. Ilim.", "Fique Fibra Play 600 Mega", "Fique TV Multi", "Fique Fale Mais Ilimitado Total"),
    ComposicaoCombo.tres_itens("Combo Fibra 1000 Mega Multi Lig. Ilim.", "Fique Fibra Play 1000 Mega", "Fique TV Multi", "Fique Fale Mais Ilimitado Total"),
    ComposicaoCombo.tres_itens("Combo Fibra 2000 Mega Multi Lig. Ilim.", "Fique Fibra Play 2048 Mega", "Fique TV Multi", "Fique Fale Mais Ilimitado Total"),
    ComposicaoCombo.tres_itens("Combo Fibra 400 Mega Premium 2200 Min", "Fique Fibra Play 400 Mega", "Fique TV Premium", "Fique Fale Mais 2200 Minutos"),
    ComposicaoCombo.tres_itens("Combo Fibra 600 Mega Premium Lig. Ilim.", "Fique Fibra Play 600 Mega", "Fique TV Premium", "Fique Fale Mais Ilimitado Total"),
    ComposicaoCombo.tres_itens("Combo Fibra 1000 Mega Premium Lig. Ilim.", "Fique Fibra Play 1000 Mega", "Fique TV Premium", "Fique Fale Mais Ilimitado Total"),
    ComposicaoCombo.tres_itens("Combo Fibra 2000 Mega Premium Lig. Ilim.", "Fique Fibra Play 2048 Mega", "Fique TV Premium", "Fique Fale Mais Ilimitado Total"),
  ];

  List<ComposicaoCombo> composicoes_pj = [
    ComposicaoCombo.pj("Uni Fibra 100 Mega + Ilim. LDN BR 1 Linha", "Uni Fibra 100 Mega", "Ilim. LDN BR 1 Linha"),
    ComposicaoCombo.pj("Uni Fibra 400 Mega + Ilim. LDN BR 1 Linha", "Uni Fibra 400 Mega", "Ilim. LDN BR 1 Linha"),
    ComposicaoCombo.pj("Uni Fibra 600 Mega + Ilim. LDN BR 1 Linha", "Uni Fibra 600 Mega", "Ilim. LDN BR 1 Linha"),
    ComposicaoCombo.pj("Uni Fibra 1 Giga + Ilim. LDN BR 1 Linha", "Uni Fibra 1 Giga", "Ilim. LDN BR 1 Linha"),
    ComposicaoCombo.pj("Uni Fibra 2 Giga + Ilim. LDN BR 1 Linha", "Uni Fibra 2 Giga", "Ilim. LDN BR 1 Linha"),
    ComposicaoCombo.pj("Uni Fibra 100 Mega + Ilim. LDN BR 1 Linha", "Uni Fibra 100 Mega", "Ilim. LDN BR 1 Linha"),
    ComposicaoCombo.pj("Uni Fibra 400 Mega + Ilim. LDN BR 1 Linha", "Uni Fibra 400 Mega", "Ilim. LDN BR 1 Linha"),
    ComposicaoCombo.pj("Uni Fibra 600 Mega + Ilim. LDN BR 1 Linha", "Uni Fibra 600 Mega", "Ilim. LDN BR 1 Linha"),
    ComposicaoCombo.pj("Uni Fibra 1 Giga + Ilim. LDN BR 1 Linha", "Uni Fibra 1 Giga", "Ilim. LDN BR 1 Linha"),
    ComposicaoCombo.pj("Uni Fibra 2 Giga + Ilim. LDN BR 1 Linha", "Uni Fibra 2 Giga", "Ilim. LDN BR 1 Linha"),
    ComposicaoCombo.pj("Uni Fibra 100 Mega + Ilim. LDN BR 2 Linhas", "Uni Fibra 100 Mega", "Ilim. LDN BR 2 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 400 Mega + Ilim. LDN BR 2 Linhas", "Uni Fibra 400 Mega", "Ilim. LDN BR 2 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 600 Mega + Ilim. LDN BR 2 Linhas", "Uni Fibra 600 Mega", "Ilim. LDN BR 2 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 1 Giga + Ilim. LDN BR 2 Linhas", "Uni Fibra 1 Giga", "Ilim. LDN BR 2 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 2 Giga + Ilim. LDN BR 2 Linhas", "Uni Fibra 2 Giga", "Ilim. LDN BR 2 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 100 Mega + Ilim. LDN BR 2 Linhas", "Uni Fibra 100 Mega", "Ilim. LDN BR 2 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 400 Mega + Ilim. LDN BR 2 Linhas", "Uni Fibra 400 Mega", "Ilim. LDN BR 2 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 600 Mega + Ilim. LDN BR 2 Linhas", "Uni Fibra 600 Mega", "Ilim. LDN BR 2 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 1 Giga + Ilim. LDN BR 2 Linhas", "Uni Fibra 1 Giga", "Ilim. LDN BR 2 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 2 Giga + Ilim. LDN BR 2 Linhas", "Uni Fibra 2 Giga", "Ilim. LDN BR 2 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 100 Mega + Ilim. LDN BR 4 Linhas", "Uni Fibra 100 Mega", "Ilim. LDN BR 4 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 400 Mega + Ilim. LDN BR 4 Linhas", "Uni Fibra 400 Mega", "Ilim. LDN BR 4 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 600 Mega + Ilim. LDN BR 4 Linhas", "Uni Fibra 600 Mega", "Ilim. LDN BR 4 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 1 Giga + Ilim. LDN BR 4 Linhas", "Uni Fibra 1 Giga", "Ilim. LDN BR 4 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 2 Giga + Ilim. LDN BR 4 Linhas", "Uni Fibra 2 Giga", "Ilim. LDN BR 4 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 100 Mega + Ilim. LDN BR 4 Linhas", "Uni Fibra 100 Mega", "Ilim. LDN BR 4 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 400 Mega + Ilim. LDN BR 4 Linhas", "Uni Fibra 400 Mega", "Ilim. LDN BR 4 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 600 Mega + Ilim. LDN BR 4 Linhas", "Uni Fibra 600 Mega", "Ilim. LDN BR 4 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 1 Giga + Ilim. LDN BR 4 Linhas", "Uni Fibra 1 Giga", "Ilim. LDN BR 4 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 2 Giga + Ilim. LDN BR 4 Linhas", "Uni Fibra 2 Giga", "Ilim. LDN BR 4 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 400 Mega + Ilim. LDN BR 6 Linhas", "Uni Fibra 400 Mega", "Ilim. LDN BR 6 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 600 Mega + Ilim. LDN BR 6 Linhas", "Uni Fibra 600 Mega", "Ilim. LDN BR 6 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 1 Giga + Ilim. LDN BR 6 Linhas", "Uni Fibra 1 Giga", "Ilim. LDN BR 6 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 2 Giga + Ilim. LDN BR 6 Linhas", "Uni Fibra 2 Giga", "Ilim. LDN BR 6 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 400 Mega + Ilim. LDN BR 6 Linhas", "Uni Fibra 400 Mega", "Ilim. LDN BR 6 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 600 Mega + Ilim. LDN BR 6 Linhas", "Uni Fibra 600 Mega", "Ilim. LDN BR 6 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 1 Giga + Ilim. LDN BR 6 Linhas", "Uni Fibra 1 Giga", "Ilim. LDN BR 6 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 2 Giga + Ilim. LDN BR 6 Linhas", "Uni Fibra 2 Giga", "Ilim. LDN BR 6 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 400 Mega + Ilim. LDN BR 8 Linhas", "Uni Fibra 400 Mega", "Ilim. LDN BR 8 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 600 Mega + Ilim. LDN BR 8 Linhas", "Uni Fibra 600 Mega", "Ilim. LDN BR 8 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 1 Giga + Ilim. LDN BR 8 Linhas", "Uni Fibra 1 Giga", "Ilim. LDN BR 8 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 2 Giga + Ilim. LDN BR 8 Linhas", "Uni Fibra 2 Giga", "Ilim. LDN BR 8 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 400 Mega + Ilim. LDN BR 8 Linhas", "Uni Fibra 400 Mega", "Ilim. LDN BR 8 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 600 Mega + Ilim. LDN BR 8 Linhas", "Uni Fibra 600 Mega", "Ilim. LDN BR 8 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 1 Giga + Ilim. LDN BR 8 Linhas", "Uni Fibra 1 Giga", "Ilim. LDN BR 8 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 2 Giga + Ilim. LDN BR 8 Linhas", "Uni Fibra 2 Giga", "Ilim. LDN BR 8 Linhas")
  ];

  List<ComposicaoCombo> composicoes_pj_inad = [
    ComposicaoCombo.pj("Uni Fibra 2 Giga + Ilim. Total 1 Linha", "Uni Fibra 2 Giga", "Ilim. Total 1 Linha"),
    ComposicaoCombo.pj("Uni Fibra 2 Giga + Ilim. Total 2 Linhas", "Uni Fibra 2 Giga", "Ilim. Total 2 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 2 Giga + Ilim. Total 4 Linhas", "Uni Fibra 2 Giga", "Ilim. Total 4 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 2 Giga + Ilim. Total 6 Linhas", "Uni Fibra 2 Giga", "Ilim. Total 6 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 2 Giga + Ilim. Total 8 Linhas", "Uni Fibra 2 Giga", "Ilim. Total 8 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 1 Giga + Ilim. Total 1 Linha", "Uni Fibra 1 Giga", "Ilim. Total 1 Linha"),
    ComposicaoCombo.pj("Uni Fibra 1 Giga + Ilim. Total 2 Linhas", "Uni Fibra 1 Giga", "Ilim. Total 2 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 1 Giga + Ilim. Total 4 Linhas", "Uni Fibra 1 Giga", "Ilim. Total 4 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 1 Giga + Ilim. Total 6 Linhas", "Uni Fibra 1 Giga", "Ilim. Total 6 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 1 Giga + Ilim. Total 8 Linhas", "Uni Fibra 1 Giga", "Ilim. Total 8 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 600 Mega + Ilim. Total 1 Linha", "Uni Fibra 600 Mega", "Ilim. Total 1 Linha"),
    ComposicaoCombo.pj("Uni Fibra 600 Mega + Ilim. Total 2 Linhas", "Uni Fibra 600 Mega", "Ilim. Total 2 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 600 Mega + Ilim. Total 4 Linhas", "Uni Fibra 600 Mega", "Ilim. Total 4 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 600 Mega + Ilim. Total 6 Linhas", "Uni Fibra 600 Mega", "Ilim. Total 6 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 600 Mega + Ilim. Total 8 Linhas", "Uni Fibra 600 Mega", "Ilim. Total 8 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 400 Mega + Ilim. LDN BR 1 Linha", "Uni Fibra 400 Mega", "Ilim. LDN BR 1 Linha"),
    ComposicaoCombo.pj("Uni Fibra 400 Mega + Ilim. LDN BR 2 Linhas", "Uni Fibra 400 Mega", "Ilim. LDN BR 2 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 400 Mega + Ilim. LDN BR 4 Linhas", "Uni Fibra 400 Mega", "Ilim. LDN BR 4 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 400 Mega + Ilim. LDN BR 6 Linhas", "Uni Fibra 400 Mega", "Ilim. LDN BR 6 Linhas"),
    ComposicaoCombo.pj("Uni Fibra 400 Mega + Ilim. LDN BR 8 Linhas", "Uni Fibra 400 Mega", "Ilim. LDN BR 8 Linhas")
  ];

  List<String> lista_internet = [
    "",
    "Fique Fibra Play 400 Mega",
    "Fique Fibra Play 600 Mega",
    "Fique Fibra Play 1000 Mega",
    "Fique Fibra Play 2048 Mega"
  ];

  List<String> lista_tvhd = [
    "",
    "Fique TV Light",
    "Fique TV Essencial",
    "Fique TV Multi",
    "Fique TV Premium"
  ];

  List<String> lista_telefonia = [
    "",
    "Fique Fale Mais 2200 Minutos",
    "Fique Fale Mais Ilimitado Total",
  ];

  List<String> lista_internet_pj = [
    "",
    "Uni Fibra 100 Mega",
    "Uni Fibra 400 Mega",
    "Uni Fibra 600 Mega",
    "Uni Fibra 1 Giga",
    "Uni Fibra 2 Giga"
  ];

  List<String> lista_internet_pj_inad = [
    "",
    "Uni Fibra 400 Mega",
    "Uni Fibra 600 Mega",
    "Uni Fibra 1 Giga",
    "Uni Fibra 2 Giga"
  ];

  List<String> lista_telefonia_pj = [
    "",
    "Ilim. LDN BR 1 Linha",
    "Ilim. LDN BR 2 Linhas",
    "Ilim. LDN BR 4 Linhas",
    "Ilim. LDN BR 6 Linhas",
    "Ilim. LDN BR 8 Linhas"
  ];

  List<String> lista_telefonia_pj_inad = [
    "",
    "Ilim. Total 1 Linha",
    "Ilim. Total 2 Linhas",
    "Ilim. Total 4 Linhas",
    "Ilim. Total 6 Linhas",
    "Ilim. Total 8 Linhas",
    "Ilim. LDN BR 1 Linha",
    "Ilim. LDN BR 2 Linhas",
    "Ilim. LDN BR 4 Linhas",
    "Ilim. LDN BR 6 Linhas",
    "Ilim. LDN BR 8 Linhas"
  ];

  var lista_combo_retorno;

  calcular_total_combo(List<Combo> lista_combo, int classe_cliente, int tipo_cliente, bool cliente_score, bool cliente_unifique){
    if(tipo_cliente == 0){//PF
      var retorno_combo = calcular_pf(lista_combo, classe_cliente, tipo_cliente, cliente_score, cliente_unifique);
      return [retorno_combo[0], retorno_combo[1], retorno_combo[2]];
    }
    else{//PJ
      var retorno_combo = calcular_pj(lista_combo, classe_cliente, tipo_cliente, cliente_score, cliente_unifique);
      return [retorno_combo[0], retorno_combo[1], retorno_combo[2], retorno_combo[3], retorno_combo[4]];
    }
  }

  calcular_pf(List<Combo> lista_combo, int classe_cliente, int tipo_cliente, bool cliente_score, bool cliente_unifique){
    ValoresPF v = ValoresPF();
    List<ComboValorPF> calculo = [];

    if(cliente_score || cliente_unifique){
      switch(classe_cliente){
        case 0:
          calculo = v.combo_cli_0;
          break;
        case 1:
          calculo = v.combo_cli_1;
          break;
        case 2:
          calculo = v.combo_cli_2;
          break;
        case 3:
          calculo = v.combo_cli_3;
          break;
        case 4:
          calculo = v.combo_cli_4;
          break;
        case 5:
          calculo = v.combo_cli_5;
          break;
        case 6:
          calculo = v.combo_cli_6;
          break;
        case 99:
          calculo = v.combo_cli_99;
          break;
      }
    }
    else{
      calculo = v.combo_cli_inad;
    }

    num mensalidade_item = 0.0;
    num mensalidade_total = 0.0;
    num valor_adesao = 0.0;
    num valor_adesao_sem_fid = 0.0;

    for (int i = 0; i < lista_combo.length; i++) {
      try{
        ComboValorPF valores = calculo.firstWhere((e) => e.plano == lista_combo[i].plano);
        mensalidade_item = valores.mensal;
        valor_adesao += valores.adesao_cf;
        valor_adesao_sem_fid += valores.adesao_sf;
      }catch(e){
        continue;
      }
      mensalidade_total+=mensalidade_item;
      lista_combo[i].mensalidade = mensalidade_item;
    }
    lista_combo_retorno = lista_combo;
    return [valor_adesao, valor_adesao_sem_fid, mensalidade_total];
  }

  calcular_pj(List<Combo> lista_combo, int classe_cliente, int tipo_cliente, bool cliente_score, bool cliente_unifique){
    ValoresPJ v = ValoresPJ();
    List<ComboValorPJ> calculo = [];

    if(cliente_score || cliente_unifique){
      switch(classe_cliente){
        case 0:
          calculo = v.combo_cli_0;
          break;
        case 1:
          calculo = v.combo_cli_1;
          break;
        case 2:
          calculo = v.combo_cli_2;
          break;
        case 3:
          calculo = v.combo_cli_3;
          break;
        case 4:
          calculo = v.combo_cli_4;
          break;
        case 5:
          calculo = v.combo_cli_5;
          break;
        case 6:
          calculo = v.combo_cli_6;
          break;
        case 99:
          calculo = v.combo_cli_99;
          break;
      }
    }
    else{
      calculo = v.combo_cli_inad;
    }

    num mensalidade_item_12meses = 0.0;
    num mensalidade_item_24meses = 0.0;
    num mensalidade_total_12meses = 0.0;
    num mensalidade_total_24meses = 0.0;
    num valor_adesao_12 = 0.0;
    num valor_adesao_24 = 0.0;
    num valor_adesao_sem_fid = 0.0;

    for (int i = 0; i < lista_combo.length; i++) {
      try{
        //VERIFICAR A PARTE DE FIDELIDADE
        ComboValorPJ valores_24 = calculo.firstWhere((e) => e.plano == lista_combo[i].plano && e.fidelidade == "24 meses");
        mensalidade_item_24meses = valores_24.mensal;
        valor_adesao_24 += valores_24.adesao_cf;
        ComboValorPJ valores_12 = calculo.firstWhere((e) => e.plano == lista_combo[i].plano && e.fidelidade == "12 meses");
        mensalidade_item_12meses = valores_12.mensal;
        valor_adesao_12 += valores_12.adesao_cf;
        valor_adesao_sem_fid += valores_24.adesao_sf;
      }catch(e){
        continue;
      }
      mensalidade_total_24meses+=mensalidade_item_24meses;
      mensalidade_total_12meses+=mensalidade_item_12meses;
      lista_combo[i].mensalidade = mensalidade_item_24meses;
    }
    lista_combo_retorno = lista_combo;
    return [valor_adesao_24, valor_adesao_sem_fid, mensalidade_total_24meses, valor_adesao_12, mensalidade_total_12meses];
  }

  List<ComboMostrar> preparar_lista_combo(List<Combo> lista_combo){
    List<ComboMostrar>combo_lista = [];
    for(Combo item in lista_combo){
      if(combo_lista.length == 0){
        ComboMostrar novo = ComboMostrar();
        novo.plano = item.plano;
        novo.qtd = 1;
        combo_lista.add(novo);
      }
      else{
        String plano_atual = item.plano;
        int ind_enc = -1;
        for(int i = 0; i < combo_lista.length; i++){
          if(combo_lista[i].plano == plano_atual){
            ind_enc = i;
          }
        }
        if(ind_enc != -1){
          ComboMostrar ja_existe = combo_lista[ind_enc];
          int indice = combo_lista.indexOf(ja_existe);
          int nova_qtd = ja_existe.qtd + 1;
          ja_existe.qtd = nova_qtd;
          combo_lista[indice] = ja_existe;
        }
        else{
          ComboMostrar novo = ComboMostrar();
          novo.plano = item.plano;
          novo.qtd = 1;
          combo_lista.add(novo);
        }
      }
    }
    return combo_lista;
  }
}
class ComposicaoCombo{
  String _nome_combo = "";
  String _internet = "";
  String _tv = "";
  String _telefone = "";

  String get nome_combo => _nome_combo;

  set nome_combo(String value) {
    _nome_combo = value;
  }

  String get internet => _internet;

  set internet(String value) {
    _internet = value;
  }

  String get tv => _tv;

  set tv(String value) {
    _tv = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  ComposicaoCombo.vazio();
  ComposicaoCombo.dois_itens(this._nome_combo, this._internet, this._tv);
  ComposicaoCombo.tres_itens(this._nome_combo, this._internet, this._tv, this._telefone);
  ComposicaoCombo.pj(this._nome_combo, this._internet, this._telefone);
}

class ComboMostrar extends Combo{
  int qtd = 0;
}