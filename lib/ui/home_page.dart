import 'package:dogs/bloc/get_dogs_bloc.dart';
import 'package:dogs/button.dart';
import 'package:dogs/core_data/dio_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

import '../cats_bloc/cats_bloc_bloc.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _currentIndex = 0;
  List<Widget> pages = const [DogsPage(), CatsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomSlidingToggle(
            leftLabel: 'Dogs',
            rightLabel: 'Cats',
            onChange: (val) {
              _currentIndex = val;
              val == 0
                  ? DioSettings().dio.options.baseUrl = ApiUrl.dogs
                  : DioSettings().dio.options.baseUrl = ApiUrl.cats;
              setState(() {});
              if (kDebugMode) {
                print(val);
              }
            },
          ),
        ),
        body: pages[_currentIndex]);
  }
}

class DogsPage extends StatefulWidget {
  const DogsPage({super.key});

  @override
  State<DogsPage> createState() => _DogsPageState();
}

class _DogsPageState extends State<DogsPage> {
  int _currentVal = 1;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              NumberPicker(
                  minValue: 1,
                  maxValue: 50,
                  value: _currentVal,
                  onChanged: (val) {
                    _currentVal = val;
                    setState(() {});
                  }),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<GetDogsBloc>(context).add(
                    GetDataEvent(
                      count: _currentVal,
                    ),
                  );
                },
                child: const Text('get image'),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Expanded(
            child: BlocBuilder<GetDogsBloc, GetDogsState>(
              builder: (context, state) {
                if (state is GetDogsSuccess) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.model.message?.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 300,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                        ),
                        child: Image.network(
                          state.model.message?[index] ?? '',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CatsPage extends StatelessWidget {
  const CatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CatsBlocBloc>(context).add(
      GetCatsDataEvent(),
    );
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<CatsBlocBloc, CatsBlocState>(
            builder: (context, state) {
              if (state is CatsBlocSuccess) {
                return Center(
                  child: Image.network(
                    state.model.file ?? '',
                    fit: BoxFit.fill,
                    height: 300,
                  ),
                );
              }
              if (state is CatsBlocLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CatsBlocError) {
                return const Text('error');
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
