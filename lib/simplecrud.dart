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
  String gender = 'gender', male = 'male', feMale = 'feMale';
  bool isCricket = false, isFootball = false, isSinging = false;
  List selectedHobbies = [];
  double selectedSalary = 0;
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
            Row(
              children: [
                const Text('Gender'),
                Radio(
                  value: male,
                  groupValue: gender,
                  onChanged: (value) {
                    gender = value!;
                    setState(() {});
                  },
                ),
                const Text('Male'),
                Radio(
                  value: feMale,
                  groupValue: gender,
                  onChanged: (value) {
                    gender = value!;
                    setState(() {});
                  },
                ),
                const Text('FeMale'),
              ],
            ),
            Row(
              children: [
                const Text('Hobby : '),
                const Text('Cricket'),
                Checkbox(
                  value: isCricket,
                  onChanged: (value) {
                    isCricket = value!;
                    setState(() {});
                  },
                ),
                const Text('Football'),
                Checkbox(
                  value: isFootball,
                  onChanged: (value) {
                    isFootball = value!;
                    setState(() {});
                  },
                ),
                const Text('Singing'),
                Checkbox(
                  value: isSinging,
                  onChanged: (value) {
                    isSinging = value!;
                    setState(() {});
                  },
                ),
              ],
            ),
            Slider(
              value: selectedSalary,
              onChanged: (value) {
                selectedSalary = value;
                setState(() {});
              },
              min: 0,
              max: 50000,
            ),
            const SizedBox(height: 10),
            MaterialButton(
              onPressed: update == true
                  ? () async {
                      selectedHobbies.clear();
                      if (isCricket == true) {
                        selectedHobbies.add('cricket');
                      }
                      if (isFootball == true) {
                        selectedHobbies.add('football');
                      }
                      if (isSinging == true) {
                        selectedHobbies.add('singing');
                      }
                      await FirebaseApi.updateData(
                          key: selectKey,
                          userName: nameController.text,
                          lastName: lastNameController.text,
                          gender: gender,
                          selectedHobbies:
                              List.from(selectedHobbies.map((e) => e)),
                          selectedSalary: selectedSalary);
                      futureUserData = FirebaseApi.selectData();
                      nameController.clear();
                      lastNameController.clear();
                      gender = 'gender';
                      isCricket = false;
                      isFootball = false;
                      isSinging = false;
                      selectedSalary = 0;
                      update = false;
                      setState(() {});
                    }
                  : () async {
                      selectedHobbies.clear();
                      if (isCricket == true) {
                        selectedHobbies.add('cricket');
                      }
                      if (isFootball == true) {
                        selectedHobbies.add('football');
                      }
                      if (isSinging == true) {
                        selectedHobbies.add('singing');
                      }
                      await FirebaseApi.addUser(
                        userName: nameController.text,
                        lastName: lastNameController.text,
                        gender: gender,
                        selectedHobbies:
                            List.from(selectedHobbies.map((e) => e)),
                        selectedSalary: selectedSalary,
                      );
                      futureUserData = FirebaseApi.selectData();
                      nameController.clear();
                      lastNameController.clear();
                      gender = 'gender';
                      isCricket = false;
                      isFootball = false;
                      isSinging = false;
                      selectedSalary = 0;
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
                        lastNameController.text =
                            snapshot.data![index]['lastName'];
                        gender = snapshot.data![index]['gender'];
                        selectedHobbies = snapshot.data![index]['hobby']
                            .map((e) => e)
                            .toList();
                        if (snapshot.data![index]['hobby']
                            .contains('cricket')) {
                          isCricket = true;
                        }
                        if (snapshot.data![index]['hobby']
                            .contains('football')) {
                          isFootball = true;
                        }
                        if (snapshot.data![index]['hobby']
                            .contains('singing')) {
                          isSinging = true;
                        }
                        selectedSalary = snapshot.data![index]['salary'];

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
                            Text(snapshot.data![index]['lastName']),
                            Text(snapshot.data![index]['gender']),
                            Text(snapshot.data![index]['hobby'].toString()),
                            Text(snapshot.data![index]['salary'].toString()),
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
