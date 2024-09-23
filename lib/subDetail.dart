import 'package:flutter/material.dart';

class SubDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SubDetail();
}

class _SubDetail extends State<SubDetail> {
  List<Map<String, String>> todoList = []; // 제목과 내용을 함께 저장

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('할 일 목록'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              contentPadding: EdgeInsets.all(15),
              title: Text(
                todoList[index]['title']!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () {
                  _deleteTodoItem(index);
                },
              ),
              onTap: () {
                _editOrViewNavigation(context, index); // 수정 또는 보기 페이지로 이동
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNavigation(context);
        },
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
      ),
    );
  }

  // 할 일 추가 함수
  void _addNavigation(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed('/second');
    if (result != null) {
      setState(() {
        todoList.add(result as Map<String, String>); // 제목과 내용을 함께 저장
      });
    }
  }

  // 수정 또는 보기 페이지로 이동하는 함수
  void _editOrViewNavigation(BuildContext context, int index) async {
    final result = await Navigator.of(context).pushNamed('/third', arguments: todoList[index]);
    if (result == null) {
      // 삭제된 경우
      setState(() {
        todoList.removeAt(index);
      });
    } else {
      // 수정된 경우
      setState(() {
        todoList[index] = result as Map<String, String>;
      });
    }
  }

  void _deleteTodoItem(int index) {
    setState(() {
      todoList.removeAt(index); // 해당 인덱스의 항목을 삭제
    });
  }
}
