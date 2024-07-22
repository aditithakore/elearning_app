import 'package:flutter/material.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  final List dashboardData = const [
    {
      "id": 1,
      "title": "Videos",
      "icon": Icons.play_arrow,
      "background_color": Colors.pink,
    },
    {
      "id": 2,
      "title": "Numeracy",
      "icon": Icons.book,
      "background_color": Colors.blue,
    },
    {
      "id": 3,
      "title": "Literacy",
      "icon": Icons.book,
      "background_color": Colors.red,
    },
    {
      "id": 4,
      "title": "Everday Basics",
      "icon": Icons.book,
      "background_color": Colors.green,
    },
    {
      "id": 5,
      "title": "Settings",
      "icon": Icons.settings,
      "background_color": Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          '', //appbar name
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(children: [
        // Background image
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://img.rawpixel.com/s3fs-private/rawpixel_images/website_content/v1015-111c-kstoqf1a.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=f016449eaa797aebe6ad6b921eaaf502', // Replace with your URL
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Your existing content
        ListView(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              child: const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: ListTile(
                  title: Text(
                    'Bablu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Welcome back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://cdn.pixabay.com/photo/2024/04/20/22/02/ai-generated-8709514_1280.png'),
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dashboardData.length,
              itemBuilder: (context, index) {
                final data = dashboardData[index];
                return InkWell(
                  onTap: () {
                    print(data['id']);
                    print(data['title']);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    padding: const EdgeInsets.all(40.0),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 10),
                            color:
                                Theme.of(context).primaryColor.withOpacity(.2),
                            spreadRadius: 4,
                            blurRadius: 10)
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: data['background_color'],
                              shape: BoxShape.circle),
                          child: Icon(
                            data['icon'],
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                        const SizedBox(width: 40),
                        Text(
                          data['title'],
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ]),
    );
  }
}
