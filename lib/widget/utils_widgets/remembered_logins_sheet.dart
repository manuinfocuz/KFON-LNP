import 'package:flutter/material.dart';

import '../../data_model/auth/remembered_login_model.dart';

/// Bottom sheet listing remembered logins. Returns the tapped login;
/// [onDelete] is called when an entry's remove icon is pressed.
Future<RememberedLogin?> showRememberedLoginsSheet(
  BuildContext context, {
  required List<RememberedLogin> logins,
  required Future<void> Function(RememberedLogin login) onDelete,
}) {
  return showModalBottomSheet<RememberedLogin>(
    context: context,
    builder: (sheetContext) => StatefulBuilder(
      builder: (context, setSheetState) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Saved logins',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (final login in logins)
                    ListTile(
                      leading: const Icon(Icons.person_outline),
                      title: Text(login.username),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () async {
                          await onDelete(login);
                          setSheetState(() => logins.remove(login));
                          if (logins.isEmpty && sheetContext.mounted) {
                            Navigator.pop(sheetContext);
                          }
                        },
                      ),
                      onTap: () => Navigator.pop(sheetContext, login),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
