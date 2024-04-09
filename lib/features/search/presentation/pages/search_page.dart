import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_app/constant/strings.dart';
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
  List<Cart> carts = [];
  List<Product> story = [];

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

  @override
  initState() {
    _scrollcontroller.addListener(_scrolllistner);
    _foundUsers = _allUsers;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartsCubit, CartsState>(
      listener: (context, state) {
        if (state is CartsLoaded) {
          carts = state.carts;
        }
        if (state is Cartsadded) {
          story = state.products;
        }
      },
      builder: (context, state) => state is CartsLoaded || state is Cartsadded
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
                        story.isNotEmpty
                            ? SizedBox(
                                height: 80,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return StoryCartList(
                                        onTap: (() =>
                                            BlocProvider.of<CartsCubit>(context)
                                                .addToStory(story[index])),
                                        backgroundImage: NetworkImage(
                                            story[index].thumbnail),
                                        title:
                                            "Price: ${story[index].price} \$");
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 10),
                                  itemCount: story.length,
                                ),
                              )
                            : const Center(
                                child: Text("Add Products here ...")),
                        const SizedBox(height: 20),
                        TextfieldWidget(
                          onChanged: (value) => _searchFilter(value, carts),
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
                                  itemCount: carts.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index < carts.length) {
                                      return Column(
                                        children: [
                                          Container(
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
                                                      BorderRadius.circular(
                                                          35)),
                                              title: Text("Cart ${index + 1}",
                                                  style: const TextStyle(
                                                      color: Colors.black)),
                                              children: [
                                                ListView.separated(
                                                  itemBuilder: (context, ind) {
                                                    return CartItemWidget(
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                                    CartsCubit>(
                                                                context)
                                                            .addToStory(carts[
                                                                    index]
                                                                .products[ind]);
                                                      },
                                                      color: carts[index]
                                                              .products[ind]
                                                              .stutas
                                                          ? Colors.red
                                                          : const Color
                                                              .fromARGB(255,
                                                              103, 145, 141),
                                                      text: carts[index]
                                                          .products[ind]
                                                          .title,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              carts[index]
                                                                  .products[ind]
                                                                  .thumbnail),
                                                      textButton: carts[index]
                                                              .products[ind]
                                                              .stutas
                                                          ? "remove"
                                                          : "add",
                                                    );
                                                  },
                                                  itemCount: carts[index]
                                                      .products
                                                      .length,
                                                  shrinkWrap: true,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          const SizedBox(
                                                              height: 10),
                                                ),
                                                const SizedBox(height: 20),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      );
                                    } else {
                                      return const Center(
                                          child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                          color: Color(appContentColor),
                                        ),
                                      ));
                                    }
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
                                      itemCount: carts
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
                                          key: ValueKey(carts[index].id),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: ListView.separated(
                                            itemBuilder: (context, ind) {
                                              return CartItemWidget(
                                                onPressed: () {
                                                  setState(() {
                                                    BlocProvider.of<CartsCubit>(
                                                            context)
                                                        .addToStory(carts[index]
                                                            .products
                                                            .where((element) => element
                                                                .title
                                                                .toLowerCase()
                                                                .contains(
                                                                    _searchController
                                                                        .text
                                                                        .toLowerCase()))
                                                            .elementAt(ind));
                                                  });
                                                },
                                                color: carts[index]
                                                        .products
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
                                                text: carts[index]
                                                    .products
                                                    .where((element) => element
                                                        .title
                                                        .toLowerCase()
                                                        .contains(
                                                            _searchController
                                                                .text
                                                                .toLowerCase()))
                                                    .elementAt(ind)
                                                    .title,
                                                backgroundImage: NetworkImage(carts[
                                                        index]
                                                    .products
                                                    .where((element) => element
                                                        .title
                                                        .toLowerCase()
                                                        .contains(
                                                            _searchController
                                                                .text
                                                                .toLowerCase()))
                                                    .elementAt(ind)
                                                    .thumbnail),
                                                textButton: carts[index]
                                                        .products
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
                                            itemCount: carts[index]
                                                .products
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
              child: CircularProgressIndicator(
                color: Color(appContentColor),
              ),
            )),
    );
  }

  Future<void> _scrolllistner() async {
    if (_scrollcontroller.position.pixels ==
        _scrollcontroller.position.maxScrollExtent) {
      setState(() {});
      await BlocProvider.of<CartsCubit>(context).paginateCarts();
      setState(() {});
    }
  }
}
