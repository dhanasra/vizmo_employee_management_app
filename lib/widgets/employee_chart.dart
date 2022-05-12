import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vizmo_employee_management_app/utils/app_colors.dart';
import 'package:vizmo_employee_management_app/view_models/employee_view_model.dart';

class EmployeeChart extends StatelessWidget {
  EmployeeChart({Key? key}) : super(key: key);

  final List<FlSpot> employeeData =
  List.generate(EmployeeViewModel.checkIns!.length, (index) {
    /*
    Set x axis with index.
    Set y axis with time limit.
     */
    var checkInItem = EmployeeViewModel.checkIns![index];
    DateTime date = DateTime.parse(checkInItem.checkin);
    final DateFormat formatter = DateFormat('a');
    final String formatted = formatter.format(date);
    String checkInTime;
    if(formatted=="pm"){
      checkInTime = "${date.hour+12}.${date.minute}";
    }else{
      checkInTime = "${date.hour}.${date.minute}";
    }

    return FlSpot(index.toDouble(), double.parse(checkInTime),);
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
        LineChartData(
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 60,
                  getTitlesWidget: (val,data){
                    return Text(formatTime(double.parse(data.formattedValue)));
                  },
                )
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 20,
                getTitlesWidget: (val,data){
                  return Container();
                },
              ),
            ),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (val,data){
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(formatDate(EmployeeViewModel.checkIns![int.parse(data.formattedValue)].checkin),),
                      );
                    },
                    reservedSize: 60,
                    interval: 1
                )
            ),
            topTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: false
                )
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: employeeData,
              isCurved: true,
              barWidth: 2,
              color: AppColors.secondaryColor,
            )
          ],
        )
    );
  }

  String formatDate(String dateTime){
    final DateTime now = DateTime.parse(dateTime);
    final DateFormat formatter = DateFormat('dd/MM/yy');
    final String formatted = formatter.format(now);
    return formatted;
  }

  String formatTime(double dateTime){
    if(dateTime<12){
      return "$dateTime am";
    }else{
      return "${dateTime-12} pm";
    }
  }

}
