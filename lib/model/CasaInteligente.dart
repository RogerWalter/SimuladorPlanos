import 'ValoresPF.dart';
import 'ValoresPJ.dart';

class CasaInteligente{
  String _plano = "";
  num _mensalidade = 0.0;

  CasaInteligente.vazio();

  CasaInteligente();

  String get plano => _plano;

  set plano(String value) {
    _plano = value;
  }

  num get mensalidade => _mensalidade;

  set mensalidade(num value) {
    _mensalidade = value;
  }

  String msg_excluir = "Deseja realmente remover todos os itens de Casa Inteligente?";
  String titulo_excluir = "Remover Casa Inteligente";

  List<String> casa_planos = [
    "",
    "Kit 1 Cômodo",
    "Kit 3 Cômodos",
    "Kit 8 Cômodos",
    "Mind Plus",
    "Play",
    "Power"
  ];

  List<ComposicaoCasaIntel> kit_casa_inteligente = [
    ComposicaoCasaIntel("Kit 1 Cômodo", 1, 1, 0),
    ComposicaoCasaIntel("Kit 3 Cômodos", 1, 3, 1),
    ComposicaoCasaIntel("Kit 8 Cômodos", 1, 8, 3),
  ];

  var lista_casa_retorno;
  calcular_total_casa(List<CasaInteligente> lista_casa, int classe_cliente, int tipo_cliente){
    if(tipo_cliente == 0){//PF
      var retorno_casa = calcular_pf(lista_casa, classe_cliente, tipo_cliente);
      return [retorno_casa[0], retorno_casa[1], retorno_casa[2]];
    }
    else{//PJ
      var retorno_casa = calcular_pj(lista_casa, classe_cliente, tipo_cliente);
      return [retorno_casa[0], retorno_casa[1], retorno_casa[2]];
    }
  }

  calcular_pf(List<CasaInteligente> lista_casa, int classe_cliente, int tipo_cliente){
    ValoresPF v = ValoresPF();
    List<CasaIntelValorPF> valores = [];
    CasaIntelValorPF calculo = CasaIntelValorPF.vazio();
    switch(classe_cliente){
      case 0:
        valores = v.casa_cli_0;
        break;
      case 1:
        valores = v.casa_cli_1;
        break;
      case 2:
        valores = v.casa_cli_2;
        break;
      case 3:
        valores = v.casa_cli_3;
        break;
      case 4:
        valores = v.casa_cli_4;
        break;
      case 5:
        valores = v.casa_cli_5;
        break;
      case 6:
        valores = v.casa_cli_6;
        break;
      case 99:
        valores = v.casa_cli_99;
        break;
    }

    num mensalidade_item = 0.0;
    num mensalidade_total = 0.0;
    num valor_adesao = 0.0;
    num valor_adesao_sem_fid = 0.0;

    for(int i = 0; i < lista_casa.length; i++){
      calculo = valores.firstWhere((e) => e.plano == lista_casa[i].plano);
      mensalidade_item = calculo.mensal;
      mensalidade_total+=mensalidade_item;
      valor_adesao+=calculo.adesao_cf;
      valor_adesao_sem_fid+=calculo.adesao_sf;
      lista_casa[i].mensalidade = mensalidade_item;
    }
    lista_casa_retorno = lista_casa;
    return [valor_adesao, valor_adesao_sem_fid, mensalidade_total];
  }

  calcular_pj(List<CasaInteligente> lista_casa, int classe_cliente, int tipo_cliente){
    ValoresPJ v = ValoresPJ();
    List<CasaIntelValorPJ> valores = [];
    CasaIntelValorPJ calculo = CasaIntelValorPJ.vazio();
    switch(classe_cliente){
      case 0:
        valores = v.casa_cli_0;
        break;
      case 1:
        valores = v.casa_cli_1;
        break;
      case 2:
        valores = v.casa_cli_2;
        break;
      case 3:
        valores = v.casa_cli_3;
        break;
      case 4:
        valores = v.casa_cli_4;
        break;
      case 5:
        valores = v.casa_cli_5;
        break;
      case 6:
        valores = v.casa_cli_6;
        break;
      case 99:
        valores = v.casa_cli_99;
        break;
    }

    num mensalidade_item = 0.0;
    num mensalidade_total = 0.0;
    num valor_adesao = 0.0;
    num valor_adesao_sem_fid = 0.0;

    for(int i = 0; i < lista_casa.length; i++){
      calculo = valores.firstWhere((e) => e.plano == lista_casa[i].plano);
      mensalidade_item = calculo.mensal;
      mensalidade_total+=mensalidade_item;
      valor_adesao+=calculo.adesao_cf;
      valor_adesao_sem_fid+=calculo.adesao_sf;
      lista_casa[i].mensalidade = mensalidade_item;
    }

    lista_casa_retorno = lista_casa;
    return [valor_adesao, valor_adesao_sem_fid, mensalidade_total];
  }

  List<CasaMostrar> preparar_lista_casa(List<CasaInteligente> lista_casa){
    List<CasaMostrar>casa_lista = [];
    for(CasaInteligente item in lista_casa){
      if(casa_lista.length == 0){
        CasaMostrar novo = CasaMostrar();
        novo.plano = item.plano;
        novo.qtd = 1;
        casa_lista.add(novo);
      }
      else{
        String plano_atual = item.plano;
        int ind_enc = -1;
        for(int i = 0; i < casa_lista.length; i++){
          if(casa_lista[i].plano == plano_atual){
            ind_enc = i;
          }
        }
        if(ind_enc != -1){
          CasaMostrar ja_existe = casa_lista[ind_enc];
          int indice = casa_lista.indexOf(ja_existe);
          int nova_qtd = ja_existe.qtd + 1;
          ja_existe.qtd = nova_qtd;
          casa_lista[indice] = ja_existe;
        }
        else{
          CasaMostrar novo = CasaMostrar();
          novo.plano = item.plano;
          novo.qtd = 1;
          casa_lista.add(novo);
        }
      }
    }
    return casa_lista;
  }
}

class ComposicaoCasaIntel{
  String _plano = "";
  int _qtd_mind = 0;
  int _qtd_power = 0;
  int _qtd_play = 0;

  ComposicaoCasaIntel.vazio();
  ComposicaoCasaIntel(this._plano, this._qtd_mind, this._qtd_power, this._qtd_play);

  String get plano => _plano;

  set plano(String value) {
    _plano = value;
  }

  int get qtd_mind => _qtd_mind;

  set qtd_mind(int value) {
    _qtd_mind = value;
  }

  int get qtd_power => _qtd_power;

  set qtd_power(int value) {
    _qtd_power = value;
  }

  int get qtd_play => _qtd_play;

  set qtd_play(int value) {
    _qtd_play = value;
  }
}

class CasaMostrar extends CasaInteligente{
  int qtd = 0;
}