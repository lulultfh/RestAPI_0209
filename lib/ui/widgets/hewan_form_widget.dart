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
  void initState(){
    super.initState();
    _namaController = TextEditingController(text: widget.intialData?.nama ?? '');
    _jenisController = TextEditingController(text: widget.intialData?.jenis ?? '');
    _tglLahirController = TextEditingController(text: widget.intialData?.tanggalLahir ?? '');
    _hargaController = TextEditingController(text: widget.intialData?.harga.toString() ?? '');
    _statusController = TextEditingController(text: widget.intialData?.status ?? '');
  }

  @override
  void dispose() {
    _namaController.dispose();
    _jenisController.dispose();
    _tglLahirController.dispose();
    _hargaController.dispose();
    _statusController.dispose();
    super.dispose();
  }
  
  void _submitForm(){
    if(_formKey.currentState!.validate()){
      final data = {
        'nama': _namaController.text,
        'jenis': _jenisController.text,
        'tanggal_lahir': _tglLahirController.text,
        'harga': int.tryParse(_hargaController.text) ?? 0,
        'status': _statusController.text,
      };
      widget.onSubmit(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
