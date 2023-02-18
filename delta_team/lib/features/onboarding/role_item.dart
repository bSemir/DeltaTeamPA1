import 'package:delta_team/features/onboarding/position_card.dart';
import 'package:delta_team/features/onboarding/providers/role_provider.dart';
import 'package:delta_team/features/onboarding/role.dart';
import 'package:delta_team/features/onboarding/role_white_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoleWidget extends StatefulWidget {
  final Role role;
  final RoleWhite roleWhite;
  const RoleWidget({
    Key? key,
    required this.role,
    required this.roleWhite,
  }) : super(key: key);

  @override
  State<RoleWidget> createState() => _RoleWidgetState();
}

class _RoleWidgetState extends State<RoleWidget> {
  @override
  Widget build(BuildContext context) {
    var myItem = Provider.of<MyItem>(context);
    var nizSaRolama = Provider.of<MyItem>(context).myItems;
    var isSelected = myItem.hasRole(widget.role);
    selectedItem() {
      if (isSelected || nizSaRolama.length >= 2) {
        myItem.remove(widget.role);
      } else {
        myItem.add(widget.role);
      }
    }

    return GestureDetector(
      onTap: () {
        selectedItem();
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
