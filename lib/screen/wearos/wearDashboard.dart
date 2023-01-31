import 'package:flutter/material.dart';


class WearDashboardScreen extends StatefulWidget {
  const WearDashboardScreen({super.key});

    static const String route = "wearDashboardScreen";


  @override
  State<WearDashboardScreen> createState() => _WearDashboardScreenState();
}

class _WearDashboardScreenState extends State<WearDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Text('dahsboard');
  }
}