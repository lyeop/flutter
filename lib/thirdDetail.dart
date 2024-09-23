import 'package:flutter/material.dart';

class ThirdDetail extends StatefulWidget {
  @override
  _ThirdDetailState createState() => _ThirdDetailState();
}

class _ThirdDetailState extends State<ThirdDetail> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  Map<String, String>? todoItem;

  @override
  void initState() {
    super.initState();

    // titleController와 contentController를 미리 빈 문자열로 초기화
    titleController = TextEditingController();
    contentController = TextEditingController();

    // 트리가 완전히 빌드된 후 arguments에서 데이터를 가져와 컨트롤러를 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map<String, String> args =
      ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      setState(() {
        todoItem = args;
        titleController.text = todoItem!['title']!;
        contentController.text = todoItem!['content']!;
      });
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  // WillPopScope로 뒤로 가기 버튼 동작 제어
  Future<bool> _onWillPop() async {
    final updatedTodo = {
      'title': titleController.text,
      'content': contentController.text,
    };
    Navigator.of(context).pop(updatedTodo);
    return false; // 기본 뒤로 가기 동작 방지
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // 뒤로 가기 동작을 제어
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '할 일 상세보기',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '제목',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              SizedBox(height: 10),
              TextField(
                controller: titleController, // 컨트롤러 설정
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                '내용',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              SizedBox(height: 10),
              TextField(
                controller: contentController, // 컨트롤러 설정
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      final updatedTodo = {
                        'title': titleController.text,
                        'content': contentController.text,
                      };
                      Navigator.of(context).pop(updatedTodo); // 수정된 내용 반환
                    },
                    icon: Icon(Icons.save),
                    label: Text('수정'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop(null); // 삭제
                    },
                    icon: Icon(Icons.delete),
                    label: Text('삭제'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
