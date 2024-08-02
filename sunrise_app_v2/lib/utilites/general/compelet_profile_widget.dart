import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';

class CompleteProfileWidget extends StatefulWidget {
  const CompleteProfileWidget({super.key});

  @override
  State<CompleteProfileWidget> createState() => _CompleteProfileWidgetState();
}

class _CompleteProfileWidgetState extends State<CompleteProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              'Complete Your Profile!',
              style: TextStyle(
                fontSize: 17,
                color: AppColor.third,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              LinearPercentIndicator(
                barRadius: Radius.circular(12),
                width: MediaQuery.of(context).size.width / 1.3,
                lineHeight: 10.0,
                percent: 0.33,
                backgroundColor: AppColor.second,
                progressColor: AppColor.third,
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColor.third,
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, top: 4),
            child: Text(
              '(1/3 Add interests and preferences)',
              style: TextStyle(
                fontSize: 12,
                color: AppColor.third,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
