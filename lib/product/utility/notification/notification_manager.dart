import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

/// The `INotificationManager` class is an abstract class that defines methods for initializing and
/// showing notifications with various customizable options.
abstract class INotificationManager {
  Future<void> initialize();
  Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? notificationCategory,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
  });
}

class NotificationManager implements INotificationManager {
  @override

  /// The `initialize` function initializes the AwesomeNotifications plugin with a high importance
  /// notification channel and a notification channel group.
  Future<void> initialize() async {
    await AwesomeNotifications().initialize(
      null,
      [
        /// The `NotificationChannel` constructor is used to create a notification channel. A
        /// notification channel is a way to categorize and group notifications based on their
        /// importance and behavior.
        NotificationChannel(
          channelGroupKey: 'high_importance_channel',
          channelKey: 'high_importance_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Colors.red,
          ledColor: Colors.green,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        )
      ],

      /// The `channelGroups` parameter is used to define a group of notification channels. In this code
      /// snippet, it creates a single notification channel group with the key
      /// `'high_importance_channel_group'` and the name `'Group 1'`.
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'high_importance_channel_group',
          channelGroupName: 'Group 1',
        ),
      ],
      debug: true,
    );

    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if (!isAllowed) {
          /// The line `await AwesomeNotifications().requestPermissionToSendNotifications();` is
          /// requesting permission from the user to send notifications. This is necessary because on some
          /// devices, users need to explicitly grant permission for an app to send notifications.
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("onNotificationCreatedMethod");
  }

  Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationDisplayedMethod');
  }

  Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onDismissActionReceivedMethod');
  }

  Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    debugPrint('onActionReceivedMethod');
    final payload = receivedAction.payload ?? {};
    if (payload["navigate"] == "true") {}
  }

  /// The function `showNotification` creates and schedules a notification with various customizable
  /// options.
  ///
  /// Args:
  ///   title (String): The title of the notification. It is a required parameter and must be provided
  /// when calling the `showNotification` method.
  ///   body (String): The `body` parameter is a required parameter of type `String` that represents the
  /// main content or message of the notification. It typically contains additional information or
  /// details related to the notification.
  ///   summary (String): The `summary` parameter is an optional string that represents a summary text
  /// for the notification. It is typically used for grouped notifications to provide a concise summary
  /// of the group.
  ///   payload (Map<String, String>): The `payload` parameter is a map of key-value pairs that can be
  /// used to pass additional data or information along with the notification. This data can be accessed
  /// when the notification is tapped or interacted with by the user.
  ///   actionType (ActionType): The `actionType` parameter is used to specify the type of action that
  /// should be associated with the notification. It is an optional parameter with a default value of
  /// `ActionType.Default`. Defaults to ActionType
  ///   notificationLayout (NotificationLayout): The `notificationLayout` parameter is used to specify
  /// the layout style of the notification. It is of type `NotificationLayout` and has the following
  /// options:. Defaults to NotificationLayout
  ///   notificationCategory (NotificationCategory): The `notificationCategory` parameter is used to
  /// specify the category of the notification. It is an optional parameter and its type is
  /// `NotificationCategory?`.
  ///   bigPicture (String): The `bigPicture` parameter is used to specify the path or URL of a large
  /// image that will be displayed in the expanded view of the notification. It can be a local file path
  /// or a remote URL.
  ///   actionButtons (List<NotificationActionButton>): The `actionButtons` parameter is a list of
  /// `NotificationActionButton` objects. These objects represent the action buttons that will be
  /// displayed in the notification. Each `NotificationActionButton` has a `key` and a `label` property.
  /// The `key` is a unique identifier for the button, and
  ///   scheduled (bool): A boolean value indicating whether the notification should be scheduled or not.
  /// If set to true, the notification will be scheduled to be shown at a specific interval. Defaults to
  /// false
  ///   interval (int): The `interval` parameter is used to specify the time interval at which the
  /// notification should be scheduled to be shown repeatedly. It is only applicable if the `scheduled`
  /// parameter is set to `true`. The value of `interval` represents the number of minutes between each
  /// notification. For example, if `
  @override
  Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? notificationCategory,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: -1,
          channelKey: 'high_importance_channel',
          title: title,
          body: body,
          actionType: actionType,
          notificationLayout: notificationLayout,
          summary: summary,
          category: notificationCategory,
          payload: payload,
          bigPicture: bigPicture,
        ),
        schedule: scheduled
            ? NotificationInterval(
                interval: interval,
                timeZone:
                    await AwesomeNotifications().getLocalTimeZoneIdentifier(),
                preciseAlarm: true,
              )
            : null);
  }
}
