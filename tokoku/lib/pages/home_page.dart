import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokoku/cubit/auth_cubit.dart';
import 'package:tokoku/cubit/store_cubit.dart';
import 'package:tokoku/models/store_model.dart';
import 'package:tokoku/pages/add_store.dart';
import 'package:tokoku/pages/edit_store.dart';
import 'package:tokoku/widgets/store_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<StoreCubit>().getStores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Container(
              margin: EdgeInsets.only(top: 40),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tokoku',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Selamat Datang, ${state.user.namaToko}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.refresh),
                      color: Colors.green,
                      onPressed: () {
                        BlocProvider.of<StoreCubit>(context).getStores();
                      }),
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        },
      );
    }

    Widget stores(List<StoreModel> stores) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: stores
                .map((StoreModel storeModel) => StoreItem(store: storeModel))
                .toList(),
          ),
        ],
      );
    }

    return Scaffold(
      body: BlocConsumer<StoreCubit, StoreState>(
        listener: (context, state) {
          if (state is StoreFailure) {
            // ignore: deprecated_member_use
            print(state.error);
          }
        },
        builder: (context, state) {
          if (state is StoreLoaded) {
            return ListView(
              padding: EdgeInsets.all(24),
              children: [
                header(),
                stores(state.stores),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddStore();
          }));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
