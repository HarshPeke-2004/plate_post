import 'package:flutter/material.dart';
import 'package:plate_post/src/features/recipe_feed/widgets/category_list_view.dart';
import 'package:plate_post/src/features/recipe_feed/widgets/featured_recipes_list_view.dart';
import 'package:plate_post/src/features/recipe_feed/widgets/popular_recipes_list_view.dart';
import 'package:plate_post/src/features/recipe_feed/widgets/today_recipes_list_view.dart';

class DiscoverTab extends StatefulWidget {
  const DiscoverTab({super.key});

  @override
  State<DiscoverTab> createState() => _DiscoverTabState();
}

class _DiscoverTabState extends State<DiscoverTab>
    with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return const CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        SliverToBoxAdapter(child: FeaturedRecipesListView()),
        SliverToBoxAdapter(child: TodayRecipesListView()),
        SliverToBoxAdapter(child: CategoryListView()),
        SliverToBoxAdapter(child: PopularRecipesListView()),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
