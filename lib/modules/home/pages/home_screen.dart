import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_1am/core/base.dart';
import 'package:news_1am/modules/home/manager/home_connector.dart';
import 'package:news_1am/modules/home/pages/tabs_screen.dart';
import 'package:news_1am/modules/home/manager/home_view_model.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/custom_bg.dart';
import '../widgets/custom_list_tile_widget.dart';
import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "Home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseView<HomeScreen, HomeViewModel>
    implements HomeConnector {
  @override
  void initState() {
    super.initState();
    viewModel.connector = this;
  }

  @override
  Widget build(BuildContext context) {
    return CustomBgWidget(
      child: ChangeNotifierProvider(
        create: (context) => viewModel,
        builder: (context, child) {
          Provider.of<HomeViewModel>(context);
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.green,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              )),
              centerTitle: true,
              title: Text(viewModel.categoryData == null
                  ? "News App"
                  : viewModel.categoryData!.title),
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  const DrawerHeader(
                      decoration: BoxDecoration(color: Colors.green),
                      child: Center(
                        child: Text(
                          "News App!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white),
                        ),
                      )),
                  CustomTextTileWidget(
                    onTap: () {
                      viewModel.resetData();
                      Navigator.pop(context);
                    },
                    title: "Categories",
                    icon: Icons.menu,
                  ),
                  CustomTextTileWidget(
                    onTap: () {},
                    title: "Settings",
                    icon: Icons.settings,
                  ),
                ],
              ),
            ),
            body: viewModel.categoryData == null
                ? CategoryScreen(onTap: viewModel.onTapCategory)
                : TabsScreen(
                    viewModel: viewModel,
                  ),
          );
        },
      ),
    );
  }

  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }
}

// class  CubitTest extends Cubit<TestState> {
//   emit(state.copyWith(categories))
//
// }
// BaseApiState{}
// BaseSuccessState{}
// BasesLoadingState{}
// BaseFailureState{}
//
// class TestState {
//   BaseApiState categoriesApiState
//
//   BaseApiState productsApiState
// }
