import 'package:flutter/material.dart';
import 'package:batch_student_objbox_api/data_source/local_data_source/batch_data_source.dart';

import '../app/constants.dart';
import '../model/batch.dart';
import '../model/student.dart';
import '../repository/student_repo.dart';

class BatchStudentScreen extends StatefulWidget {
  const BatchStudentScreen({super.key});
  static const String route = "batchStudentScreen";
  @override
  State<BatchStudentScreen> createState() => _BatchStudentScreenState();
}

class _BatchStudentScreenState extends State<BatchStudentScreen> {

  late Batch batch;

  @override
  void didChangeDependencies() {
    batch = ModalRoute.of(context)!.settings.arguments as Batch;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students in ${batch.batchName}'),
      ),
      body: FutureBuilder(
        future: StudentRepositoryImpl().getStudentsByBatch(batch.batchId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final students = snapshot.data as List<Student>;
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return DisplayStudentWidget(students[index]);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class DisplayStudentWidget extends StatelessWidget {
  final Student student;

  const DisplayStudentWidget(this.student, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Image.network(
              Constant.userImageURL + student.image!,
            ),) 
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.grey.withOpacity(0.5),
              child: ListTile(
                title: Text(
                  '${student.fname} ${student.lname}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  student.batches!.batchName!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
  
