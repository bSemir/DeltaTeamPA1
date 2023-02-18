import 'package:delta_team/common/colors.dart';
import 'package:delta_team/features/onboarding/providers/role_provider.dart';
import 'package:delta_team/features/onboarding/role.dart';
import 'package:delta_team/features/onboarding/role_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ClickableCard extends StatefulWidget {
  const ClickableCard({super.key});

  @override
  _ClickableCardState createState() => _ClickableCardState();
}

class _ClickableCardState extends State<ClickableCard> {
  int _clickCount = 0;
  Color _containerColor = Colors.white;

  void _changeColor() {
    setState(() {
      _clickCount++;

      if (_clickCount % 2 == 1) {
        _containerColor = Colors.black;
      } else {
        _containerColor = Colors.white;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          _changeColor();
        },
        child: Container(
          width: double.infinity,
          height: 100.0,
          color: _containerColor,
          child: const Center(
              child: Text(
            'Pick me!',
            style: TextStyle(color: AppColors.secondaryColor),
          )),
        ),
      ),
    );
  }
}

class PositionCard extends StatefulWidget {
  final String positionName;
  final String positionImage;
  final VoidCallback onPressed;

  const PositionCard({
    super.key,
    required this.positionName,
    required this.positionImage,
    required this.onPressed,
  });

  @override
  State<PositionCard> createState() => _PositionCardState();
}

class _PositionCardState extends State<PositionCard> {
  int _clickCount = 0;
  Color _containerColor = Colors.white;

  void _changeColor() {
    setState(() {
      _clickCount++;

      if (_clickCount % 2 == 1) {
        _containerColor = Colors.black;
      } else {
        _containerColor = Colors.white;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var myItem = Provider.of<MyItem>(context);
    var nizSaRolama = Provider.of<MyItem>(context).myItems;
    // var isSelected = myItem.hasRole(widget.role);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          _changeColor();
        },
        child: Container(
          width: 296,
          height: 56,
          padding: const EdgeInsets.fromLTRB(17, 3, 17, 3),
          decoration: BoxDecoration(
              color: _containerColor,
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: AppColors.primaryColor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(widget.positionImage),
              const SizedBox(width: 20),
              Text(
                widget.positionName,
                style: GoogleFonts.notoSans(
                    fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
