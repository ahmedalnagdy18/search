import 'package:flutter/material.dart';
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
  final List<Map<String, dynamic>> _allUsersInCart = [
    {"id": 1, "name": "Ahmed Alnagdy"},
    {"id": 2, "name": "Mahmoud"},
    {"id": 3, "name": "Zayed"},
    {"id": 4, "name": "Omar"},
    {"id": 5, "name": "Gasser"},
  ];

  List<Map<String, dynamic>> _foundUsers = [];
  bool _showProduct = false;
  bool _itemsAdded = false;

  @override
  initState() {
    _foundUsers = _allUsers;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
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

  void _toggleGreenContainerVisibility() {
    setState(() {
      if (_showProduct) {
        _showProduct = true;
      } else {
        _showProduct = true;
      }
      _itemsAdded = true;
    });
  }

  void removeDynamicWidget() {
    setState(() {
      _showProduct = false;
      _itemsAdded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                            return StoryCartList(onTap: removeDynamicWidget);
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 10),
                          itemCount: _allUsersInCart.length,
                        ),
                      )
                    : const Center(child: Text("Add Products here ...")),
                const SizedBox(height: 20),
                TextfieldWidget(
                  onChanged: (value) => _runFilter(value),
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
                          itemCount: _foundUsers.length,
                          itemBuilder: (context, index) {
                            return Container(
                              key: ValueKey(_foundUsers[index]["id"]),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ExpansionTile(
                                backgroundColor: Colors.grey.shade200,
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(35)),
                                title: Text(_foundUsers[index]['name'],
                                    style:
                                        const TextStyle(color: Colors.black)),
                                children: [
                                  ListView.separated(
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      "https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671142.jpg?size=338&ext=jpg&ga=GA1.1.1395880969.1710201600&semt=ais"),
                                                  backgroundColor:
                                                      Colors.cyanAccent,
                                                ),
                                                Text(_allUsersInCart[index]
                                                    ['name']),
                                              ],
                                            ),
                                            AppButtonWidget(
                                              onPressed: () {
                                                _toggleGreenContainerVisibility();
                                              },
                                              color: _itemsAdded
                                                  ? Colors.red
                                                  : const Color.fromARGB(
                                                      255, 103, 145, 141),
                                              text: _itemsAdded
                                                  ? "remove"
                                                  : "add",
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: _allUsersInCart.length,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    separatorBuilder: (context, index) =>
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
    );
  }
}
