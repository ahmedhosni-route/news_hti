import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_1am/core/base.dart';
import 'package:news_1am/modules/home/cubit/cubit.dart';
import 'package:news_1am/modules/home/cubit/state.dart';
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
  Widget build(BuildContext context) {
    return CustomBgWidget(
      child: BlocProvider(
        create: (context) => HomeCubit(),
        child: BlocConsumer<HomeCubit, HomeState>(
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
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
                title: Text(cubit.categoryData == null
                    ? "News App"
                    : cubit.categoryData!.title),
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
                        cubit.resetData();
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
              body: cubit.categoryData == null
                  ? CategoryScreen(onTap: cubit.onTapCategory)
                  : TabsScreen(
                      cubit: cubit,
                    ),
            );
          },
          listener: (context, state) {
            if (state is GetSourcesLoadingState ||
                state is GetNewsLoadingState) {
              showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    title: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              );
            }
            if (state is GetSourcesErrorState) {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(state.error),
                  );
                },
              );
            }
            if (state is GetNewsErrorState) {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(state.error),
                  );
                },
              );
            }
            if (state is GetSourcesSuccessState ||
                state is GetNewsSuccessState) {
              Navigator.pop(context);
            }
          },
        ),
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
