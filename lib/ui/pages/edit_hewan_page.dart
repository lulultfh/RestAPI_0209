import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restapi_flutter/data/models/hewan_models.dart';
import 'package:restapi_flutter/logic/bloc/hewan/hewan_bloc.dart';
import 'package:restapi_flutter/logic/bloc/hewan/hewan_event.dart';
import 'package:restapi_flutter/logic/bloc/hewan/hewan_state.dart';
import 'package:restapi_flutter/ui/widgets/hewan_form_widget.dart';

class EditHewanPage extends StatelessWidget {
  final HewanModel hewan;

  const EditHewanPage({super.key, required this.hewan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Hewan')),
      body: BlocConsumer<HewanBloc, HewanState>(
        listener: (context, state) {
          if (state is HewanCreatedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Data hewan berhasil diupdate')),
            );
            Navigator.pop(context);
          } else if (state is HewanError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal: ${state.message}')),
            );
          }
        },
        builder: (context, state){
          final isLoading = state is HewanLoading;
          return HewanFormWidget(
            isLoading: isLoading,
            onSubmit: (data){
              context.read<HewanBloc>().add(UpdateHewan(hewan.id, data));
            });
        },
      ),
    );
  }
}
