import 'package:flutter/cupertino.dart';
import 'package:pill_reminder/feature/reminder/view/reminder_view.dart';

mixin ReminderViewMixin on State<ReminderView> {
  late TextEditingController _nameController;
  late TextEditingController _noteController;
  late TextEditingController _amountController;
  late TextEditingController _repeatDayController;

  TextEditingController get nameController => _nameController;
  TextEditingController get noteController => _noteController;
  TextEditingController get amountController => _amountController;
  TextEditingController get repeatDayController => _repeatDayController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _noteController = TextEditingController();
    _amountController = TextEditingController();
    _repeatDayController = TextEditingController();
  }
}
