import 'package:flutter/material.dart';
import 'package:restapi_flutter/data/models/hewan_models.dart';

class HewanFormWidget extends StatefulWidget {
  final HewanModel? initialData;
  final void Function(Map<String, dynamic> data) onSubmit;
  final bool isLoading;

  const HewanFormWidget({
    super.key,
    this.initialData,
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
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.initialData?.nama ?? '',);
    _jenisController = TextEditingController(text: widget.initialData?.jenis ?? '',);
    _tglLahirController = TextEditingController(text: widget.initialData?.tanggalLahir ?? '',);
    _hargaController = TextEditingController(text: widget.initialData?.harga.toString() ?? '',);
    _statusController = TextEditingController(text: widget.initialData?.status ?? '',);
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
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
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _namaController,
            decoration: const InputDecoration(labelText: 'Nama Hewan'),
            validator: (value) =>
                value!.isEmpty ? 'Nama tidak boleh kosong' : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _jenisController,
            decoration: const InputDecoration(labelText: 'Jenis Hewan'),
            validator: (value) =>
                value!.isEmpty ? 'Jenis tidak boleh kosong' : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _tglLahirController,
            decoration: const InputDecoration(labelText: 'Tanggal Lahir'),
            validator: (value) =>
                value!.isEmpty ? 'Tanggal Lahir tidak boleh kosong' : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _hargaController,
            decoration: const InputDecoration(labelText: 'Harga'),
            keyboardType: TextInputType.number,
            validator: (value) =>
                value!.isEmpty ? 'Harga tidak boleh kosong' : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _statusController,
            decoration: const InputDecoration(labelText: 'Status'),
            // keyboardType: TextInputType.number,
            validator: (value) =>
                value!.isEmpty ? 'Status tidak boleh kosong' : null,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: widget.isLoading ? null : _submitForm,
            child: widget.isLoading
                ? const CircularProgressIndicator()
                : Text(
                    widget.initialData == null ? 'Simpan Data' : 'Update Data',
                  ),
          ),
        ],
      ),
    );
  }
}
