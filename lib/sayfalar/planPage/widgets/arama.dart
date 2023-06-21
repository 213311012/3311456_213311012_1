
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_is_empty, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:gezi_uygulamam/sayfalar/planPage/data/local_storage.dart';
import 'package:gezi_uygulamam/sayfalar/planPage/model/task_model.dart';
import 'package:gezi_uygulamam/sayfalar/planPage/widgets/task_list_item.dart';

import '../../../main.dart';


class CustomSearchDelegate extends SearchDelegate {
  final List<Task> allTasks;

  CustomSearchDelegate({required this.allTasks});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query.isEmpty ? null : query = '';
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        close(context, null);
      },
      child: const Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
        size: 24,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    
    List<Task> filteredList = allTasks.where(
        (gorev) => gorev.name.toLowerCase().contains(query.toLowerCase())).toList();
    return filteredList.length > 0 ? ListView.builder(
              itemBuilder: (context, index) {
                var _oankiListeElemani = filteredList[index];
                return Dismissible(
                  background: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                     const Icon(
                        Icons.delete,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text('Rotayı Sil')
                    ],
                  ),
                  key: Key(_oankiListeElemani.id),
                  onDismissed: (direction) async{
                    filteredList.removeAt(index);
                    await locator<LocalStorage>().deleteTask(task: _oankiListeElemani);
                   
                  },
                  child: TaskListItem(task: _oankiListeElemani),
                );
              },
              itemCount: filteredList.length,
            ):  Center(child: Text('Arama Bulunamadı'),);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
