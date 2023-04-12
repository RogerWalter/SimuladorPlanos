import 'ValoresPF.dart';
import 'ValoresPJ.dart';

class Telemedicina{
  String _plano = "";
  num _valor_mensalidade = 0;
  String _cliente_unifique = "";

  List<String> lista_plano_pf = ["", "Básico Individual", "Básico Família", "Avançado Individual", "Avançado Família", "Premium Individual", "Premium Família"];
  List<String> lista_plano_pj = ["", "Básico Individual", "Básico Família", "Avançado Família", "Premium Família"];
  List<String> cli_unifique = ["", "Não", "Sim"];

  String msg_excluir = "Deseja realmente remover todos os plano de Telemedicina?";
  String titulo_excluir = "Remover Telemedicina";

  String get plano => _plano;

  set plano(String value) {
    _plano = value;
  }

  num get valor_mensalidade => _valor_mensalidade;

  set valor_mensalidade(num value) {
    _valor_mensalidade = value;
  }


  String get cliente_unifique => _cliente_unifique;

  set cliente_unifique(String value) {
    _cliente_unifique = value;
  }

  var lista_telemedicina_retorno;
  calcular_total_telemedicina(var lista_telemedicina, int classe_cliente, int tipo_cliente){
    if(tipo_cliente == 0){//PF
      var retorno_telemedicina = calcular_pf(lista_telemedicina, classe_cliente, tipo_cliente);
      return [retorno_telemedicina[0], retorno_telemedicina[1], retorno_telemedicina[2]];
    }
    else{//PJ
      var retorno_telemedicina = calcular_pj(lista_telemedicina, classe_cliente, tipo_cliente);
      return [retorno_telemedicina[0], retorno_telemedicina[1], retorno_telemedicina[2]];
    }
  }

  calcular_pf(var lista_telemedicina, int classe_cliente, int tipo_cliente){
    ValoresPF v = ValoresPF();
    List<TelemedValorPF> valores = [];
    TelemedValorPF calculo = TelemedValorPF.vazio();
    switch(classe_cliente){
      case 0:
        valores = v.telemed_cli_0;
        break;
      case 1:
        valores = v.telemed_cli_1;
        break;
      case 2:
        valores = v.telemed_cli_2;
        break;
      case 3:
        valores = v.telemed_cli_3;
        break;
      case 4:
        valores = v.telemed_cli_4;
        break;
      case 5:
        valores = v.telemed_cli_5;
        break;
      case 6:
        valores = v.telemed_cli_6;
        break;
      case 99:
        valores = v.telemed_cli_99;
        break;
    }
    num mensalidade_item = 0.0;
    num mensalidade_total = 0.0;
    num valor_adesao = 0.0;
    num valor_adesao_sem_fid = 0.0;
    for(int i = 0; i < lista_telemedicina.length; i++){
      calculo = valores.firstWhere((e) => e.plano == lista_telemedicina[i].plano);
      if(lista_telemedicina[i].cliente_unifique == "Sim")
        mensalidade_item = calculo.mensal_cli_uni;
      else
        mensalidade_item = calculo.mensal;
      mensalidade_total+=mensalidade_item;
      valor_adesao+=calculo.adesao_cf;
      valor_adesao_sem_fid+=calculo.adesao_sf;
      lista_telemedicina[i].valor_mensalidade = mensalidade_item;
    }
    lista_telemedicina_retorno = lista_telemedicina;
    return [valor_adesao, valor_adesao_sem_fid, mensalidade_total];
  }

  calcular_pj(var lista_telemedicina, int classe_cliente, int tipo_cliente){
    ValoresPJ v = ValoresPJ();
    List<TelemedValorPJ> calculo = [];
    TelemedValorPJ valores = TelemedValorPJ.vazio();

    switch(classe_cliente){
      case 0:
        calculo = v.telemed_cli_0;
        break;
      case 1:
        calculo = v.telemed_cli_1;
        break;
      case 2:
        calculo = v.telemed_cli_2;
        break;
      case 3:
        calculo = v.telemed_cli_3;
        break;
      case 4:
        calculo = v.telemed_cli_4;
        break;
      case 5:
        calculo = v.telemed_cli_5;
        break;
      case 6:
        calculo = v.telemed_cli_6;
        break;
      case 99:
        calculo = v.telemed_cli_99;
        break;
    }
    num mensalidade_item = 0.0;
    num mensal_bas_ind = 0.0;
    num mensal_bas_fam = 0.0;
    num mensal_avn_fam = 0.0;
    num mensal_prm_fam = 0.0;
    num mensalidade_total = 0.0;
    num valor_adesao = 0.0;
    num valor_adesao_sem_fid = 0.0;

    int qtd_bas_ind = lista_telemedicina.where((e) => e._plano == "Básico Individual").length;
    int qtd_bas_fam = lista_telemedicina.where((e) => e._plano == "Básico Família").length;
    int qtd_avn_fam = lista_telemedicina.where((e) => e._plano == "Avançado Família").length;
    int qtd_prm_fam = lista_telemedicina.where((e) => e._plano == "Premium Família").length;

    if(qtd_bas_ind > 0){
      valores = calculo.firstWhere((e) => e.plano == "Básico Individual");
      num ades_cf_parcial_bas_ind = 0;
      num ades_sf_parcial_bas_ind = 0;
      num mensalidade_bas_ind = 0;
      ades_cf_parcial_bas_ind = qtd_bas_ind * valores.adesao_cf;
      ades_sf_parcial_bas_ind = qtd_bas_ind * valores.adesao_sf;
      if(qtd_bas_ind > 0 && qtd_bas_ind < 10){//1 a 9 licenças
        mensal_bas_ind = valores.mensal_1_a_9;
        mensalidade_bas_ind = valores.mensal_1_a_9 * qtd_bas_ind;
      }
      if(qtd_bas_ind >= 10 && qtd_bas_ind < 20){//10 a 19 licenças
        mensal_bas_ind = valores.mensal_10_a_19;
        mensalidade_bas_ind = valores.mensal_10_a_19 * qtd_bas_ind;
      }
      if(qtd_bas_ind > 19){//20 ou mais licenças
        mensal_bas_ind = valores.mensal_20_mais;
        mensalidade_bas_ind = valores.mensal_20_mais * qtd_bas_ind;
      }
      valor_adesao+=ades_cf_parcial_bas_ind;
      valor_adesao_sem_fid+=ades_sf_parcial_bas_ind;
      mensalidade_total+= mensalidade_bas_ind;
    }
    if(qtd_bas_fam > 0){
      valores = calculo.firstWhere((e) => e.plano == "Básico Família");
      num ades_cf_parcial_bas_fam = 0;
      num ades_sf_parcial_bas_fam = 0;
      num mensalidade_bas_fam = 0;
      ades_cf_parcial_bas_fam = valores.adesao_cf * qtd_bas_fam;
      ades_sf_parcial_bas_fam = valores.adesao_sf * qtd_bas_fam;
      if(qtd_bas_fam > 0 && qtd_bas_fam < 10){//1 a 9 licenças
        mensal_bas_fam = valores.mensal_1_a_9;
        mensalidade_bas_fam = valores.mensal_1_a_9 * qtd_bas_fam;
      }
      if(qtd_bas_fam >= 10 && qtd_bas_fam < 20){//10 a 19 licenças
        mensal_bas_fam = valores.mensal_10_a_19;
        mensalidade_bas_fam = valores.mensal_10_a_19 * qtd_bas_fam;
      }
      if(qtd_bas_fam > 19){//20 ou mais licenças
        mensal_bas_fam = valores.mensal_20_mais;
        mensalidade_bas_fam = valores.mensal_20_mais * qtd_bas_fam;
      }
      valor_adesao+=ades_cf_parcial_bas_fam;
      valor_adesao_sem_fid+=ades_sf_parcial_bas_fam;
      mensalidade_total+= mensalidade_bas_fam;
    }
    if(qtd_avn_fam > 0){
      valores = calculo.firstWhere((e) => e.plano == "Avançado Família");
      num ades_cf_parcial_avn_fam = 0;
      num ades_sf_parcial_avn_fam = 0;
      num mensalidade_avn_fam = 0;
      ades_cf_parcial_avn_fam = valores.adesao_cf * qtd_avn_fam;
      ades_sf_parcial_avn_fam = valores.adesao_sf * qtd_avn_fam;
      if(qtd_avn_fam > 0 && qtd_avn_fam < 10){//1 a 9 licenças
        mensal_avn_fam = valores.mensal_1_a_9;
        mensalidade_avn_fam = valores.mensal_1_a_9 * qtd_avn_fam;
      }
      if(qtd_avn_fam >= 10 && qtd_avn_fam < 20){//10 a 19 licenças
        mensal_avn_fam = valores.mensal_10_a_19;
        mensalidade_avn_fam = valores.mensal_10_a_19 * qtd_avn_fam;
      }
      if(qtd_avn_fam > 19){//20 ou mais licenças
        mensal_avn_fam = valores.mensal_20_mais;
        mensalidade_avn_fam = valores.mensal_20_mais * qtd_avn_fam;
      }
      valor_adesao+=ades_cf_parcial_avn_fam;
      valor_adesao_sem_fid+=ades_sf_parcial_avn_fam;
      mensalidade_total+= mensalidade_avn_fam;
    }
    if(qtd_prm_fam > 0){
      valores = calculo.firstWhere((e) => e.plano == "Premium Família");
      num ades_cf_parcial_prm_fam = 0;
      num ades_sf_parcial_prm_fam = 0;
      num mensalidade_prm_fam = 0;
      ades_cf_parcial_prm_fam = valores.adesao_cf * qtd_prm_fam;
      ades_sf_parcial_prm_fam = valores.adesao_sf * qtd_prm_fam;
      if(qtd_prm_fam > 0 && qtd_prm_fam < 10){//1 a 9 licenças
        mensal_prm_fam = valores.mensal_1_a_9;
        mensalidade_prm_fam = valores.mensal_1_a_9 * qtd_prm_fam;
      }
      if(qtd_prm_fam >= 10 && qtd_prm_fam < 20){//10 a 19 licenças
        mensal_prm_fam = valores.mensal_10_a_19;
        mensalidade_prm_fam = valores.mensal_10_a_19 * qtd_prm_fam;
      }
      if(qtd_prm_fam > 19){//20 ou mais licenças
        mensal_prm_fam = valores.mensal_20_mais;
        mensalidade_prm_fam = valores.mensal_20_mais * qtd_prm_fam;
      }
      valor_adesao+=ades_cf_parcial_prm_fam;
      valor_adesao_sem_fid+=ades_sf_parcial_prm_fam;
      mensalidade_total+= mensalidade_prm_fam;
    }
    for(int i = 0; i < lista_telemedicina.length; i++){
      if(lista_telemedicina[i].plano == "Básico Individual")
        mensalidade_item = mensal_bas_ind;
      if(lista_telemedicina[i].plano == "Básico Família")
        mensalidade_item = mensal_bas_fam;
      if(lista_telemedicina[i].plano == "Avançado Família")
        mensalidade_item = mensal_avn_fam;
      if(lista_telemedicina[i].plano == "Premium Família")
        mensalidade_item = mensal_prm_fam;
      lista_telemedicina[i].valor_mensalidade = mensalidade_item;
    }
    lista_telemedicina_retorno = lista_telemedicina;
    return [valor_adesao, valor_adesao_sem_fid, mensalidade_total];
  }

  List<TelemedicinaMostrar> preparar_lista_telemedicina(List<Telemedicina> lista_telemedicina){
    List<TelemedicinaMostrar>telemedicina_lista = [];
    for(Telemedicina item in lista_telemedicina){
      if(telemedicina_lista.length == 0){
        TelemedicinaMostrar novo = TelemedicinaMostrar();
        novo.plano = item.plano;
        novo.qtd = 1;
        telemedicina_lista.add(novo);
      }
      else{
        String plano_atual = item.plano;
        int ind_enc = -1;
        for(int i = 0; i < telemedicina_lista.length; i++){
          if(telemedicina_lista[i].plano == plano_atual){
            ind_enc = i;
          }
        }
        if(ind_enc != -1){
          TelemedicinaMostrar ja_existe = telemedicina_lista[ind_enc];
          int indice = telemedicina_lista.indexOf(ja_existe);
          int nova_qtd = ja_existe.qtd + 1;
          ja_existe.qtd = nova_qtd;
          telemedicina_lista[indice] = ja_existe;
        }
        else{
          TelemedicinaMostrar novo = TelemedicinaMostrar();
          novo.plano = item.plano;
          novo.qtd = 1;
          telemedicina_lista.add(novo);
        }
      }
    }
    return telemedicina_lista;
  }
}

class TelemedicinaMostrar extends Telemedicina{
  int qtd = 0;
}