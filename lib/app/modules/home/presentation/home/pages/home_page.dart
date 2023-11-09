import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:nasa_pic_day/shared/helpers/errors.dart';
import 'package:nasa_pic_day/shared/helpers/formater.dart';
import '../../../domain/entities/planetary.dart';
import '../controllers/home_store.dart';
import '../../components/planetary_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_scrollListener);
    store.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25.7))),
          child: TextField(
              controller: store.controllerSearch,
              onChanged: store.searchByString,
              decoration: InputDecoration(
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                labelStyle: const TextStyle(color: Colors.grey),
                floatingLabelStyle:
                    TextStyle(color: Theme.of(context).primaryColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColorLight),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                alignLabelWithHint: true,
              )),
        ),
      ),
      body: SafeArea(
        child: ScopedBuilder<HomeStore, Failure, List<Planetary>>(
          store: store,
          onLoading: (_) => const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
          onError: (_, error) => buildError(error),
          onState: (_, List<Planetary> state) {
            return RefreshIndicator(
              onRefresh: () async => store.init(),
              child: SingleChildScrollView(
                controller: _controller,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () => store.getDateStart(context),
                            child: Text(
                              dateFormatter(store.dateStart),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            )),
                        const Text('-'),
                        TextButton(
                            onPressed: () => store.getDateEnd(context),
                            child: Text(
                              dateFormatter(store.dateEnd),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ))
                      ],
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return state[index].mediaType == "image"
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: PlanetaryListItem(
                                      planetary: state[index]),
                                )
                              : const SizedBox();
                        })
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildError(Failure? error) {
    if (error is InternetConnectionFailure) {
      return Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: Column(
            children: [
              const Text(
                'Olá, infelizmente você está sem conexão com a internet. Por favor verifique sua rede e tente novamente.',
                textAlign: TextAlign.center,
              ),
              IconButton(
                  onPressed: store.init,
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      );
    }
    return SizedBox();
  }

  void _scrollListener() {
    if (_controller.position.extentAfter < 500) {
      if (!store.isGetMorePlanetary) {
        store.getMorePlanetary();
      }
    }
  }
}
