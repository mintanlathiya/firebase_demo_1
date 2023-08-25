import 'package:firebase_demo_1/firebase_api2.dart';
import 'package:flutter/material.dart';

class FireBaseDemo2 extends StatefulWidget {
  const FireBaseDemo2({super.key});

  @override
  State<FireBaseDemo2> createState() => _FireBaseDemo2State();
}

class _FireBaseDemo2State extends State<FireBaseDemo2> {
  final TextEditingController _txtFnameController = TextEditingController();
  final TextEditingController _txtMnameController = TextEditingController();
  final TextEditingController _txtLnameController = TextEditingController();
  bool isCricket = false, isDriving = false;
  String female = 'female', male = 'male', gender = 'gender';
  late Future<List<Map>> futureUserData;
  List<String> selectedHobbey = [];

  @override
  void initState() {
    futureUserData = FireBaseApi.selectUserData();
    super.initState();
  }

  @override
  void dispose() {
    _txtFnameController.clear();
    _txtLnameController.clear();
    _txtMnameController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Column(
            children: [
              TextField(
                controller: _txtFnameController,
                decoration: const InputDecoration(hintText: 'First Name'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _txtMnameController,
                decoration: const InputDecoration(hintText: 'Middle Name'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _txtLnameController,
                decoration: const InputDecoration(
                  hintText: 'Last Name',
                ),
              ),
              Row(
                children: [
                  const Text('Gender : '),
                  Radio(
                      value: male,
                      groupValue: gender,
                      onChanged: (value) {
                        gender = value!;

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

                      setState(() {});
                    },
                  ),
                  const Text(
                    'Female',
                  )
                ],
              ),
              Row(
                children: [
                  const Text('Hobbey : '),
                  Checkbox(
                    value: isCricket,
                    onChanged: (value) {
                      isCricket = value!;
                      setState(() {});
                    },
                  ),
                  const Text('Cricket'),
                  Checkbox(
                    value: isDriving,
                    onChanged: (value) {
                      isDriving = value!;
                      setState(() {});
                    },
                  ),
                  const Text('Driving'),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () {
                  if (isCricket == true) {
                    selectedHobbey.add('Cricket');
                  }
                  if (isDriving == true) {
                    selectedHobbey.add('Driving');
                  }
                  FireBaseApi.userData(
                      fname: _txtFnameController.text,
                      lname: _txtLnameController.text,
                      mname: _txtMnameController.text,
                      hobbey: selectedHobbey,
                      gender: gender);
                  futureUserData = FireBaseApi.selectUserData();
                  _txtFnameController.clear();
                  _txtLnameController.clear();
                  _txtMnameController.clear();
                  isCricket = false;
                  isDriving = false;
                  setState(() {});
                },
                color: Colors.blue,
                child: const Text('Submit'),
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
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              FireBaseApi.selectedKey =
                                  snapshot.data![index]['key'];
                              snapshot.data![index]['key'];
                              FireBaseApi.txtUpdateFnameController.text =
                                  snapshot.data![index]['fname'];

                              FireBaseApi.txtUpdateMnameController.text =
                                  snapshot.data![index]['mname'];

                              FireBaseApi.txtUpdateLnameController.text =
                                  snapshot.data![index]['lname'];
                              FireBaseApi.gender =
                                  snapshot.data![index]['gender'];

                              //FireBaseApi.gender = gender;
                              setState(() {});
                              return await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return SimpleDialog(
                                    title: const Text('You Want to Update?'),
                                    children: [
                                      TextField(
                                        controller: FireBaseApi
                                            .txtUpdateFnameController,
                                        decoration: const InputDecoration(
                                            hintText: 'First Name'),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextField(
                                        controller: FireBaseApi
                                            .txtUpdateMnameController,
                                        decoration: const InputDecoration(
                                            hintText: 'Middle Name'),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextField(
                                        controller: FireBaseApi
                                            .txtUpdateLnameController,
                                        decoration: const InputDecoration(
                                            hintText: 'Last Name'),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Text('Gender : '),
                                          Radio(
                                              value: FireBaseApi.male,
                                              groupValue: FireBaseApi.gender,
                                              onChanged: (value) {
                                                FireBaseApi.gender = value!;
                                                setState(() {});
                                              }),
                                          const Text(
                                            'Male',
                                          ),
                                          Radio(
                                            value: FireBaseApi.female,
                                            groupValue: FireBaseApi.gender,
                                            onChanged: (value) {
                                              FireBaseApi.gender = value!;
                                              setState(() {});
                                            },
                                          ),
                                          const Text(
                                            'Female',
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            MaterialButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                setState(() {});
                                              },
                                              child: const Text('No'),
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                // snapshot.data![index]['fname'] =
                                                //     FireBaseApi
                                                //         .txtUpdateFnameController
                                                //         .text;
                                                // snapshot.data![index]['mname'] =
                                                //     FireBaseApi
                                                //         .txtUpdateMnameController
                                                //         .text;
                                                // snapshot.data![index]['lname'] =
                                                //     FireBaseApi
                                                //         .txtUpdateLnameController
                                                //         .text;
                                                // snapshot.data![index]
                                                //         ['gender'] =
                                                //     FireBaseApi.gender;
                                                FireBaseApi.updateUserData(
                                                  fname: FireBaseApi
                                                      .txtUpdateFnameController
                                                      .text,
                                                  key: FireBaseApi.selectedKey,
                                                  mname: FireBaseApi
                                                      .txtUpdateMnameController
                                                      .text,
                                                  lname: FireBaseApi
                                                      .txtUpdateLnameController
                                                      .text,
                                                  hobbey: selectedHobbey,
                                                  gender: FireBaseApi.gender,
                                                );
                                                FireBaseApi
                                                    .txtUpdateFnameController
                                                    .clear();
                                                FireBaseApi
                                                    .txtUpdateLnameController
                                                    .clear();
                                                FireBaseApi
                                                    .txtUpdateMnameController
                                                    .clear();
                                                Navigator.pop(context);
                                                futureUserData = FireBaseApi
                                                    .selectUserData();
                                                setState(() {});
                                              },
                                              color: Colors.blue,
                                              child: const Text('Yes'),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fname : ${snapshot.data![index]['fname']}',
                                ),
                                Text(
                                  'Mname : ${snapshot.data![index]['mname']}',
                                ),
                                Text(
                                  'Lname : ${snapshot.data![index]['lname']}',
                                ),
                                Text(
                                    "Gender : ${snapshot.data![index]['gender']}"),
                                Text(
                                  'Hobbey : ${snapshot.data![index]['hobbey']}',
                                ),
                                const SizedBox(
                                  height: 15,
                                )
                              ],
                            ),
                          );
                        },
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
