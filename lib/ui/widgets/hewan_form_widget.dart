import 'package:flutter/material.dart';
import 'package:restapi_flutter/data/models/hewan_models.dart';

class HewanFormWidget extends StatefulWidget {
  final HewanModel? intialData;
  final void Function(Map<String, dynamic> data) onSubmit;
  final bool isLoading;

  const HewanFormWidget({
    super.key,
    this.intialData,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<HewanFormWidget> createState() => _HewanFormWidgetState();
}

class _HewanFormWidgetState extends State<HewanFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
