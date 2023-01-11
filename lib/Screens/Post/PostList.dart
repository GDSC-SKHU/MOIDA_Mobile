import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moida_mobile/Screens/MyPage.dart';
import 'package:moida_mobile/Screens/Post/Post.dart';
import 'package:moida_mobile/Screens/Post/WritePost.dart';
import '../../Controller/postController.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  @override
  void initState() {
    // TODO: implement initState
    listPost();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 1500));
        setState(() {
          listPost();
        });
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => MyPage())));
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: listPost(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.content!.length,
                  itemBuilder: ((context, index) {
                    var contId = snapshot.data!.content![index].id;
                    var title = snapshot.data!.content![index].title;
                    var type = snapshot.data!.content![index].type;
                    var mainContext = snapshot.data!.content![index].context;
                    return GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 100,
                          color: Colors.amber,
                          child: Column(
                            children: [
                              Text('${contId}'),
                              Text('${title}'),
                              Text('${type}'),
                              Text('${mainContext}')
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Post(
                                      id: contId,
                                    ))));
                      },
                    );
                  }));
            } else {
              return Center(
                child: Text('no has data'),
              );
            }
          }),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (() {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => WritePost())));
        })),
      ),
    );
  }
}
