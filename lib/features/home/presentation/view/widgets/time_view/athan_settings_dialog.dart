import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:islam/core/constants.dart';
import 'package:islam/core/util/styles.dart';
import 'package:islam/features/home/presentation/manger/time_cubit/time_cubit.dart';
import 'package:islam/features/home/presentation/manger/time_cubit/time_state.dart';
import 'package:islam/features/home/presentation/view/widgets/time_view/athan_notification_service.dart';

class AthanSettingsDialog extends StatefulWidget {
  const AthanSettingsDialog({super.key});

  @override
  State<AthanSettingsDialog> createState() => _AthanSettingsDialogState();
}

class _AthanSettingsDialogState extends State<AthanSettingsDialog> {
  late bool isAthanEnabled;
  late Box settingsBox;

  @override
  void initState() {
    super.initState();
    settingsBox = Hive.box('settings');
    isAthanEnabled = settingsBox.get('isAthanEnabled', defaultValue: true);
  }

  void _toggleAthan(bool value) {
    setState(() {
      isAthanEnabled = value;
    });
    settingsBox.put('isAthanEnabled', isAthanEnabled);

    if (isAthanEnabled) {
      final timeCubit = context.read<TimeCubit>();
      if (timeCubit.state is TimeSuccess) {
        final prayerTimes = (timeCubit.state as TimeSuccess).prayerTimes;
        AthanNotificationService.scheduleAthanNotification(
          id: 1,
          prayerName: 'الفجر',
          scheduledTime: prayerTimes.fajr,
        );
        AthanNotificationService.scheduleAthanNotification(
          id: 2,
          prayerName: 'الظهر',
          scheduledTime: prayerTimes.dhuhr,
        );
        AthanNotificationService.scheduleAthanNotification(
          id: 3,
          prayerName: 'العصر',
          scheduledTime: prayerTimes.asr,
        );
        AthanNotificationService.scheduleAthanNotification(
          id: 4,
          prayerName: 'المغرب',
          scheduledTime: prayerTimes.maghrib,
        );
        AthanNotificationService.scheduleAthanNotification(
          id: 5,
          prayerName: 'العشاء',
          scheduledTime: prayerTimes.isha,
        );
      }
    } else {
      AthanNotificationService.cancelAllNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: const Color(0xff1E1E1E),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isAthanEnabled
                    ? kPrimaryColor.withValues(alpha: 0.15)
                    : Colors.grey.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isAthanEnabled ? Icons.notifications_active : Icons.notifications_off,
                size: 48,
                color: isAthanEnabled ? kPrimaryColor : Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'تنبيهات الأذان',
              style: Styles.textStyle20,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              isAthanEnabled
                  ? 'التنبيهات مفعلة وسيتم تشغيل الأذان في مواقيت الصلاة'
                  : 'التنبيهات معطلة حالياً ولن يتم تشغيل الأذان',
              style: Styles.textStyle14.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isAthanEnabled ? 'تفعيل الأذان' : 'إلغاء التفعيل',
                  style: Styles.textStyle16,
                ),
                Switch.adaptive(
                  value: isAthanEnabled,
                  activeColor: kPrimaryColor,
                  onChanged: _toggleAthan,
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () => Navigator.pop(context, isAthanEnabled),
                child: const Text(
                  'تم',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
