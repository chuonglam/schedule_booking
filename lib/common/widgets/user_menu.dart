import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:common/common.dart';
import 'package:schedule_booking/common/widgets/logout_confirmation.dart';
import 'package:schedule_booking/screens/auth/auth_controller.dart';

class UserMenu extends StatelessWidget {
  const UserMenu({super.key});
  static const String _logoutMenu = 'logout';
  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      builder: (authController) {
        if (!authController.isLoggedIn) {
          return const SizedBox();
        }
        return PopupMenuButton(
          onSelected: (value) {
            if (value == _logoutMenu) {
              _onTapLogout(context, authController);
            }
          },
          itemBuilder: (ctx) {
            return [
              const PopupMenuItem(
                value: _logoutMenu,
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Logout"),
                ),
              ),
            ];
          },
          splashRadius: 50,
          padding: const EdgeInsets.all(0),
          position: PopupMenuPosition.under,
          constraints: const BoxConstraints(minWidth: 300),
          child: CircleAvatar(
            child: Text(authController.currentUser?.nameChar ?? ''),
          ),
        );
      },
    );
  }

  void _onTapLogout(BuildContext context, AuthController authController) {
    context
        .dialog(
      negativeText: 'No',
      positiveText: 'Yes',
      title: 'Confirmation',
      content: const LogoutConfirmation(),
    )
        .then((value) {
      if (value != true) {
        return;
      }
      authController.logout();
    });
  }
}
