import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:rick_and_morty/business_logic/cubit/character_cubit.dart';
import 'package:rick_and_morty/presentation/widgets/list_view_custom_widget.dart';

import '../../data/models/character_model.dart';
import '../../helper/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Character> allCharacter;
  late List<Character> searchForCharacter = [];
  bool _isSearching = false;
  final _searchTextController = TextEditingController();
  bool _showOnlineIndicator = false; // متغير لتحديد عرض شريط الاتصال

  // Text field for searching characters
  Widget _buildSearchTextField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: AppColors.backgroundColor,
      decoration: InputDecoration(
        hintText: "Find your character",
        hintStyle: TextStyle(
          color: backgroundColorWithOpacity(0.5),
        ),
        border: InputBorder.none,
      ),
      style: const TextStyle(color: AppColors.backgroundColor, fontSize: 18),
      onChanged: (searchedCharacter) {
        _addResultSearchForCharacterList(searchedCharacter);
      },
    );
  }

  // Filter characters based on search input
  void _addResultSearchForCharacterList(String searchedCharacter) {
    setState(() {
      if (searchedCharacter.isEmpty) {
        searchForCharacter = allCharacter;
      } else {
        searchForCharacter = allCharacter
            .where((character) => character.name!
                .toLowerCase()
                .startsWith(searchedCharacter.toLowerCase()))
            .toList();
      }
    });
  }

  // App bar actions based on search state
  List<Widget> _buildAppBarAction() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: _stopSearching,
          icon: const Icon(Icons.clear, color: AppColors.surfaceColor),
        )
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearching,
          icon: const Icon(Icons.search, color: AppColors.surfaceColor),
        )
      ];
    }
  }

  // Start search mode
  void _startSearching() {
    setState(() {
      _isSearching = true;
      searchForCharacter = allCharacter;
    });
    ModalRoute.of(context)?.addLocalHistoryEntry(
      LocalHistoryEntry(onRemove: _stopSearching),
    );
  }

  // Stop search mode
  void _stopSearching() {
    setState(() {
      _isSearching = false;
      _searchTextController.clear();
      searchForCharacter = [];
    });
  }

  @override
  void initState() {
    super.initState();
    try {
      BlocProvider.of<CharacterCubit>(context).getAllCharacter();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _isSearching
            ? _buildSearchTextField()
            : const Text(
                'Rick And Morty Character',
                style: TextStyle(color: AppColors.surfaceColor, fontSize: 20),
              ),
        actions: _buildAppBarAction(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            List<ConnectivityResult> connectivity, Widget child) {
          final bool connected =
              !connectivity.contains(ConnectivityResult.none);

          return Stack(
            fit: StackFit.expand,
            children: [
              child,
              Positioned(
                left: 0.0,
                right: 0.0,
                height: connected ? 0.0 : 30.0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  color: connected ? Colors.green : Colors.red,
                  child: Center(
                    child: Text(
                      connected ? "ONLINE" : "OFFLINE",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        child: buildBlocWidget(),
      ),
    );
  }

  // Bloc widget for handling character states
  Widget buildBlocWidget() => BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
          if (state is CharacterLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else if (state is CharacterLoaded) {
            allCharacter = state.character;

            return _isSearching
                ? _buildSearchResultView()
                : ListViewCustomWidget(characters: allCharacter);
          } else if (state is CharacterError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<CharacterCubit>(context)
                          .getAllCharacter();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      );

  // Display search results or message if no results
  Widget _buildSearchResultView() {
    if (searchForCharacter.isEmpty && _searchTextController.text.isEmpty) {
      return const Center(
        child: Text(
          'Start typing to search for characters...',
          style: TextStyle(color: AppColors.greyDark, fontSize: 16),
        ),
      );
    } else if (searchForCharacter.isEmpty) {
      return const Center(
        child: Text(
          'No characters found',
          style: TextStyle(color: AppColors.greyDark, fontSize: 16),
        ),
      );
    } else {
      return ListViewCustomWidget(characters: searchForCharacter);
    }
  }

  static Color backgroundColorWithOpacity(double opacity) {
    return AppColors.greyLight.withOpacity(opacity);
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }
}
