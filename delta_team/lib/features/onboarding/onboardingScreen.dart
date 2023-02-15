// import 'package:delta_team/features/onboarding/modelRoleWhite.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'errorMsg.dart';
import 'modelRoleWhite.dart';
import 'modelmyItem.dart';

import 'package:url_launcher/url_launcher.dart';
import './../../home.dart';
import '../../common/global_variables.dart';
import 'modelRole.dart';
import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:delta_team/amplifyconfiguration.dart';

class Onboarding extends StatefulWidget {
  final Role role;

  const Onboarding({super.key, required this.role});

  @override
  State<Onboarding> createState() => _OnboardingState(this.role);
}

class _OnboardingState extends State<Onboarding> {
  String? _character;

  final TextEditingController _motivacija = TextEditingController();
  final TextEditingController _hobi = TextEditingController();
  final TextEditingController _interesovanja = TextEditingController();
  final TextEditingController _kucniLjubimac = TextEditingController();
  final TextEditingController _kapetan = TextEditingController();
  final TextEditingController _UnesiYtUrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _controller = YoutubePlayerController.fromVideoId(
    videoId: '2_uX7GxPzDI',
    autoPlay: false,
    params: const YoutubePlayerParams(showFullscreenButton: true),
  );

  final Role role;

  _OnboardingState(this.role);

  @override
  void initState() {
    super.initState();

    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    // Add any Amplify plugins you want to use
    final authPlugin = AmplifyAuthCognito();
    final api = AmplifyAPI();
    await Amplify.addPlugins([authPlugin, api]);
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      safePrint(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  Future<void> signInUser() async {
    await _configureAmplify();
    try {
      final result = await Amplify.Auth.signIn(
        username: "sblekic@pa.tech387.com", // email of user
        password: "Password123!",
      );
      print('LOGINOVO SE KRALJ AMAR');
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  Future<void> signOutUser() async {
    try {
      final res = await Amplify.Auth.signOut();

      print(res);
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  Widget build(BuildContext context) {
    var myItem = Provider.of<MyItem>(context);
    var nizSaRolama = Provider.of<MyItem>(context).myItems;
    var isSelected = myItem.hasRole(role);

    Future<void> submitOnboarding() async {
      await signInUser();

      try {
        final restOperation = Amplify.API.post("/api/onboarding/submit",
            body: HttpPayload.json({
              "date": "Jan2023",
              "roles": nizSaRolama,
              "answers": {
                // answers are in the same order as questions, null if not answered
                "0": _character,
                "1": _motivacija.text,
                "2": _hobi.text,
                "3": _interesovanja.text,
                "4": _kucniLjubimac.text,
                "5": _kapetan.text,
                "6": _UnesiYtUrl.text,
              },
            }),
            apiName: "UserObjectInitialization");
        final response = await restOperation.response;
        Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
        print('POST call succeeded');
        print(responseMap['lectures']);
      } on ApiException catch (e) {
        print('POST call failed: $e');
      }
    }

    void clearFields() {
      setState(() {
        // _character = null;

        _motivacija.clear();
        _hobi.clear();
        _interesovanja.clear();
        _kucniLjubimac.clear();
        _kapetan.clear();
        nizSaRolama.clear();
        _UnesiYtUrl.clear();
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Image.asset(
            '../../assets/images/logo.png',
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.32,
          ),
          Container(
              child: Text(
            'Tech387',
            style: TextStyle(color: Colors.black),
          ))
        ]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //dobrodosli container
            Container(
              color: Colors.black,
              width: MediaQuery.of(context).size.width * 1.0,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.20,
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                      width: MediaQuery.of(context).size.width * 0.69,
                      child: Text(
                        'Dobrodošli!',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                ],
              ),
            ),

            // tekst ispod dobrodosli containera
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    // color: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.59,
                    // margin: EdgeInsets.fromLTRB(0, 0, 390, 0),
                    child: Text(
                      'Ne zaboravite da odvojite vrijeme i pažljivo pročitajte svako pitanje. Sretno!',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      width: MediaQuery.of(context).size.width * 0.59,
                      child: const Text(
                        'Molimo vas da popunite dole potrebne podatke: ',
                        style: TextStyle(fontSize: 18),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    width: MediaQuery.of(context).size.width * 0.60,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),

                        //pocetak pitanja forme
                        Container(
                          width: MediaQuery.of(context).size.width * 0.58,
                          child: Text(
                              'Product Arena je full-time tromjesečna praksa, da li spreman/a učenju i radu posvetiti 8 sati svakog radnog dana?'),
                        ),

                        Column(
                          children: [
                            ListTile(
                              key: const Key('KeyDa'),
                              title: const Text('Da'),
                              leading: Radio<String>(
                                value: "False",
                                groupValue: _character,
                                onChanged: (value) {
                                  setState(() {
                                    _character = value;
                                    print(value);
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              key: const Key('KeyNe'),
                              title: const Text('Ne'),
                              leading: Radio<String>(
                                value: "True",
                                groupValue: _character,
                                onChanged: (value) {
                                  setState(() {
                                    _character = value;
                                    print(value);
                                  });
                                },
                              ),
                            ),
                            Consumer<ErrorMessage>(
                              builder: (context, error, child) {
                                return Container(
                                  padding:
                                      EdgeInsets.only(left: 20.0, top: 5.0),
                                  height: error.errorHeight,
                                  child: Row(
                                    children: <Widget>[
                                      // Icon(error.errorIcon,
                                      //     size: 20.0, color: Colors.red[700]),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          error.errorText,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.red[700],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        // Column

                        // FormField
                      ],
                    ),
                  ),
                  //drugi container
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    height: MediaQuery.of(context).size.height * 0.18,
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    width: MediaQuery.of(context).size.width * 0.60,
                    // color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          // margin: EdgeInsets.fromLTRB(0, 0, 710, 0),
                          // color: Colors.green,
                          width: MediaQuery.of(context).size.width * 0.57,
                          //umjesto margine uradi width  sa querijem zbog responsiva
                          child: Text('Šta te motiviše?'),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 28, 0),
                          width: MediaQuery.of(context).size.width * 0.54,
                          child: TextFormField(
                            key: const Key('Key1'),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(fontSize: 20),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black,
                              )),
                              label: Text(
                                'Unesi text',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            controller: _motivacija,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Ovo polje je obavezno ! ';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(690, 10, 0, 0),
                          child: GestureDetector(
                              onTap: () {
                                _motivacija.clear();
                              },
                              child: Text(
                                'Clear Section',
                                style: TextStyle(color: Colors.grey),
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),

                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    height: MediaQuery.of(context).size.height * 0.18,
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    width: MediaQuery.of(context).size.width * 0.60,
                    // color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.57,
                          child: Text(
                              'Da li imaš ili si imao/la neki hobi ili se baviš nekim sportom?'),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 28, 0),
                          width: MediaQuery.of(context).size.width * 0.54,
                          child: TextFormField(
                            key: const Key('Key2'),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(fontSize: 20),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black,
                              )),
                              label: Text(
                                'Unesi text',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            // controller: _controllers[1],
                            controller: _hobi,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Ovo polje je obavezno ! ';
                              } else {
                                print(value);
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(690, 10, 0, 0),
                          child: GestureDetector(
                              onTap: () {
                                _hobi.clear();
                              },
                              child: Text('Clear Section',
                                  style: TextStyle(color: Colors.grey))),
                        )
                      ],
                    ),
                  ),
                  //OVDJE treci
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    height: MediaQuery.of(context).size.height * 0.2,
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    width: MediaQuery.of(context).size.width * 0.60,
                    // color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.57,
                          child: Text(
                              'Postoji li neko interesovanje koje imaš, ali ga trenutno ne možeš ostvariti?'),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 28, 0),
                          width: MediaQuery.of(context).size.width * 0.54,
                          child: TextFormField(
                            key: const Key('Key3'),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(fontSize: 20),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black,
                              )),
                              label: Text(
                                'Unesi text',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            // controller: _controllers[2],
                            controller: _interesovanja,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Ovo polje je obavezno ! ';
                              } else {
                                print(value);
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(690, 10, 0, 0),
                          child: GestureDetector(
                              onTap: () {
                                _interesovanja.clear();
                              },
                              child: Text(
                                'Clear Section',
                                style: TextStyle(color: Colors.grey),
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),

                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    height: MediaQuery.of(context).size.height * 0.18,
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    width: MediaQuery.of(context).size.width * 0.60,
                    // color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          // margin: EdgeInsets.fromLTRB(0, 0, 710, 0),
                          // color: Colors.green,
                          width: MediaQuery.of(context).size.width * 0.57,
                          //umjesto margine uradi width  sa querijem zbog responsiva
                          child: Text(
                              'Da li bi vodio/la brigu o kućnom ljubimcu svojih komšija dok su oni na godišnjem odmoru?'),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 28, 0),
                          width: MediaQuery.of(context).size.width * 0.54,
                          child: TextFormField(
                            key: const Key('Key4'),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(fontSize: 20),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black,
                              )),
                              label: Text(
                                'Unesi text',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            // controller: _controllers[3],
                            controller: _kucniLjubimac,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Ovo polje je obavezno ! ';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(690, 10, 0, 0),
                          child: GestureDetector(
                              onTap: () {
                                _kucniLjubimac.clear();
                              },
                              child: Text(
                                'Clear Section',
                                style: TextStyle(color: Colors.grey),
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    height: MediaQuery.of(context).size.height * 0.19,
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    width: MediaQuery.of(context).size.width * 0.60,
                    // color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          // margin: EdgeInsets.fromLTRB(0, 0, 710, 0),
                          // color: Colors.green,
                          width: MediaQuery.of(context).size.width * 0.57,
                          //umjesto margine uradi width  sa querijem zbog responsiva
                          child: Text(
                              'Kapetan si piratskog broda, tvoja posada može da glasa kako se dijeli zlato. Ako se manje od polovine pirata složi sa tobom, umrijet ćeš. Kakvu podjelu zlata bi predložio/la tako da dobiješ dobar dio plijena, a ipak preživiš?'),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 28, 0),
                          width: MediaQuery.of(context).size.width * 0.54,
                          child: TextFormField(
                            key: const Key('Key5'),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(fontSize: 20),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black,
                              )),
                              label: Text(
                                'Unesi text',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            // controller: _controllers[4],
                            controller: _kapetan,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Ovo polje je obavezno ! ';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(690, 10, 0, 0),
                          child: GestureDetector(
                              onTap: () {
                                _kapetan.clear();
                              },
                              child: Text(
                                'Clear Section',
                                style: TextStyle(color: Colors.grey),
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        // color: Colors.white,
                        width: MediaQuery.of(context).size.width * 0.27,
                        height: MediaQuery.of(context).size.height * 0.42,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                              width: MediaQuery.of(context).size.width * 0.50,
                              child: Text(
                                'Pogledajte video snimak Amera i poslušajte njegovu poruku.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  // YoutubePlayer(
                                  //   controller: _controller!,
                                  //   showVideoProgressIndicator: true,
                                  //   progressIndicatorColor: Colors.amber,
                                  //   progressColors: ProgressBarColors(
                                  //       playedColor: Colors.amber,
                                  //       handleColor: Colors.amberAccent),
                                  // ),
                                  YoutubePlayer(
                                    controller: _controller,
                                    aspectRatio: 16 / 9,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        // color: Colors.white,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
                        width: MediaQuery.of(context).size.width * 0.28,
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Row(
                          children: [
                            Column(children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.22,
                                  child: Text(
                                    'Pritisnite dugme za snimanje i predstavite se! Recite nam nešto zanimljivo o sebi ili nečemu što vas zanima.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 70, 0),
                                child: Container(
                                    // color: Colors.black12,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    // margin: EdgeInsets.fromLTRB(0, 0, 160, 0),
                                    child: Text(
                                      'Molimo te da link staviš u box!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.20,
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                child: TextFormField(
                                  key: const Key('keyUrl'),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  decoration: const InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelStyle: TextStyle(fontSize: 20),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                    label: Text(
                                      'https://',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  controller: _UnesiYtUrl,
                                  // controller: _controllers[5],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),

                              //STAVI NA SVAKI CONTAINER POTREBNI WIDTH DA NE BI DOSLO DO GRESKE ZA RESPONSIVE
                              Container(
                                  // color: Colors.green,
                                  width:
                                      MediaQuery.of(context).size.width * 0.20,
                                  child: Text(
                                      'Za učitavanje videa koristi file.io'))
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            //DVA CONTAINERA SA VIDEOM I URL-om

            ElevatedButton(onPressed: signOutUser, child: Text('sign out')),
            SizedBox(
              height: 20,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // color: Colors.green,
                  height: 160,
                  width: 930,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        listaRola.length,
                        (index) => Item(
                          role: listaRola[index],
                          roleWhite: listaRolaWhite[index],
                        ),
                      )),
                ),
              ],
            ),

            //BLACK CONTAINER POSITIONS
            // Container(
            //   color: Colors.black,
            //   width: MediaQuery.of(context).size.width * 0.60,
            //   height: MediaQuery.of(context).size.height * 0.23,
            //   child: Column(
            //     children: [
            //       Container(
            //         margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
            //         width: MediaQuery.of(context).size.width * 0.55,
            //         child: Text(
            //           'Za koju se poziciju prijavljuješ',
            //           style: TextStyle(color: Colors.white),
            //         ),
            //       ),
            //       Container(
            //         margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            //         width: MediaQuery.of(context).size.width * 0.55,
            //         child: Text(
            //           'Možeš odabrati jednu ili dvije pozicije!',
            //           style: TextStyle(color: Colors.white),
            //         ),
            //       ),
            //       // Padding(
            //       //   padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
            //       //   child: Container(
            //       //     width: MediaQuery.of(context).size.width * 0.45,
            //       //     child: Row(
            //       //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       //       children:
            //       //           // Column(children: [
            //       //           //   Container(
            //       //           //     child: Image.asset(
            //       //           //       '../../assets/images/qa.png',
            //       //           //     ),
            //       //           //   ),
            //       //           //   Padding(
            //       //           //     padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            //       //           //     child: Text(
            //       //           //       'QA Engineering',
            //       //           //       style: TextStyle(color: Colors.white),
            //       //           //     ),
            //       //           //   )
            //       //           // ]),
            //       //           // Column(children: [
            //       //           //   Container(
            //       //           //     child: Image.asset(
            //       //           //       '../../assets/images/manager.png',
            //       //           //     ),
            //       //           //   ),
            //       //           //   Padding(
            //       //           //     padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            //       //           //     child: Text(
            //       //           //       'Project Management',
            //       //           //       style: TextStyle(color: Colors.white),
            //       //           //     ),
            //       //           //   )
            //       //           // ]),
            //       //           // Column(children: [
            //       //           //   Container(
            //       //           //     child: Image.asset(
            //       //           //       '../../assets/images/backend.png',
            //       //           //     ),
            //       //           //   ),
            //       //           //   Padding(
            //       //           //     padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            //       //           //     child: Text(
            //       //           //       'Backend',
            //       //           //       style: TextStyle(color: Colors.white),
            //       //           //     ),
            //       //           //   )
            //       //           // // ]),
            //       //           // Column(children: [
            //       //           //   Container(
            //       //           //     height: 42,
            //       //           //     width: 31.8,
            //       //           //     child: Image.asset(
            //       //           //       '../../assets/images/backend.png',
            //       //           //     ),
            //       //           //   ),
            //       //           //   Padding(
            //       //           //     padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            //       //           //     child: Text(
            //       //           //       'UI/UX Desing',
            //       //           //       style: TextStyle(color: Colors.white),
            //       //           //     ),
            //       //           //   )
            //       //           // ]),
            //       //           // Column(children: [
            //       //           //   Container(
            //       //           //     child: Image.asset(
            //       //           //       '../../assets/images/fullstack.png',
            //       //           //     ),
            //       //           //   ),
            //       //           //   Padding(
            //       //           //     padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            //       //           //     child: Text(
            //       //           //       'Full Stack Developer',
            //       //           //       style: TextStyle(color: Colors.white),
            //       //           //     ),
            //       //           //   )
            //       //           // ]),
            //       //           GlobalForImages.forImages
            //       //               .map(
            //       //                 (e) => InkWell(
            //       //                   // onTap: () async {
            //       //                   //   await launchUrl(
            //       //                   //     Uri.parse(e['text'] as String),
            //       //                   //   );
            //       //                   // },
            //       //                   child: Image.asset(e['image'] as String),

            //       //                 ),
            //       //               )
            //       //               .toList(),
            //       //     ),
            //       //   ),
            //       // )
            //     ],
            //   ),
            // ),

            SizedBox(
              height: 20,
            ),

            //BUTTONS

            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            _character != null &&
                            (isSelected ||
                                myItem.length <= 2 && myItem.length >= 1)) {
                          // clearFields();
                          submitOnboarding();

                          myItem.remove(widget.role);
                          // clearFields();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        } else if (_character == null) {
                          context.read<ErrorMessage>().change();
                          // myItem.add(widget.role);
                        }
                        // else if (nizSaRolama.first.isEmpty && isSelected) {
                        //   myItem.add(widget.role);

                        //   print(myItem.length);
                        // else if (nizSaRolama.first.isNotEmpty &&
                        // //     !isSelected) {
                        // //   myItem.remove(widget.role);
                        // // }
                        // else if (nizSaRolama.first != null || isSelected) {
                        //   myItem.add(widget.role);
                        //   print(myItem.length);

                        // else if (nizSaRolama.first.isNotEmpty) {
                        //   myItem.remove(role);
                        // }
                        else if (nizSaRolama.first != null) {
                          myItem.remove(widget.role);
                        } else {
                          myItem.add(widget.role);
                          print(myItem.length);
                        }

                        // clearFields();
                      },
                      // clearFields();
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      child: Text(
                        'Posalji',
                      )),

                  // GestureDetector(

                  GestureDetector(
                      onTap: clearFields, child: Text('Ocisti odabir'))
                ],
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
            ),

            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 1.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      '../../assets/images/footer_logo.png',
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    // color: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: const Divider(
                      height: 1,
                      thickness: 1,
                      indent: 10,
                      endIndent: 0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(
                    // color: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.89,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('../../assets/images/pin.png'),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 50, 0),
                          width: MediaQuery.of(context).size.width * 0.31,
                          child: Text(
                            'Put Mladih Muslimana 2, City Gardens Residence, 71 000 Sarajevo, Bosnia and Herzegovina 14425 Falconhead Blvd, Bee Cave, TX 78738, United States',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width * 0.01,
                        // ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.16,
                          height: MediaQuery.of(context).size.height * 0.03,

                          // color: Colors.green,
                          // margin: EdgeInsets.fromLTRB(233, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: GlobalVariables.socialMedia
                                .map(
                                  (e) => InkWell(
                                    onTap: () async {
                                      await launchUrl(
                                        Uri.parse(e['url'] as String),
                                      );
                                    },
                                    child: Image.asset(e['image'] as String),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width * 0.35,
                        // ),

                        Container(
                          // padding: EdgeInsets.fromLTRB(350, 0, 0, 0),
                          width: MediaQuery.of(context).size.width * 0.36,
                          // color: Colors.green,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [Text('Privacy '), Text('Terms')]),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.89,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Row(
                      children: [
                        Image.asset('../../assets/images/email.png'),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Text('hello@tech387.com'),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.28,
                        ),
                        Text(
                          '© Credits, 2023, Product Arena',
                          style: TextStyle(fontSize: 13),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            //OVDJE
          ],
        ),
      ),
    );
  }
}

class Item extends StatefulWidget {
  // dodaj model klasu za itejme
  final Role role;
  final RoleWhite roleWhite;

  const Item({super.key, required this.role, required this.roleWhite});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    // use Provider
    var myItem = Provider.of<MyItem>(context);
    var nizSaRolama = Provider.of<MyItem>(context).myItems;
    var isSelected = myItem.hasRole(widget.role);

    fja() {
      if (isSelected || nizSaRolama.length >= 2) {
        myItem.remove(widget.role);
      } else {
        myItem.add(widget.role);
      }
    }

    return GestureDetector(
      onTap: () {
        fja();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(40.0, 16.0, 16.0, 16.0),
            padding: const EdgeInsets.all(16.0),
            width: 124,
            height: 110,
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.black54,
              border: isSelected
                  ? Border.all(
                      width: 2,
                    )
                  : Border.all(width: 1),
              borderRadius: BorderRadius.zero,
            ),
            child: Column(children: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: isSelected
                      ? Image.asset(widget.role.image as String)
                      : Image.asset(
                          widget.roleWhite.imageWhite,
                        )),
              SizedBox(
                height: 5,
              ),
              Container(
                  width: 135,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.role.id,
                      style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11),
                    ),
                  )),
            ]),
          ),
          SizedBox(
            height: 12.0,
          ),
          // Text(widget.role.id),
        ],
      ),
    );
  }
}
