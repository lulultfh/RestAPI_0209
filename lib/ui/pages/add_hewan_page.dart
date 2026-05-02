import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restapi_flutter/logic/bloc/hewan/hewan_bloc.dart';
import 'package:restapi_flutter/logic/bloc/hewan/hewan_event.dart';
import 'package:restapi_flutter/logic/bloc/hewan/hewan_state.dart';
import 'package:restapi_flutter/ui/widgets/hewan_form_widget.dart';

class AddHewanPage extends StatelessWidget {
  const AddHewanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Tambah Hewan',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff1a237e), Color(0xffad1457)],
              ),
            ),
          ),
          SafeArea(
            child: BlocConsumer<HewanBloc, HewanState>(
              listener: (context, state) {
                if (state is HewanCreatedSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Hewan berhasil ditambahkan!'),
                    ),
                  );
                  Navigator.pop(context);
                } else if (state is HewanError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal: ${state.message}')),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state is HewanLoading;

                return HewanFormWidget(
                  isLoading: isLoading,
                  onSubmit: (data) {
                    context.read<HewanBloc>().add(CreateHewan(data));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
