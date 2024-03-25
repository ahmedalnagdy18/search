import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_app/features/search/data/models/api_carts.dart';

import 'package:search_app/features/search/presentation/bloc/cubit/carts_cubit.dart';
import 'package:search_app/features/search/presentation/bloc/cubit/carts_state.dart';
import 'package:search_app/features/search/presentation/widgets/search_page_widget/cart_item_widget.dart';

import 'package:search_app/features/search/presentation/widgets/search_page_widget/story_cart_list.dart';
import 'package:search_app/features/search/presentation/widgets/textfield_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Cart> hh = [];
  List<Cart> jj = [];
  int ord = 0;
  pagination() {
    hh = BlocProvider.of<CartsCubit>(context).carts;
    jj.addAll(hh.sublist(ord, ord + 10));
    if (ord == 0) {
      ord = 10;
    } else {
      ord = 0;
    }
  }

  int num = 10;
  final _scrollcontroller = ScrollController();
  final _searchController = TextEditingController();
  final List<Product> _allUsers = [];
  void _searchFilter(String title, List<Cart> carts) {
    List<Product> results = [];

    if (title.isEmpty) {
      setState(() {
        _foundUsers = _allUsers;
      });
    } else {
      for (var element in carts) {
        for (var el in element.products) {
          if (el.title.toLowerCase().contains(title.toLowerCase())) {
            results.add(el);
          }
        }
      }

      setState(() {
        _foundUsers = results;
      });
    }
  }

  List<Product> _foundUsers = [];
  final List<Product> _story = [];

  @override
  initState() {
    _foundUsers = _allUsers;
    _scrollcontroller.addListener(() {
      if (_scrollcontroller.position.pixels ==
          _scrollcontroller.position.maxScrollExtent) {
        setState(() {
          pagination();
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
    return BlocConsumer<CartsCubit, CartsState>(
      listener: (context, state) {
        if (state is CartsLoaded) {
          jj = state.carts;
        }
      },
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
                                        title:
                                            "Price: ${_story[index].price} \$");
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
                            setState(() {
                              _searchController.clear();
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: _searchController.text.isEmpty
                              ? ListView.separated(
                                  controller: _scrollcontroller,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: jj.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Container(
                                          key: ValueKey(state.carts[index].id),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: ExpansionTile(
                                            backgroundColor:
                                                Colors.grey.shade300,
                                            shape: ContinuousRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(35)),
                                            title: Text("Cart ${index + 1}",
                                                style: const TextStyle(
                                                    color: Colors.black)),
                                            children: [
                                              ListView.separated(
                                                itemBuilder: (context, ind) {
                                                  return CartItemWidget(
                                                    onPressed: () {
                                                      _addToStory(jj[index]
                                                          .products[ind]);
                                                    },
                                                    color: state
                                                            .carts[index]
                                                            .products[ind]
                                                            .stutas
                                                        ? Colors.red
                                                        : const Color.fromARGB(
                                                            255, 103, 145, 141),
                                                    text: jj[index]
                                                        .products[ind]
                                                        .title,
                                                    backgroundImage:
                                                        NetworkImage(jj[index]
                                                            .products[ind]
                                                            .thumbnail),
                                                    textButton: state
                                                            .carts[index]
                                                            .products[ind]
                                                            .stutas
                                                        ? "remove"
                                                        : "add",
                                                  );
                                                },
                                                itemCount:
                                                    jj[index].products.length,
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
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 15),
                                )
                              : _searchController.text.isNotEmpty &&
                                      _foundUsers.isEmpty
                                  ? const Text(
                                      'No results found',
                                      style: TextStyle(fontSize: 24),
                                    )
                                  : ListView.separated(
                                      controller: _scrollcontroller,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: state.carts
                                          .where((element) => element.products
                                              .where((element) => element.title
                                                  .toLowerCase()
                                                  .contains(_searchController
                                                      .text
                                                      .toLowerCase()))
                                              .isNotEmpty)
                                          .length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          key: ValueKey(state.carts[index].id),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: ListView.separated(
                                            itemBuilder: (context, ind) {
                                              return CartItemWidget(
                                                onPressed: () {
                                                  _addToStory(state
                                                      .carts[index].products
                                                      .where((element) => element
                                                          .title
                                                          .toLowerCase()
                                                          .contains(
                                                              _searchController
                                                                  .text
                                                                  .toLowerCase()))
                                                      .elementAt(ind));
                                                },
                                                color: state
                                                        .carts[index].products
                                                        .where((element) => element
                                                            .title
                                                            .toLowerCase()
                                                            .contains(
                                                                _searchController
                                                                    .text
                                                                    .toLowerCase()))
                                                        .elementAt(ind)
                                                        .stutas
                                                    ? Colors.red
                                                    : const Color.fromARGB(
                                                        255, 103, 145, 141),
                                                text: state
                                                    .carts[index].products
                                                    .where((element) => element
                                                        .title
                                                        .toLowerCase()
                                                        .contains(
                                                            _searchController
                                                                .text
                                                                .toLowerCase()))
                                                    .elementAt(ind)
                                                    .title,
                                                backgroundImage: NetworkImage(state
                                                    .carts[index].products
                                                    .where((element) => element
                                                        .title
                                                        .toLowerCase()
                                                        .contains(
                                                            _searchController
                                                                .text
                                                                .toLowerCase()))
                                                    .elementAt(ind)
                                                    .thumbnail),
                                                textButton: state
                                                        .carts[index].products
                                                        .where((element) => element
                                                            .title
                                                            .toLowerCase()
                                                            .contains(
                                                                _searchController
                                                                    .text
                                                                    .toLowerCase()))
                                                        .elementAt(ind)
                                                        .stutas
                                                    ? "remove"
                                                    : "add",
                                              );
                                            },
                                            itemCount: state
                                                .carts[index].products
                                                .where((element) => element
                                                    .title
                                                    .toLowerCase()
                                                    .contains(_searchController
                                                        .text
                                                        .toLowerCase()))
                                                .length,
                                            shrinkWrap: true,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(height: 10),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 15),
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
