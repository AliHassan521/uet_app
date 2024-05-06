import 'package:flutter/material.dart';

const int numDepartments = 5;
const double cardPadding = 8.0;

class Departments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Departments'),
      ),
      body: ListView.builder(
        itemCount: numDepartments,
        itemBuilder: (context, index) {
          final departmentIndex = index + 1;
          String departmentName = '';
          String departmentText = '';
          switch (departmentIndex) {
            case 1:
              departmentName = 'Computer Science';
              departmentText =
                  'Department of Computer Science and Engineering, Narowal Campus started working in 2014 at UET Lahore, Narowal. Here the students are given the sterling opportunity to get education of highest standards in pleasant and friendly atmosphere, and to make compatible with their means.';
              break;
            case 2:
              departmentName = 'Bio-Medical Engineering';
              departmentText =
                  'Biomedical Engineering is an interdisciplinary field that takes design concepts from multiple science and engineering domains including Electrical, Mechanical, Computer Science, Mathematics, Physics and Biology.';
              break;
            case 3:
              departmentName = 'Civil Engineering';
              departmentText =
                  'The Department of Civil Engineering is a constituent department of the University of Engineering & Technology Lahore, Narowal Campus. It was established in 2013. It has been providing quality education to the students in improvising their competencies for novel techniques and methods to fulfill the needs of sustainable socio-economic development. The Civil Engineering Program at UET Narowal campus is accredited with (PEC).';
              break;
            case 4:
              departmentName = 'Mechanical Engineering';
              departmentText =
                  'The department of Mechanical engineering was established in 2012. The department is now shifted towards OBE system as per PEC requirement. The department is comprising of foreign qualified Ph.D. and M.Sc. faculty members to provide fine level of teaching to the students and to enhance the research projects as well.zTo complete the practical part of mechanical engineering study, the department provides scientific laboratories with upgraded machinery and software to elevate and improve the practical training of the students in his/her all studying levels. The good economy of country relies largely on total productivity which is highly dependent on mechanical engineers.';
              break;
            case 5:
              departmentName = 'Electrical Engineering';
              departmentText =
                  'The Department of Electrical Engineering, at the University of Engineering and Technology Lahore, Narowal campus is one of the most prestigious schools of learning in the field of Electrical Engineering in Pakistan. The Department was established in 2012. The undergraduate courses have been designed to build a strong foundation in various fields of Electrical Engineering. The seminars are delivered by faculty members, and prominent researchers from home and abroad.';
              break;
          }
          return InkWell(
            onTap: () {
              _showDepartmentTextDialog(
                  context, departmentName, departmentText);
            },
            child: DepartmentCard(
              imagePath: 'assets/images/img$departmentIndex.jpg',
              departmentName: departmentName,
            ),
          );
        },
      ),
    );
  }

  void _showDepartmentTextDialog(
      BuildContext context, String departmentName, String departmentText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(departmentName),
          content: Text(departmentText),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class DepartmentCard extends StatelessWidget {
  final String imagePath;
  final String departmentName;

  const DepartmentCard({
    required this.imagePath,
    required this.departmentName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            imagePath,
            height: 150,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(cardPadding),
            child: Text(
              departmentName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
