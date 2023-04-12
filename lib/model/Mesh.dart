import 'package:simulador_unifique/model/ValoresPF.dart';
import 'package:simulador_unifique/model/ValoresPJ.dart';

class Mesh{
  String _tipo = "";
  num _valor_mensalidade = 29;

  List<String> lista_tipo = ["", "Instalação Padrão"];

  String msg_excluir = "Deseja realmente remover todos os equipamentos de Mesh?";
  String titulo_excluir = "Remover Mesh";

  Mesh();

  String get tipo => _tipo;

  set tipo(String value) {
    _tipo = value;
  }

  num get valor_mensalidade => _valor_mensalidade;

  set valor_mensalidade(num value) {
    _valor_mensalidade = value;
  }

  var lista_mesh_retorno;

  calcular_total_mesh(List<Mesh> lista_mesh, int classe_cliente, int tipo_cliente){
    var v;
    if(tipo_cliente == 0){//PESSOA FISICA
      ValoresPF pf = ValoresPF();
      v = pf;
    }
    else{//PESSOA JURIDICA
      ValoresPJ pj = ValoresPJ();
      v = pj;
    }

    num adesao_com_fidelidade = 0;
    num adesao_sem_fidelidade = 0;
    num mensalidade = 0;

    for(Mesh item in lista_mesh){
      //com fidelidade, não temos taxa de adesão
      adesao_sem_fidelidade+=v.mesh_sem_fid;
    }

    switch(classe_cliente) {
      case 0: {
        num mensalidade_classe = v.mesh_cli_0_mens;
        for(int i = 0; i < lista_mesh.length; i++){
          mensalidade+=mensalidade_classe;
          lista_mesh[i].valor_mensalidade = mensalidade_classe;
        }
      }
      break;

      case 1: {
        num mensalidade_classe = v.mesh_cli_1_mens;
        for(int i = 0; i < lista_mesh.length; i++){
          mensalidade+=mensalidade_classe;
          lista_mesh[i].valor_mensalidade = mensalidade_classe;
        }
      }
      break;

      case 2: {
        num mensalidade_classe = v.mesh_cli_2_mens;
        for(int i = 0; i < lista_mesh.length; i++){
          mensalidade+=mensalidade_classe;
          lista_mesh[i].valor_mensalidade = mensalidade_classe;
        }
      }
      break;

      case 3: {
        num mensalidade_classe = v.mesh_cli_3_mens;
        for(int i = 0; i < lista_mesh.length; i++){
          mensalidade+=mensalidade_classe;
          lista_mesh[i].valor_mensalidade = mensalidade_classe;
        }
      }
      break;

      case 4: {
        num mensalidade_classe = v.mesh_cli_4_mens;
        for(int i = 0; i < lista_mesh.length; i++){
          mensalidade+=mensalidade_classe;
          lista_mesh[i].valor_mensalidade = mensalidade_classe;
        }
      }
      break;

      case 5: {
        num mensalidade_classe = v.mesh_cli_5_mens;
        for(int i = 0; i < lista_mesh.length; i++){
          mensalidade+=mensalidade_classe;
          lista_mesh[i].valor_mensalidade = mensalidade_classe;
        }
      }
      break;

      case 6: {
        num mensalidade_classe = v.mesh_cli_6_mens;
        for(int i = 0; i < lista_mesh.length; i++){
          mensalidade+=mensalidade_classe;
          lista_mesh[i].valor_mensalidade = mensalidade_classe;
        }
      }
      break;

      case 99: {
        num mensalidade_classe = v.mesh_cli_99_mens;
        for(int i = 0; i < lista_mesh.length; i++){
          mensalidade+=mensalidade_classe;
          lista_mesh[i].valor_mensalidade = mensalidade_classe;
        }
      }
      break;

      default: {
        adesao_com_fidelidade = 0;
        adesao_sem_fidelidade = 0;
        mensalidade = 0;
        for(Mesh update in lista_mesh){
          update.valor_mensalidade = mensalidade;
        }
      }
      break;
    }
    lista_mesh_retorno = lista_mesh;
    return [adesao_com_fidelidade, adesao_sem_fidelidade, mensalidade];
  }

  List<MeshMostrar> preparar_lista_mesh(List<Mesh> lista_mesh){
    List<MeshMostrar>mesh_lista = [];
    for(Mesh item in lista_mesh){
      if(mesh_lista.length == 0){
        MeshMostrar novo = MeshMostrar();
        novo.tipo = item.tipo;
        novo.qtd = 1;
        mesh_lista.add(novo);
      }
      else{
        String plano_atual = item.tipo;
        int ind_enc = -1;
        for(int i = 0; i < mesh_lista.length; i++){
          if(mesh_lista[i].tipo == plano_atual){
            ind_enc = i;
          }
        }
        if(ind_enc != -1){
          MeshMostrar ja_existe = mesh_lista[ind_enc];
          int indice = mesh_lista.indexOf(ja_existe);
          int nova_qtd = ja_existe.qtd + 1;
          ja_existe.qtd = nova_qtd;
          mesh_lista[indice] = ja_existe;
        }
        else{
          MeshMostrar novo = MeshMostrar();
          novo.tipo = item.tipo;
          novo.qtd = 1;
          mesh_lista.add(novo);
        }
      }
    }
    return mesh_lista;
  }
}

class MeshMostrar extends Mesh{
  int qtd = 0;
}