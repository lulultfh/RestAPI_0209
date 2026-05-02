import 'dart:ui';

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
    _namaController = TextEditingController(
      text: widget.initialData?.nama ?? '',
    );
    _jenisController = TextEditingController(
      text: widget.initialData?.jenis ?? '',
    );
    _tglLahirController = TextEditingController(
      text: widget.initialData?.tanggalLahir ?? '',
    );
    _hargaController = TextEditingController(
      text: widget.initialData?.harga.toString() ?? '',
    );
    _statusController = TextEditingController(
      text: widget.initialData?.status ?? '',
    );
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        String formattedDate =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        _tglLahirController.text = formattedDate;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final statusInput = _statusController.text.toLowerCase().trim();
      if (statusInput != 'tersedia' && statusInput != 'terjual') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Status hanya boleh diisi "tersedia" atau "terjual" ya!',
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }
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
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildGlassTextField(
                      controller: _namaController,
                      hint: 'Nama Hewan',
                      icon: Icons.pets,
                      validator: (value) =>
                          value!.isEmpty ? 'Nama tidak boleh kosong' : null,
                    ),
                    const SizedBox(height: 20),
                    _buildGlassTextField(
                      controller: _jenisController,
                      hint: 'Jenis Hewan',
                      icon: Icons.category,
                      validator: (value) =>
                          value!.isEmpty ? 'Jenis tidak boleh kosong' : null,
                    ),
                    const SizedBox(height: 20),
                    _buildGlassTextField(
                      controller: _tglLahirController,
                      hint: 'Tanggal Lahir Hewan',
                      icon: Icons.calendar_today,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      validator: (value) => value!.isEmpty
                          ? 'Tanggal Lahir tidak boleh kosong'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    _buildGlassTextField(
                      controller: _hargaController,
                      hint: 'Harga Hewan',
                      icon: Icons.monetization_on,
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'Harga tidak boleh kosong' : null,
                    ),
                    const SizedBox(height: 20),
                    _buildGlassTextField(
                      controller: _statusController,
                      hint: 'Status Hewan (tersedia/terjual)',
                      icon: Icons.info_outline,
                      // keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'Status tidak boleh kosong' : null,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.purple.shade700,
                          // foregroundColor: const Color(0xff1a237e),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 5,
                        ),
                        onPressed: widget.isLoading ? null : _submitForm,
                        child: widget.isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                ),
                              )
                            : Text(
                                widget.initialData == null
                                    ? 'Simpan Data'
                                    : 'Update Data',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        validator: validator,
        readOnly: readOnly,
        onTap: onTap,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          // hintText: hint,
          // hintStyle: const TextStyle(color: Colors.white60),
          labelText: hint,
          labelStyle: const TextStyle(color: Colors.white60),
          prefixIcon: Icon(icon, color: Colors.white70),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          errorStyle: const TextStyle(
            color: Colors.yellowAccent,
            fontWeight: FontWeight.bold,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
        ),
      ),
    );
  }
}
