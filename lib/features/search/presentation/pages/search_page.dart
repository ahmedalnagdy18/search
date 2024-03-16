import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_app/features/search/data/models/api_carts.dart';

import 'package:search_app/features/search/presentation/bloc/cubit/carts_cubit.dart';
import 'package:search_app/features/search/presentation/bloc/cubit/carts_state.dart';
import 'package:search_app/features/search/presentation/widgets/app_button.dart';
import 'package:search_app/features/search/presentation/widgets/search_page_widget/story_cart_list.dart';
import 'package:search_app/features/search/presentation/widgets/textfield_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int num = 10;
  final _scrollcontroller = ScrollController();
  final _searchController = TextEditingController();
  final List<Cart> _allUsers = [];
  void _searchFilter(String title, List<Cart> carts) {
    List<Cart> results = [];

    if (title.isEmpty) {
      setState(() {
        _foundUsers = _allUsers;
      });
    } else {
      for (var i = 0; i < carts.length; i++) {
        List<Product> hh = carts[i]
            .products
            .where((element) =>
                element.title.toLowerCase().contains(title.toLowerCase()))
            .toList();
        results.add(Cart(id: carts[i].id, products: hh));
        for (var j = 0; j < results.length; j++) {
          if (results[j].products.isEmpty) {
            results.removeAt(j);
          }
        }
      }

      setState(() {
        _foundUsers = results;
      });
    }
  }

  List<Cart> _foundUsers = [];
  final List<Product> _story = [];

  @override
  initState() {
    _foundUsers = _allUsers;
    _scrollcontroller.addListener(() {
      if (_scrollcontroller.position.pixels ==
          _scrollcontroller.position.maxScrollExtent) {
        setState(() {
          num = 20;
        });
      }
    });
    super.initState();
  }

  void _addToStory(Product product) {
    setState(() {
      if (product.stutas == false) {
        product.stutas = true;
        _story.add(product);
      } else {
        product.stutas = false;
        _story.remove(product);
      }
    });
  }

  void removeFromStory(Product product) {
    setState(() {
      product.stutas = false;
      _story.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartsCubit, CartsState>(
      builder: (context, state) => state is CartsLoaded
          ? SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        _story.isNotEmpty
                            ? SizedBox(
                                height: 80,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return StoryCartList(
                                        onTap: (() =>
                                            removeFromStory(_story[index])),
                                        backgroundImage: NetworkImage(
                                            _story[index].thumbnail),
                                        title: "Price: ${_story[index].price}");
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 10),
                                  itemCount: _story.length,
                                ),
                              )
                            : const Center(
                                child: Text("Add Products here ...")),
                        const SizedBox(height: 20),
                        TextfieldWidget(
                          onChanged: (value) =>
                              _searchFilter(value, state.carts),
                          controller: _searchController,
                          onPressed: () {
                            _searchController.clear();
                          },
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: _searchController.text.isEmpty
                              ? ListView.separated(
                                  controller: _scrollcontroller,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: num,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      key: ValueKey(state.carts[index].id),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ExpansionTile(
                                        backgroundColor: Colors.grey.shade200,
                                        shape: ContinuousRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(35)),
                                        title: Text(
                                            "Cart ${state.carts[index].id}",
                                            style: const TextStyle(
                                                color: Colors.black)),
                                        children: [
                                          ListView.separated(
                                            itemBuilder: (context, ind) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(state
                                                                    .carts[
                                                                        index]
                                                                    .products[
                                                                        ind]
                                                                    .thumbnail),
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                          Text(
                                                            state
                                                                .carts[index]
                                                                .products[ind]
                                                                .title,
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    AppButtonWidget(
                                                      onPressed: () {
                                                        _addToStory(state
                                                            .carts[index]
                                                            .products[ind]);
                                                      },
                                                      color: state
                                                              .carts[index]
                                                              .products[ind]
                                                              .stutas
                                                          ? Colors.red
                                                          : const Color
                                                              .fromARGB(255,
                                                              103, 145, 141),
                                                      text: state
                                                              .carts[index]
                                                              .products[ind]
                                                              .stutas
                                                          ? "remove"
                                                          : "add",
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            itemCount: state
                                                .carts[index].products.length,
                                            shrinkWrap: true,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(height: 10),
                                          ),
                                          const SizedBox(height: 20),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 15),
                                )
                              : _searchController.text.isNotEmpty
                                  ? ListView.separated(
                                      controller: _scrollcontroller,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: _foundUsers.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          key: ValueKey(_foundUsers[index].id),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: ExpansionTile(
                                            backgroundColor:
                                                Colors.grey.shade200,
                                            shape: ContinuousRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(35)),
                                            title: Text(
                                                "Cart ${_foundUsers[index].id}",
                                                style: const TextStyle(
                                                    color: Colors.black)),
                                            children: [
                                              ListView.separated(
                                                itemBuilder: (context, ind) {
                                                  return Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 20,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade200,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundImage:
                                                                    NetworkImage(_foundUsers[
                                                                            index]
                                                                        .products[
                                                                            ind]
                                                                        .thumbnail),
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                              Text(
                                                                _foundUsers[
                                                                        index]
                                                                    .products[
                                                                        ind]
                                                                    .title,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        AppButtonWidget(
                                                          onPressed: () {
                                                            _addToStory(_foundUsers[
                                                                    index]
                                                                .products[ind]);
                                                          },
                                                          color: _foundUsers[
                                                                      index]
                                                                  .products[ind]
                                                                  .stutas
                                                              ? Colors.red
                                                              : const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  103,
                                                                  145,
                                                                  141),
                                                          text: _foundUsers[
                                                                      index]
                                                                  .products[ind]
                                                                  .stutas
                                                              ? "remove"
                                                              : "add",
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                itemCount: _foundUsers[index]
                                                    .products
                                                    .length,
                                                shrinkWrap: true,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                separatorBuilder: (context,
                                                        index) =>
                                                    const SizedBox(height: 10),
                                              ),
                                              const SizedBox(height: 20),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 15),
                                    )
                                  : const Text(
                                      'No results found',
                                      style: TextStyle(fontSize: 24),
                                    ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : const Scaffold(
              body: Center(
              child: CircularProgressIndicator(),
            )),
    );
  }
}
