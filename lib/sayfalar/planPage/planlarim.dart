// ignore_for_file: unnecessary_null_comparison, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:gezi_uygulamam/main.dart';

import 'package:gezi_uygulamam/sayfalar/planPage/data/local_storage.dart';
import 'package:gezi_uygulamam/sayfalar/planPage/model/task_model.dart';
import 'package:gezi_uygulamam/sayfalar/planPage/widgets/arama.dart';
import 'package:gezi_uygulamam/sayfalar/planPage/widgets/task_list_item.dart';

class Planlarim extends StatefulWidget {
  const Planlarim({super.key});

  @override
  State<Planlarim> createState() => _PlanlarimState();
}

class _PlanlarimState extends State<Planlarim> {
  late List<Task> _allTasks;
  late LocalStorage _localStorage;
  @override
  void initState() {
    _localStorage = locator<LocalStorage>();
    super.initState();
    _allTasks = <Task>[];
    getAllTaskFromDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: GestureDetector(
          onDoubleTap: () {
            _showAddTaskBottomSheet();
          },
          child: const Text(
            'Rota Oluşturuluyor..',
            style: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              _aramaozelligi();
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () {
              _showAddTaskBottomSheet();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: _allTasks.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                var _oankilistelemani = _allTasks[index];
                return Dismissible(
                    background: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Text('Bu Plan Siliniyor')
                      ],
                    ),
                    key: Key(_oankilistelemani.id),
                    onDismissed: (direction) {
                      _allTasks.removeAt(index);
                      _localStorage.deleteTask(task: _oankilistelemani);
                      setState(() {});
                    },
                    child: TaskListItem(task: _oankilistelemani));
              },
              itemCount: _allTasks.length,
            )
          : const Center(
              child: Text('HADİ PLAN EKLE !! '),
            ),
    );
  }

  void _showAddTaskBottomSheet() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          width: MediaQuery.of(context).size.width,
          child: ListTile(
            title: TextField(
              autofocus: true,
              style: const TextStyle(fontSize: 24),
              decoration: const InputDecoration(
                hintText: 'Plan Nedir',
                border: InputBorder.none,
              ),
              onSubmitted: (value) async {
                Navigator.of(context).pop();
                if (value.length > 3) {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (selectedDate != null) {
                    final selectedTime = await (
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (selectedTime != null) {
                      final selectedDateTime = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                      );

                      var yeniEklenecekDeger = Task.create(
                        name: value,
                        createdAt: selectedDateTime,
                      );

                      setState(() {
                        _allTasks.add(yeniEklenecekDeger);
                      });
                      await _localStorage.addTask(task: yeniEklenecekDeger);
                    }
                  }
                }
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> getAllTaskFromDb() async {
    var tasks = await _localStorage.getAllTask();
    setState(() {
      _allTasks = tasks;
    });
  }

  void _aramaozelligi() {
    showSearch(
      context: context,
      delegate: CustomSearchDelegate(allTasks: _allTasks),
    );
  }
}
