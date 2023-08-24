import 'package:firebase_demo_1/firebase_api_services.dart';
import 'package:flutter/material.dart';

class SimpleCrudDemo extends StatefulWidget {
  const SimpleCrudDemo({super.key});

  @override
  State<SimpleCrudDemo> createState() => _SimpleCrudDemoState();
}

class _SimpleCrudDemoState extends State<SimpleCrudDemo> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  late Future<List<Map>> futureUserData;
  bool update = false;
  String selectKey = '';

  @override
  void initState() {
    futureUserData = FirebaseApi.selectData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: nameController,
            ),
            TextField(
              controller: lastNameController,
            ),
            const SizedBox(height: 10),
            MaterialButton(
              onPressed: update == true
                  ? () async {
                      await FirebaseApi.updateData(
                          key: selectKey,
                          userName: nameController.text,
                          lastName: lastNameController.text);
                      futureUserData = FirebaseApi.selectData();
                      update = false;
                      setState(() {});
                    }
                  : () async {
                      await FirebaseApi.addUser(
                          userName: nameController.text,
                          lastName: lastNameController.text);
                      futureUserData = FirebaseApi.selectData();
                      // nameController.clear();
                      setState(() {});
                    },
              child: Text(update == false ? 'submit' : 'update'),
            ),
            const SizedBox(height: 10),
            FutureBuilder(
              future: futureUserData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                      child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        update = true;
                        selectKey = snapshot.data![index]['key'];
                        nameController.text = snapshot.data![index]['userName'];
                        setState(() {});
                      },
                      child: Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) async {
                          await FirebaseApi.removeData(
                              key: snapshot.data![index]['key']);
                          update = false;
                          futureUserData = FirebaseApi.selectData();

                          setState(() {});
                        },
                        child: Column(
                          children: [
                            Text(snapshot.data![index]['key']),
                            Text(snapshot.data![index]['userName']),
                          ],
                        ),
                      ),
                    ),
                  ));
                } else {
                  return const CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
