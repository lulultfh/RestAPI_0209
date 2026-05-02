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
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _namaController;
  late TextEditingController _jenisController;
  late TextEditingController _tglLahirController;
  late TextEditingController _hargaController;
  late TextEditingController _statusController;

  @override
  void dispose() {
    _namaController.dispose();
    _jenisController.dispose();
    _tglLahirController.dispose();
    _hargaController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
