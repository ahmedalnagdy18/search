import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final _searchController = TextEditingController();
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Cart 1"},
    {"id": 2, "name": "Cart 2"},
    {"id": 3, "name": "Cart 3"},
    {"id": 4, "name": "Cart 4"},
    {"id": 5, "name": "Cart 5"},
    {"id": 6, "name": "Cart 6"},
    {"id": 7, "name": "Cart 7"},
    {"id": 8, "name": "Cart 8"},
    {"id": 9, "name": "Cart 9"},
    {"id": 10, "name": "Cart 10"},
  ];

  List<Map<String, dynamic>> _foundUsers = [];
  bool _showProduct = false;
  bool _itemsAdded = false;

  @override
  initState() {
    _foundUsers = _allUsers;
    super.initState();
  }

  void _searchFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundUsers = results;
    });
  }

  void _addToStory(Map<String, dynamic> cartData) {
    setState(() {
      if (_showProduct && _itemsAdded) {
        _showProduct = false;
        _itemsAdded = false;
      } else {
        _showProduct = true;
        _itemsAdded = true;
      }
    });
  }

  void removeFromStory() {
    setState(() {
      _showProduct = false;
      _itemsAdded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartsCubit, CartsState>(
      listener: (context, state) {},
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
                        _showProduct
                            ? SizedBox(
                                height: 80,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final cart = state.carts[index];
                                    return StoryCartList(
                                      onTap: removeFromStory,
                                      backgroundImage: NetworkImage(
                                          cart.products[index].thumbnail),
                                      title: "Price: ${cart.products}",
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 10),
                                  itemCount: state.carts.length,
                                ),
                              )
                            : const Center(
                                child: Text("Add Products here ...")),
                        const SizedBox(height: 20),
                        TextfieldWidget(
                          onChanged: (value) => _searchFilter(value),
                          controller: _searchController,
                          onPressed: () {
                            _searchController.clear();
                          },
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: _foundUsers.isNotEmpty
                              ? ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: state.carts.length,
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
                                                            .toJson());
                                                      },
                                                      color: _itemsAdded
                                                          ? Colors.red
                                                          : const Color
                                                              .fromARGB(255,
                                                              103, 145, 141),
                                                      text: _itemsAdded
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
