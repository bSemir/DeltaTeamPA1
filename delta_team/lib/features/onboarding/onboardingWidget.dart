import 'package:delta_team/common/colors.dart';
import 'package:delta_team/features/onboarding/form_buttons.dart';
import 'package:delta_team/features/onboarding/providers/answer.dart';
import 'package:delta_team/features/onboarding/providers/error_provider.dart';
import 'package:delta_team/features/onboarding/providers/provider.dart';
import 'package:delta_team/features/onboarding/providers/role_provider.dart';
import 'package:delta_team/features/onboarding/role.dart';
import 'package:delta_team/features/onboarding/role_item.dart';
import 'package:delta_team/features/onboarding/role_white_items.dart';
import 'package:delta_team/features/onboarding/video_playert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OnboardingForm extends StatefulWidget {
  final String questionText;
  final TextEditingController controller;
  final PageController pageController;
  final GlobalKey<FormState> globalKey;
  final String answer;

  const OnboardingForm(
      {Key? key,
      required this.questionText,
      required this.controller,
      required this.pageController,
      required this.globalKey,
      required this.answer})
      : super(key: key);

  @override
  State<OnboardingForm> createState() => _OnboardingFormState();
}

class _OnboardingFormState extends State<OnboardingForm> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AnswerProvider>(context, listen: false);

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15.0),
            Text(
              widget.questionText,
              style: GoogleFonts.notoSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 15.0),
            // input text field for answers
            Form(
              key: widget.globalKey,
              child: TextFormField(
                controller: widget.controller,
                onChanged: (value) {},
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                  labelStyle: TextStyle(color: Color(0xFF424242)),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                  hintText: 'Vaš odgovor',
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "";
                  }
                  return null;
                },
              ),
            ),
            Consumer<ErrorMessage>(
              builder: (context, error, child) {
                return SizedBox(
                  // padding: EdgeInsets.only(left: 20.0, top: 5.0),
                  height: error.errorHeight,
                  child: Row(
                    children: <Widget>[
                      Icon(error.errorIcon, size: 20.0, color: Colors.red[700]),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          error.errorText,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.red[700],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            Container(
              alignment: Alignment.topRight,
              child: ClearSection(controller: widget.controller),
            )
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FormButton(
                  backgroundColor: AppColors.secondaryColor3,
                  textColor: AppColors.primaryColor,
                  text: 'Back',
                  borderColor: AppColors.primaryColor,
                  onPressed: () {
                    widget.pageController.previousPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInBack);
                  },
                  buttonWidth: 100,
                  buttonHeight: 42),
              FormButton(
                  backgroundColor: AppColors.primaryColor,
                  textColor: AppColors.secondaryColor3,
                  text: 'Next',
                  borderColor: AppColors.primaryColor,
                  onPressed: () {
                    if (widget.globalKey.currentState!.validate() == true) {
                      context
                          .read<AnswerProvider>()
                          .addItem(widget.controller.text);
                      context.read<ErrorMessage>().reset();
                      widget.pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.fastLinearToSlowEaseIn);
                    } else {
                      context.read<ErrorMessage>().change();
                    }
                    // widget.pageController.nextPage(
                    //     duration: Duration(milliseconds: 400),
                    //     curve: Curves.easeIn);
                  },
                  buttonWidth: 100,
                  buttonHeight: 42)
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}

enum Opcija { Da, Ne }

class FormWithRadioButtons extends StatefulWidget {
  final String questionText;
  final PageController pageController;
  final VoidCallback onNext;

  const FormWithRadioButtons({
    super.key,
    required this.questionText,
    required this.pageController,
    required this.onNext,
  });

  @override
  State<FormWithRadioButtons> createState() => _FormWithRadioButtonsState();
}

class _FormWithRadioButtonsState extends State<FormWithRadioButtons> {
  bool da = false;
  bool ne = false;
  Opcija? _daNe;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.questionText,
          style: GoogleFonts.notoSans(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Column(
          children: [
            RadioListTile(
              activeColor: Colors.black,
              tileColor: const Color(0xFFE9E9E9),
              contentPadding: EdgeInsets.zero,
              toggleable: true,
              title: const Text('Da'),
              value: Opcija.Da,
              groupValue: _daNe,
              onChanged: ((Opcija? value) => setState(() {
                    da = !ne;
                    _daNe = value!;
                    context.read<AnswerProvider>().addItem('True');
                  })),
            ),
            RadioListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: Colors.black,
              tileColor: const Color(0xFFE9E9E9),
              toggleable: true,
              title: const Text('Ne'),
              value: Opcija.Ne,
              groupValue: _daNe,
              onChanged: ((Opcija? value) => setState(() {
                    ne = !da;
                    _daNe = value!;
                    context.read<AnswerProvider>().addItem('False');
                  })),
            ),
          ],
        ),
        Consumer<ErrorMessage>(
          builder: (context, error, child) {
            return SizedBox(
              height: error.errorHeight,
              child: Row(
                children: <Widget>[
                  Icon(error.errorIcon, size: 20.0, color: Colors.red[700]),
                  Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(error.errorText,
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.red[700])))
                ],
              ),
            );
          },
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(left: 240, bottom: 20),
          child: FormButton(
            backgroundColor: AppColors.primaryColor,
            textColor: AppColors.secondaryColor3,
            borderColor: AppColors.primaryColor,
            buttonWidth: 100,
            buttonHeight: 42,
            text: 'Next',
            onPressed: () {
              if (!da && !ne) {
                context.read<ErrorMessage>().change();
              } else {
                context.read<ErrorMessage>().reset();
                widget.pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn);
              }
            },
          ),
        )
      ],
    );
  }
}

class VideoPageForm extends StatelessWidget {
  final String questionText;
  final PageController pageController;
  // final YoutubePlayerController videoController;
  const VideoPageForm({
    super.key,
    required this.questionText,
    required this.pageController,
    // required this.videoController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              key: const Key('Pitanje7TextKey'),
              textAlign: TextAlign.left,
              questionText,
              style: GoogleFonts.notoSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            key: const Key('VideoContainerKey'),
            padding: const EdgeInsets.only(top: 20),
            alignment: Alignment.centerLeft,
            height: 186.0,
            width: 296.0,
            child: const VideoPlayer(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(
              key: const Key('VideoText1Key'),
              'Snimi video i predstavi se!\nRecite nam nešto zanimljivo o sebi ili o nečemu što vas zanima.',
              style: GoogleFonts.notoSans(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              key: const Key('VideoText2Key'),
              'Molimo te da link staviš u box!',
              style: GoogleFonts.notoSans(
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 3.0),
          TextField(
            key: const Key('HttpTextFieldKey'),
            decoration: InputDecoration(
              hintText: 'https://',
              hintStyle: GoogleFonts.notoSans(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 2),
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () => launchUrl(Uri.parse('https://www.file.io')),
              child: Text(
                key: const Key('VideoText3Key'),
                'Za učitavanje videa koristi file.io',
                style: GoogleFonts.notoSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FormButton(
                  backgroundColor: AppColors.secondaryColor3,
                  textColor: AppColors.primaryColor,
                  text: 'Back',
                  borderColor: AppColors.primaryColor,
                  onPressed: () {
                    pageController.previousPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInBack);
                  },
                  buttonWidth: 100,
                  buttonHeight: 42),
              FormButton(
                  backgroundColor: AppColors.primaryColor,
                  textColor: AppColors.secondaryColor3,
                  text: 'Next',
                  borderColor: AppColors.primaryColor,
                  onPressed: () {
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn);
                  },
                  buttonWidth: 100,
                  buttonHeight: 42)
            ],
          )
        ],
      ),
    );
  }
}

class PositionPageForm extends StatefulWidget {
  final String questionText;
  final VoidCallback submitButton;

  const PositionPageForm({
    super.key,
    required this.questionText,
    required this.submitButton,
  });

  @override
  State<PositionPageForm> createState() => _PositionPageFormState();
}

class _PositionPageFormState extends State<PositionPageForm> {
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<MyItem>(context, listen: false);

    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 27),
            alignment: Alignment.centerLeft,
            child: Text(
              key: const Key('Pitanje8TextKey'),
              widget.questionText,
              style: GoogleFonts.notoSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 1),
            alignment: Alignment.centerLeft,
            child: Text(
              key: const Key('PozicijaTextKey'),
              'Možeš odabrati jednu ili dvije pozicije!',
              style: GoogleFonts.notoSans(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                ListView(
                  key: const Key('ListaPozicijaKey'),
                  children: List.generate(
                    listaRola.length,
                    (index) => RoleWidget(
                      role: listaRola[index],
                      roleWhite: listaRolaWhite[index],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Column(
          //   children: [
          //     PositionCard(
          //         positionName: 'QA Engineering',
          //         positionImage: 'assets/images/qa_icon.png',
          //         onPressed: () {}),
          //     PositionCard(
          //         positionName: 'Project Manager',
          //         positionImage: 'assets/images/manager_icon.png',
          //         onPressed: () {}),
          //     PositionCard(
          //         positionName: 'Backend',
          //         positionImage: 'assets/images/backend_icon.png',
          //         onPressed: () {}),
          //     PositionCard(
          //         positionName: 'UI/UX Design',
          //         positionImage: 'assets/images/ui_ux_designer_icon.png',
          //         onPressed: () {}),
          //     PositionCard(
          //         positionName: 'Full Stack Developer',
          //         positionImage: 'assets/images/full_stack_developer.png',
          //         onPressed: () {}),
          //   ],
          // ),
          const Spacer(),
          SubmitButton(
              key: const Key('SubmitButtonKey'),
              backgroundColor: AppColors.primaryColor,
              textColor: AppColors.secondaryColor3,
              text: 'Submit',
              onPressed: () {
                // if (context.read<Role>().lenght > 2) {
                //   context.read<ErrorMessage>().change();
                // } else {
                //   //funkcija za next button
                //   return null;
                // }
              },
              buttonWidth: double.infinity,
              buttonHeight: 42),
          const SizedBox(height: 50)
        ],
      ),
    );
  }
}
