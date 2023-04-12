import 'package:another_flushbar/flushbar.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simulador_unifique/telas/DialogoSemAcesso.dart';

import '../firebase_options.dart';
import '../util/Controller.dart';
import '../util/Res.dart';
import 'DialogoCarregando.dart';
import 'Main.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simulador de Planos Unifique",
      theme: ThemeData(
          primaryColor: const Color(0xff232f66)
      ),
      home: Login(),
      ),
  );
}


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Controller controller = Get.put(Controller());
  Res res = Res();

  TextEditingController _controller_email = TextEditingController();
  FocusNode _foco_email = FocusNode();
  TextEditingController _controller_senha = TextEditingController();
  FocusNode _foco_senha = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifica_login();
  }

  @override
  Widget build(BuildContext context) {
    var largura = MediaQuery.of(context).size.width;
    var largura_widgets = (largura>1000) ? largura/5 : largura/1.25;
    return LayoutBuilder(
        builder: (context, constraints){
          var layout_largura = constraints.maxWidth;
          var layout_altura = constraints.maxHeight;
          if(layout_altura>500){
            return Scaffold(
                body: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/wallpaper-login.jpg'),
                            //colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.75), BlendMode.modulate,),
                            fit: BoxFit.cover
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 40)),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: largura_widgets,
                                  child: Image(image: AssetImage("assets/login-logo.png"), fit: BoxFit.contain,)
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            height: 40,
                            width: largura_widgets,
                            child: TextField(
                              controller: _controller_email,
                              focusNode: _foco_email,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              cursorColor: res.azul_escuro,
                              style: res.texto_bold_azul_16,
                              decoration: InputDecoration(
                                isDense: true,
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                counterText: "",
                                labelText: "Email",
                                labelStyle: res.texto_azul_16,
                                fillColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1, color: res.azul_escuro),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1, color: res.azul_escuro),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              onSubmitted: (content){

                              },
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            height: 40,
                            width: largura_widgets,
                            child: Obx(
                                () =>
                                  TextField(
                                    controller: _controller_senha,
                                    focusNode: _foco_senha,
                                    obscureText: controller.visibilidade_senha.value,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    cursorColor: res.azul_escuro,
                                    style: res.texto_bold_azul_16,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      counterText: "",
                                      labelText: "Senha",
                                      labelStyle: res.texto_azul_16,
                                      fillColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 1, color: res.azul_escuro),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 1, color: res.azul_escuro),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          controller.visibilidade_senha.value
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                          color: res.azul_escuro,
                                        ),
                                        onPressed: (){
                                          controller.altera_visib_senha();
                                        },
                                      )
                                    ),
                                    onSubmitted: (content){
                                      controller.visibilidade_senha.value = true;
                                      logar();
                                    },
                                  )
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Material(
                                  elevation: 4,
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.all(Radius.circular(14)),
                                  child: Container(
                                      height: 40,
                                      width: largura_widgets,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(14)),
                                        gradient: LinearGradient(
                                            begin: Alignment(0,-1),
                                            end: Alignment(0,2),
                                            colors: <Color>[res.azul_escuro, Color(0xff131934)]),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.all(Radius.circular(14)),
                                        child: InkWell(
                                            splashColor: Colors.white,
                                            hoverColor: res.azul_claro,
                                            borderRadius: BorderRadius.all(Radius.circular(14)),
                                            onTap: (){
                                              logar();
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                AutoSizeText(
                                                  "Logar",
                                                  style: res.texto_branco_16,
                                                  minFontSize: 8,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            )
                                        ),
                                      )
                                  ),
                                )
                              ],
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.zero,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    color: Colors.transparent,
                                    height: 20,
                                    width: largura_widgets,
                                    child: InkWell(
                                      hoverColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: AutoSizeText(
                                          "Estou sem acesso",
                                          textAlign: TextAlign.center,
                                          style: res.texto_bold_azul_claro_12,
                                          minFontSize: 8,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      onTap: (){
                                        mostrar_dialogo_sem_acesso();
                                      },
                                    )
                                )
                              ],
                            )
                        ),
                      ],
                    )
                )
            );
          }
          else{
            return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: AutoSizeText(
                    'Aumente a janela para usar',
                    style: res.texto_bold_azul_20,
                    minFontSize: 8,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
            );
          }
        }
    );
  }

  mostrar_dialogo_sem_acesso(){
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CustomDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: DialogoSemAcesso()
        );
      },
      animationType: DialogTransitionType.fadeScale,
      curve: Curves.easeOutQuint,
      duration: Duration(milliseconds: 500),
    );
  }

  logar() async{
    if(_controller_email.text.isEmpty || _controller_senha.text.isEmpty){
      Flushbar(
        backgroundColor: Colors.red,
        messageText: Text('Por gentileza, preencha o e-mail e a senha', style: res.texto_branco_16,),
        duration: Duration(seconds: 2),
      ).show(context);
      return;
    }
    mostrar_progress();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _controller_email.text,
          password: _controller_senha.text
      );
      final user = credential.user;
      if(user != null){
        final shared_prefs = await SharedPreferences.getInstance();
        await shared_prefs.setString("email", _controller_email.text);
        await shared_prefs.setString("senha", _controller_senha.text);
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Main()),
        );
      }

    } on FirebaseAuthException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      Flushbar(
        backgroundColor: Colors.red,
        messageText: Text('Erro ao efetuar login. Verifique seus dados e tente novamente.', style: res.texto_branco_16,),
        duration: Duration(seconds: 2),
      ).show(context);
      return;
    }
  }

  verifica_login() async{
    final shared_pref = await SharedPreferences.getInstance();
    if(shared_pref.getString("email") != null && shared_pref.getString("senha") != "")
    {
      _controller_email.text = shared_pref.getString("email").toString();
      _controller_senha.text = shared_pref.getString("senha").toString();
    }
    else{
      _foco_email.requestFocus();
    }
  }
  mostrar_progress(){
    showAnimatedDialog(
        barrierDismissible: false,
        context: context,
        builder: (_){
          return WillPopScope(
              child: CustomDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(15.0))),
                  child: DialogoCarregando()
              ),
              onWillPop: () async => false
          );
        }
    );
  }
}
