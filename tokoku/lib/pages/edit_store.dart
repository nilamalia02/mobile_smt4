import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokoku/cubit/store_cubit.dart';
import 'package:tokoku/models/store_model.dart';

class EditStore extends StatefulWidget {
  final StoreModel store;
  EditStore({Key? key, required this.store}) : super(key: key);

  @override
  State<EditStore> createState() => EditStoreState();
}

class EditStoreState extends State<EditStore> {
  TextEditingController _namaTokoController = TextEditingController(text: '');
  TextEditingController _alamatController = TextEditingController(text: '');

  @override
  void initState() {
    _namaTokoController.text = widget.store.namaToko;
    _alamatController.text = widget.store.alamat;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            'Form Store',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 40,
          ),
          TextFormField(
            controller: _namaTokoController,
            onChanged: (val) => setState(() {}),
            decoration: InputDecoration(
              labelText: 'Nama',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: _namaTokoController.text.isEmpty
                        ? Colors.red
                        : Colors.green),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          TextFormField(
            controller: _alamatController,
            onChanged: (val) => setState(() {}),
            decoration: InputDecoration(
              labelText: 'Alamat',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: _alamatController.text.isEmpty
                        ? Colors.red
                        : Colors.green),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 20),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {
                // check if all field is filled
                if (_namaTokoController.text.isEmpty ||
                    _alamatController.text.isEmpty) {
                  // ignore: deprecated_member_use
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('All field must be filled'),
                          actions: [
                            // ignore: deprecated_member_use
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            )
                          ],
                        );
                      });
                } else {
                  BlocProvider.of<StoreCubit>(context).editStore(
                    StoreModel(
                      id: widget.store.id,
                      namaToko: _namaTokoController.text,
                      alamat: _alamatController.text,
                    ),
                  );
                  Navigator.pop(context, true);
                }
              },
              child: Text(
                'Simpan',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
