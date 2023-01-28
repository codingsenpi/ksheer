import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Rx<DateTime> _selectedDay = DateTime.now().obs;
    Rx<DateTime> _focusedDay = DateTime.now().obs;
    Rx<CalendarFormat> _calendarFormat = CalendarFormat.month.obs;

    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.grey.shade900,
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'क्षीरगणकम्',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
        ),
        centerTitle: true,
        foregroundColor: Colors.amber.shade700,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Obx(
                  () => ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    tileColor: Colors.amber.shade700,
                    enableFeedback: true,
                    title: Text('0 ' + _selectedDay.toString()),
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    leading: Icon(Icons.currency_rupee_rounded),
                  ),
                )),
            Obx(
              () => TableCalendar(
                rowHeight: 74,
                daysOfWeekStyle: DaysOfWeekStyle(
                    weekendStyle: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w700),
                    weekdayStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500)),
                headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade400)),
                locale: 'hi_IN',
                calendarStyle: CalendarStyle(
                  defaultTextStyle: TextStyle(color: Colors.amber),
                ),
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime.utc(2050, 1, 1),
                focusedDay: _focusedDay.value,
                selectedDayPredicate: (day) {
                  return isSameDay(
                    _selectedDay.value,
                    day,
                  );
                },
                onDaySelected: (selectedDay, focusedDay) {
                  _selectedDay.value = selectedDay;
                  _focusedDay.value = focusedDay;
                },
                onDayLongPressed: (day, days) {
                  HapticFeedback.vibrate();
                  Get.bottomSheet(
                      Container(
                        child: Wrap(
                          children: [
                            ListTile(
                              title: Text('hi'),
                              textColor: Colors.white,
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text('bye'),
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      backgroundColor: Colors.amber.shade600,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)));
                },
                calendarFormat: _calendarFormat.value,
                onFormatChanged: (format) {
                  _calendarFormat.value = format;
                },
                eventLoader: (day) {
                  if (day.weekday == DateTime.monday) {
                    return [];
                  }

                  return [];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
