import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:vizmo_employee_management_app/bloc/employee/employee_bloc.dart';
import 'package:vizmo_employee_management_app/services/app_api_client.dart';
import 'package:vizmo_employee_management_app/services/app_repository.dart';
import 'package:vizmo_employee_management_app/utils/app_colors.dart';
import 'package:vizmo_employee_management_app/view_models/employee_view_model.dart';
import 'package:vizmo_employee_management_app/widgets/employee_item.dart';

import '../models/employee_model.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({Key? key}) : super(key: key);

  @override
  _EmployeesScreenState createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  late EmployeeViewModel viewModel;
  late AppRepository repository;
  late EmployeeBloc bloc;
  late ScrollController scrollController;

  @override
  void initState() {
    viewModel = EmployeeViewModel();
    scrollController = ScrollController();
    scrollController.addListener(pagination);

    repository = AppRepository(apiClient: AppApiClient(httpClient: Client()));
    bloc = EmployeeBloc(repository);
    callRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: viewModel.isSearching
            ? TextField(
              controller: viewModel.searchController,
              onChanged: searchTextChanged,
              cursorColor: AppColors.primaryColor,
              style: const TextStyle(
                color: AppColors.primaryColor
              ),
            )
            : Text(
              "All Employees",
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 20,
                  fontFamily: GoogleFonts.lato().fontFamily,
                  fontWeight: FontWeight.bold
              ),
            ),
        actions: [
          if(viewModel.isSearching)
            PopupMenuButton(
                icon: const Icon(Icons.filter_alt_rounded),
                itemBuilder: (context){
                  return List.generate(viewModel.columns.length, (index){
                    return PopupMenuItem(
                      child: Text("Filter by ${viewModel.columns[index]}"),
                      onTap: ()=>setState(() {
                        viewModel.filter = viewModel.columns[index];
                        callRequest();
                      }),
                    );
                  });
                }),

          IconButton(onPressed: (){
            setState(() {
              viewModel.isSearching = !viewModel.isSearching;
              if(!viewModel.isSearching){
                viewModel.sortBy = "";
                viewModel.filter = "";
                viewModel.searchKey = "";
                setState(() {});
                callRequest();
              }
            });
          }, icon: Icon(viewModel.isSearching ? Icons.close : CupertinoIcons.search),splashRadius: 20,),

          PopupMenuButton(
              icon: const Icon(Icons.sort_rounded),
              itemBuilder: (context){
                return List.generate(viewModel.columns.length, (index){
                  return PopupMenuItem(
                    child: Text("Sort by ${viewModel.columns[index]}"),
                    onTap: ()=>setState(() {
                      viewModel.sortBy = viewModel.columns[index];
                      callRequest();
                    }),
                  );
                });
              }
          )
        ],
        backgroundColor: AppColors.secondaryColor,
      ),
      body: BlocBuilder<EmployeeBloc,EmployeeState>(
        bloc: bloc,
        builder: (context, state){
          if(state is EmployeeLoading){
            if(viewModel.page==1){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }else{
              return body(viewModel.employees);
            }
          }else if(state is EmployeeFetched){
            viewModel.employees = state.data;
            viewModel.isLoadMore = false;
            return body(state.data);
          }else if(state is EmployeeFailed){
            return const Center(
              child: Text(
                  "Sorry! Not Found",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                  ),
              ),
            );
          }else {
            return Container();
          }
        },
      ),
    );
  }

  Widget body(List<EmployeeModel> employees){
    return Column(
      children: [
        if(viewModel.sortBy.isNotEmpty || viewModel.filter.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(15),
            color: AppColors.secondaryColor,
            child: Row(
              children: [
                if(viewModel.sortBy.isNotEmpty)
                  const Padding(padding: EdgeInsets.all(5), child: Text("Sort By",style: TextStyle(color: AppColors.primaryColor),),),
                if(viewModel.sortBy.isNotEmpty)
                  Chip(label: Text(viewModel.sortBy, style: const TextStyle(color: AppColors.primaryColor),), backgroundColor: AppColors.accentColor,),
                if(viewModel.filter.isNotEmpty)
                  const Padding(padding: EdgeInsets.all(5), child: Text("Filter By",style: TextStyle(color: AppColors.primaryColor),),),
                if(viewModel.filter.isNotEmpty)
                  Chip(label: Text(viewModel.filter, style: const TextStyle(color: AppColors.primaryColor),), backgroundColor: AppColors.accentColor,),
              ],
            ),
          ),
        Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
              controller: scrollController,
              itemCount: employees.length,
              itemBuilder: (BuildContext context, index){
                return EmployeeItem(employee: employees[index]);
              },
            )
        ),
        if(viewModel.isLoadMore)
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 40),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }

  void pagination(){
    if((scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) && viewModel.employees.isNotEmpty){
      viewModel.page+=1;
      viewModel.isLoadMore = true;
      callRequest(isNextPage: true);
    }
  }

  void searchTextChanged(searchKey){
    viewModel.searchKey = searchKey;
    callRequest();
  }

  /*
   callRequest will add event to bloc to fetch data.
   */
  void callRequest({bool? isNextPage}){
    bloc.add(
        GetAllEmployeesEvent(
            page: viewModel.page,
            employees: viewModel.employees,
            sortBy: viewModel.sortBy,
            search: viewModel.searchKey,
            filter: viewModel.filter,
            isNextPage: isNextPage??false
        )
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
