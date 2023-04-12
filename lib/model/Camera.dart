import 'package:simulador_unifique/model/ValoresPF.dart';
import 'package:simulador_unifique/model/ValoresPJ.dart';

class Camera{
  String _tipo = ""; //interna/externa/exposta
  String _armaz = "";
  String _licen = "";
  num _valor_mensalidade = 0.0;

  List<String> lista_tipo = ["", "Interna", "Externa", "Exposta"];

  List<String> lista_armz = ["", "1 dia", "3 dias", "7 dias", "15 dias", "30 dias"];

  List<String> lista_lice = ["", "Padrão"];

  String msg_excluir = "Deseja realmente remover todas as câmeras?";
  String titulo_excluir = "Remover Câmeras";

  num get valor_mensalidade => _valor_mensalidade;

  set valor_mensalidade(num value) {
    _valor_mensalidade = value;
  }

  Camera();

  String get tipo => _tipo;

  set tipo(String value) {
    _tipo = value;
  }

  String get licen => _licen;

  set licen(String value) {
    _licen = value;
  }

  String get armaz => _armaz;

  set armaz(String value) {
    _armaz = value;
  }

  var lista_camera_retorno;



  calcular_total_cameras(List<Camera> lista_camera, int classe_cliente, int tipoCliente){
    if(lista_camera == 0){//PF
      var retorno_combo = calcular_pf(lista_camera, classe_cliente, tipoCliente);
      return [retorno_combo[0], retorno_combo[1], retorno_combo[2]];
    }
    else{//PJ
      var retorno_combo = calcular_pj(lista_camera, classe_cliente, tipoCliente);
      return [retorno_combo[0], retorno_combo[1], retorno_combo[2]];
    }
  }

  calcular_pf(List<Camera> lista_camera, int classe_cliente, int tipoCliente){
    ValoresPF v = ValoresPF();
    CameraValoresPF calculo = CameraValoresPF.vazio();
    switch(classe_cliente){
      case 0:
        calculo = v.cam_cli_0;
        break;
      case 1:
        calculo = v.cam_cli_1;
        break;
      case 2:
        calculo = v.cam_cli_2;
        break;
      case 3:
        calculo = v.cam_cli_3;
        break;
      case 4:
        calculo = v.cam_cli_4;
        break;
      case 5:
        calculo = v.cam_cli_5;
        break;
      case 6:
        calculo = v.cam_cli_6;
        break;
      case 99:
        calculo = v.cam_cli_99;
        break;
    }
    num adesao_com_fidelidade = 0;
    num adesao_sem_fidelidade = 0;
    num mensalidade = 0;

    //calculo adesão
    num valor_adesao = 0;
    num valor_adesao_sem_fid = 0;
    int qtd_exposta = 0; //verificar se tem exposta

    for(Camera item in lista_camera){
      if(item.tipo == "Exposta")
        qtd_exposta++;
    }
    if(qtd_exposta > 0){
      if(lista_camera.length == 1){
        num parcial = lista_camera.length * calculo.cam_ades_1;
        num exposta = qtd_exposta * calculo.cam_exposta;
        valor_adesao = parcial + exposta;
      }
      if(lista_camera.length == 2 || lista_camera.length == 3){
        num parcial = lista_camera.length * calculo.cam_ades_2_ou_3;
        num exposta = qtd_exposta * calculo.cam_exposta;
        valor_adesao = parcial + exposta;
      }
      if(lista_camera.length > 3){
        num parcial = lista_camera.length * calculo.cam_ades_4_mais;
        num exposta = qtd_exposta * calculo.cam_exposta;
        valor_adesao = parcial + exposta;
      }
    }
    else{
      if(lista_camera.length == 1){
        valor_adesao = lista_camera.length * calculo.cam_ades_1;
      }
      if(lista_camera.length == 2 || lista_camera.length == 3){
        valor_adesao = lista_camera.length * calculo.cam_ades_2_ou_3;
      }
      if(lista_camera.length > 3){
        valor_adesao = lista_camera.length * calculo.cam_ades_4_mais;
      }
    }
    //valor adesão sem fidelidade
    valor_adesao_sem_fid = lista_camera.length * calculo.cam_ades_sem_fid;

    adesao_com_fidelidade = valor_adesao;
    adesao_sem_fidelidade = valor_adesao_sem_fid;

    int qtd_1_dia = 0;
    num valor_1_dia = 0;
    int qtd_3_dia = 0;
    num valor_3_dia = 0;
    int qtd_7_dia = 0;
    num valor_7_dia = 0;
    int qtd_15_dia = 0;
    num valor_15_dia = 0;
    int qtd_30_dia = 0;
    num valor_30_dia = 0;

    for(Camera item in lista_camera){
      if(item.armaz == "1 dia")
        qtd_1_dia++;
      if(item.armaz == "3 dias")
        qtd_3_dia++;
      if(item.armaz == "7 dias")
        qtd_7_dia++;
      if(item.armaz == "15 dias")
        qtd_15_dia++;
      if(item.armaz == "30 dias")
        qtd_30_dia++;
    }

    if(qtd_1_dia > 0){
      valor_1_dia = qtd_1_dia * calculo.cam_amz_1_dia;
    }
    if(qtd_3_dia > 0){
      valor_3_dia = qtd_3_dia * calculo.cam_amz_3_dia;
    }
    if(qtd_7_dia > 0){
      valor_7_dia = qtd_7_dia * calculo.cam_amz_7_dia;
    }
    if(qtd_15_dia > 0){
      valor_15_dia = qtd_15_dia * calculo.cam_amz_15_dia;
    }
    if(qtd_30_dia > 0){
      valor_30_dia = qtd_30_dia * calculo.cam_amz_30_dia;
    }

    mensalidade = valor_1_dia + valor_3_dia + valor_7_dia + valor_15_dia + valor_30_dia;

    for(Camera update in lista_camera){
      if(update.armaz == "1 dia"){
        update.valor_mensalidade = calculo.cam_amz_1_dia;
      }
      if(update.armaz == "3 dias"){
        update.valor_mensalidade = calculo.cam_amz_3_dia;
      }
      if(update.armaz == "7 dias"){
        update.valor_mensalidade = calculo.cam_amz_7_dia;
      }
      if(update.armaz == "15 dias"){
        update.valor_mensalidade = calculo.cam_amz_15_dia;
      }
      if(update.armaz == "30 dias"){
        update.valor_mensalidade = calculo.cam_amz_30_dia;
      }
    }

    lista_camera_retorno = lista_camera;
    return [adesao_com_fidelidade, adesao_sem_fidelidade, mensalidade];
  }

  calcular_pj(List<Camera> lista_camera, int classe_cliente, int tipoCliente){
    ValoresPJ v = ValoresPJ();
    CameraValoresPJ calculo = CameraValoresPJ.vazio();
    switch(classe_cliente){
      case 0:
        calculo = v.cam_cli_0;
        break;
      case 1:
        calculo = v.cam_cli_1;
        break;
      case 2:
        calculo = v.cam_cli_2;
        break;
      case 3:
        calculo = v.cam_cli_3;
        break;
      case 4:
        calculo = v.cam_cli_4;
        break;
      case 5:
        calculo = v.cam_cli_5;
        break;
      case 6:
        calculo = v.cam_cli_6;
        break;
      case 99:
        calculo = v.cam_cli_99;
        break;
    }
    num adesao_com_fidelidade = 0;
    num adesao_sem_fidelidade = 0;
    num mensalidade = 0;

    //calculo adesão
    num valor_adesao = 0;
    num valor_adesao_sem_fid = 0;
    int qtd_exposta = 0; //verificar se tem exposta

    for(Camera item in lista_camera){
      if(item.tipo == "Exposta")
        qtd_exposta++;
    }
    if(qtd_exposta > 0){
      if(lista_camera.length == 1){
        num parcial = lista_camera.length * calculo.cam_ades_1;
        num exposta = qtd_exposta * calculo.cam_exposta;
        valor_adesao = parcial + exposta;
      }
      if(lista_camera.length == 2 || lista_camera.length == 3){
        num parcial = lista_camera.length * calculo.cam_ades_2_ou_3;
        num exposta = qtd_exposta * calculo.cam_exposta;
        valor_adesao = parcial + exposta;
      }
      if(lista_camera.length > 3){
        num parcial = lista_camera.length * calculo.cam_ades_4_mais;
        num exposta = qtd_exposta * calculo.cam_exposta;
        valor_adesao = parcial + exposta;
      }
    }
    else{
      if(lista_camera.length == 1){
        valor_adesao = lista_camera.length * calculo.cam_ades_1;
      }
      if(lista_camera.length == 2 || lista_camera.length == 3){
        valor_adesao = lista_camera.length * calculo.cam_ades_2_ou_3;
      }
      if(lista_camera.length > 3){
        valor_adesao = lista_camera.length * calculo.cam_ades_4_mais;
      }
    }
    //valor adesão sem fidelidade
    valor_adesao_sem_fid = lista_camera.length * calculo.cam_ades_sem_fid;

    adesao_com_fidelidade = valor_adesao;
    adesao_sem_fidelidade = valor_adesao_sem_fid;

    int qtd_1_dia = 0;
    num valor_1_dia = 0;
    int qtd_3_dia = 0;
    num valor_3_dia = 0;
    int qtd_7_dia = 0;
    num valor_7_dia = 0;
    int qtd_15_dia = 0;
    num valor_15_dia = 0;
    int qtd_30_dia = 0;
    num valor_30_dia = 0;

    for(Camera item in lista_camera){
      if(item.armaz == "1 dia")
        qtd_1_dia++;
      if(item.armaz == "3 dias")
        qtd_3_dia++;
      if(item.armaz == "7 dias")
        qtd_7_dia++;
      if(item.armaz == "15 dias")
        qtd_15_dia++;
      if(item.armaz == "30 dias")
        qtd_30_dia++;
    }

    if(qtd_1_dia > 0){
      valor_1_dia = qtd_1_dia * calculo.cam_amz_1_dia;
    }
    if(qtd_3_dia > 0){
      valor_3_dia = qtd_3_dia * calculo.cam_amz_3_dia;
    }
    if(qtd_7_dia > 0){
      valor_7_dia = qtd_7_dia * calculo.cam_amz_7_dia;
    }
    if(qtd_15_dia > 0){
      valor_15_dia = qtd_15_dia * calculo.cam_amz_15_dia;
    }
    if(qtd_30_dia > 0){
      valor_30_dia = qtd_30_dia * calculo.cam_amz_30_dia;
    }

    mensalidade = valor_1_dia + valor_3_dia + valor_7_dia + valor_15_dia + valor_30_dia;

    for(Camera update in lista_camera){
      if(update.armaz == "1 dia"){
        update.valor_mensalidade = calculo.cam_amz_1_dia;
      }
      if(update.armaz == "3 dias"){
        update.valor_mensalidade = calculo.cam_amz_3_dia;
      }
      if(update.armaz == "7 dias"){
        update.valor_mensalidade = calculo.cam_amz_7_dia;
      }
      if(update.armaz == "15 dias"){
        update.valor_mensalidade = calculo.cam_amz_15_dia;
      }
      if(update.armaz == "30 dias"){
        update.valor_mensalidade = calculo.cam_amz_30_dia;
      }
    }

    lista_camera_retorno = lista_camera;
    return [adesao_com_fidelidade, adesao_sem_fidelidade, mensalidade];
  }

  List<CameraMostrar> preparar_lista_camera(List<Camera> lista_camera){
    List<CameraMostrar>camera_lista = [];
    for(Camera item in lista_camera){
      if(camera_lista.length == 0){
        CameraMostrar nova = CameraMostrar();
        nova.armaz = item.armaz;
        nova.tipo = item.tipo;
        nova.licen = item.licen;
        nova.qtd = 1;
        camera_lista.add(nova);
      }
      else{
        String tipo_atual = item.tipo;
        String armz_atual = item.armaz;
        String lice_atual = item.licen;
        int ind_enc = -1;
        for(int i = 0; i < camera_lista.length; i++){
          if(camera_lista[i].tipo == tipo_atual){
            if(camera_lista[i].armaz == armz_atual){
              if(camera_lista[i].licen == lice_atual){
                ind_enc = i;
              }
            }
          }
        }
        if(ind_enc != -1){
          CameraMostrar ja_existe = camera_lista[ind_enc];
          int indice = camera_lista.indexOf(ja_existe);
          int nova_qtd = ja_existe.qtd + 1;
          ja_existe.qtd = nova_qtd;
          camera_lista[indice] = ja_existe;
        }
        else{
          CameraMostrar nova = CameraMostrar();
          nova.armaz = item.armaz;
          nova.tipo = item.tipo;
          nova.licen = item.licen;
          nova.qtd = 1;
          camera_lista.add(nova);
        }
      }
    }
    return camera_lista;
  }
}

class CameraMostrar extends Camera{
  int qtd = 0;
}