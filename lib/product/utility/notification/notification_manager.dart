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
  Future<void> cancelAllNotification();
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
            groupKey: 'basic_channel_group',
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

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        groupKey: 'basic_channel_group',
        title: title,
        body: body,
        summary: summary,
        category: notificationCategory,
        payload: payload,
        bigPicture: "asset://$bigPicture",
        notificationLayout: notificationLayout,
      ),
      actionButtons: actionButtons,
      schedule: NotificationCalendar(
        year: date.year,
        month: date.month,
        day: date.day,
        hour: date.hour,
        minute: date.minute,
        second: date.second,
        millisecond: date.millisecond,
      ),
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
          category: NotificationCategory.Reminder,
        ),
        actionButtons: [
          NotificationActionButton(
              key: 'SHOW_SERVICE_DETAILS', label: 'Show details')
        ]);
  }

  //cancel notification all
  @override
  Future<void> cancelAllNotification() async {
    await AwesomeNotifications().cancelAll();
    await AwesomeNotifications().cancelAllSchedules();
    /* await AwesomeNotifications().cancel(id);
    await AwesomeNotifications().cancelSchedule(id); */
  }

  //cancel notification id
  @override
  Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
    /* await AwesomeNotifications().cancel(id);
    await AwesomeNotifications().cancelSchedule(id); */
  }
}
