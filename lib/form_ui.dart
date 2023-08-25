import 'package:firebase_demo_1/firebase_api.dart';
import 'package:flutter/material.dart';

class FireBaseDemo extends StatefulWidget {
  const FireBaseDemo({super.key});

  @override
  State<FireBaseDemo> createState() => _FireBaseDemoState();
}

class _FireBaseDemoState extends State<FireBaseDemo> {
  final TextEditingController _txtFnameController = TextEditingController();
  final TextEditingController _txtMnameController = TextEditingController();
  final TextEditingController _txtLnameController = TextEditingController();
  String male = "male", female = "female", gender = "gender";
  String? selectedGender;
  List<String> hobbey = ['Singing', 'Driving', 'FootBall', 'Cricket'];
  List<String> selectedHobbey = [];
  bool isCricket = false,
      isFootball = false,
      isDriving = false,
      isSinging = false,
      isUpdate = false;

  late Future<List<Map>> futureUserData;
  @override
  void initState() {
    futureUserData = FirebaseApi.selectData();
    super.initState();
  }

  @override
  void dispose() {
    _txtFnameController.dispose();
    _txtLnameController.dispose();
    _txtMnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _txtFnameController,
                decoration: const InputDecoration(
                  hintText: 'First Name',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: _txtMnameController,
                decoration: const InputDecoration(
                  hintText: 'Middle Name',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: _txtLnameController,
                decoration: const InputDecoration(
                  hintText: 'Last Name',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text('Gender : '),
                  Radio(
                      value: male,
                      groupValue: gender,
                      onChanged: (value) {
                        gender = value!;
                        selectedGender = value;
                        setState(() {});
                      }),
                  const Text(
                    'Male',
                  ),
                  Radio(
                    value: female,
                    groupValue: gender,
                    onChanged: (value) {
                      gender = value!;
                      selectedGender = value;
                      setState(() {});
                    },
                  ),
                  const Text(
                    'Female',
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text(
                    'Hobbey : ',
                  ),
                  Expanded(
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (notification) {
                        notification.disallowIndicator();
                        return true;
                      },
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Checkbox(
                              value: isCricket,
                              onChanged: (value) {
                                isCricket = value!;
                                setState(() {});
                              },
                            ),
                            const Text(
                              'Cricket',
                            ),
                            Checkbox(
                              value: isFootball,
                              onChanged: (value) {
                                isFootball = value!;
                                setState(() {});
                              },
                            ),
                            const Text(
                              'Football',
                            ),
                            Checkbox(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: isSinging,
                              onChanged: (value) {
                                isSinging = value!;
                                setState(() {});
                              },
                            ),
                            const Text(
                              'Singing',
                            ),
                            Checkbox(
                              value: isDriving,
                              onChanged: (value) {
                                isDriving = value!;
                                setState(() {});
                              },
                            ),
                            const Text(
                              'Driving',
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              MaterialButton(
                onPressed: isUpdate
                    ? () async {
                        selectedHobbey.clear();
                        if (isCricket == true) {
                          selectedHobbey.add('Cricket');
                        }
                        if (isDriving == true) {
                          selectedHobbey.add('Driving');
                        }
                        if (isFootball == true) {
                          selectedHobbey.add('FootBall');
                        }
                        if (isSinging == true) {
                          selectedHobbey.add('Singing');
                        }
                        isSinging = false;
                        isDriving = false;
                        isCricket = false;
                        isFootball = false;
                        await FirebaseApi.updateUserData(
                          key: FirebaseApi.selectedKey,
                          fname: _txtFnameController.text,
                          lname: _txtLnameController.text,
                          mname: _txtMnameController.text,
                          hobbey: selectedHobbey,
                          gender: gender,
                        );

                        _txtFnameController.clear();
                        _txtLnameController.clear();
                        _txtMnameController.clear();
                        futureUserData = FirebaseApi.selectData();
                        isUpdate = false;
                        setState(() {});
                      }
                    : () async {
                        if (isCricket == true) {
                          selectedHobbey.add('Cricket');
                        }
                        if (isDriving == true) {
                          selectedHobbey.add('Driving');
                        }
                        if (isFootball == true) {
                          selectedHobbey.add('FootBall');
                        }
                        if (isSinging == true) {
                          selectedHobbey.add('Singing');
                        }
                        await FirebaseApi.userData(
                          fname: _txtFnameController.text,
                          mname: _txtMnameController.text,
                          lname: _txtLnameController.text,
                          hobbey: selectedHobbey,
                          gender: selectedGender!,
                        );
                        futureUserData = FirebaseApi.selectData();
                        _txtFnameController.clear();
                        _txtMnameController.clear();
                        _txtLnameController.clear();
                        isSinging = false;
                        isDriving = false;
                        isCricket = false;
                        isFootball = false;
                        selectedHobbey.clear();
                        setState(() {});
                      },
                color: Colors.blue,
                child: Text(isUpdate ? 'Update' : 'Submit'),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: futureUserData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            selectedHobbey.clear();
                            FirebaseApi.selectedKey =
                                snapshot.data![index]['key'];
                            _txtFnameController.text =
                                snapshot.data![index]['fname'];
                            _txtMnameController.text =
                                snapshot.data![index]['mname'];
                            _txtLnameController.text =
                                snapshot.data![index]['lname'];
                            gender = snapshot.data![index]['gender'];
                            selectedHobbey = List.from(
                                snapshot.data![index]['hobbey'].map((e) => e));

                            isUpdate = true;
                            if (selectedHobbey.contains('Cricket')) {
                              isCricket = true;
                            }
                            if (selectedHobbey.contains('FootBall')) {
                              isFootball = true;
                            }
                            if (selectedHobbey.contains('Singing')) {
                              isSinging = true;
                            }
                            if (selectedHobbey.contains('Driving')) {
                              isDriving = true;
                            }
                            setState(() {});
                          },
                          child: Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              FirebaseApi.deleteUserData(
                                  key: snapshot.data![index]['key']);
                              futureUserData = FirebaseApi.selectData();
                              setState(() {});
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name: ${snapshot.data![index]['fname']} ${snapshot.data![index]['mname']} ${snapshot.data![index]['lname']}",
                                  ),
                                  Text(
                                      'Gender : ${snapshot.data![index]['gender']}'),
                                  Text(
                                      'hobbey : ${snapshot.data![index]['hobbey']}'),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
