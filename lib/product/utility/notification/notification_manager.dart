import 'package:awesome_notifications/android_foreground_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

abstract class INotificationManager {
  void initialize();
  Future<void> showNotification({
    required final String title,
    required final String body,
    required final int id,
    required final DateTime date,
    final String? summary,
    final Map<String, String>? payload,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? notificationCategory,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool schedule = false,
    final int? interval,
  });
  Future<void> showAndroidForeground({
    required final String title,
    required final String body,
    required final int id,
    required final DateTime date,
    final String? summary,
    final Map<String, String>? payload,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? notificationCategory,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool schedule = false,
    final int? interval,
  });
  Future<void> cancelNotification(int id);
}

class AwesomeLocalNotification extends INotificationManager {
  @override
  Future<void> initialize() async {
    AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            channelShowBadge: false,
            defaultRingtoneType: DefaultRingtoneType.Alarm,
            importance: NotificationImportance.High,
            ledColor: Colors.red),
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic group',
        )
      ],
      debug: true,
    );
    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      print(isAllowed);
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications(
          channelKey: 'basic_channel',
        );
      }
    });
  }

  @override
  Future<void> showNotification({
    required final String title,
    required final String body,
    required final int id,
    required final DateTime date,
    final String? summary,
    final Map<String, String>? payload,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? notificationCategory,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool schedule = false,
    final int? interval,
  }) async {
    assert(!schedule || (schedule && interval != null));
    print(bigPicture);
    print(date);
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        summary: summary,
        category: notificationCategory,
        payload: payload,
        notificationLayout: notificationLayout,
        bigPicture: 'asset://$bigPicture',
        wakeUpScreen: true,
      ),
      actionButtons: actionButtons,
      schedule: NotificationCalendar.fromDate(date: date, repeats: true),
    );
  }

  @override
  Future<void> showAndroidForeground({
    required final String title,
    required final String body,
    required final int id,
    required final DateTime date,
    final String? summary,
    final Map<String, String>? payload,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? notificationCategory,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool schedule = false,
    final int? interval,
  }) async {
    assert(!schedule || (schedule && interval != null));
    print(bigPicture);

    await AndroidForegroundService.startAndroidForegroundService(
        foregroundStartMode: ForegroundStartMode.stick,
        foregroundServiceType: ForegroundServiceType.phoneCall,
        content: NotificationContent(
            id: 2341234,
            body: 'Service is running!',
            title: 'Android Foreground Service',
            channelKey: 'basic_channel',
            bigPicture: 'asset://assets/images/android-bg-worker.jpg',
            notificationLayout: NotificationLayout.BigPicture,
            category: NotificationCategory.Service),
        actionButtons: [
          NotificationActionButton(
              key: 'SHOW_SERVICE_DETAILS', label: 'Show details')
        ]);
  }

  //cancel notification id
  @override
  Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancelAll();
    /* await AwesomeNotifications().cancel(id);
    await AwesomeNotifications().cancelSchedule(id); */
  }
}
