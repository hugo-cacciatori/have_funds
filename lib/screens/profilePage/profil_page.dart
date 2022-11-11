import 'package:flutter/material.dart';

import '../../utils/services/authentication_service.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topBox,
        const SizedBox(height: 10)
      ],
    );
  }
}

Widget topBox = Container(
  padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
  width: double.infinity,
  decoration: BoxDecoration(
    color: Colors.teal,
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.blue.shade400,
        Colors.tealAccent.shade100,
      ],
    ),
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      imagePicture,
      const SizedBox(height: 10),
      profilSection,
    ],
  ),
);

Widget imagePicture = Container(
  padding: const EdgeInsets.all(4),
  height: 150,
  width: 150,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(75),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.4),
        spreadRadius: 1,
        blurRadius: 2,
        offset: const Offset(0, 1),
      ),
    ],
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(200),
    child: Image.network(
        'assets/images/rodolphe.jpg'),
  ),
);

Widget profilSection = Column(
  children: [
    Text(
      AuthenticationService().getUserName() ?? "",
      style: const TextStyle(fontSize: 30),
    ),
    const SizedBox(height: 5),
    const Text(
      'Professeur de réseau informatique !',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 17,
      ),
    ),
    const SizedBox(height: 5),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.location_on,
          color: Colors.white,
        ),
        Text(
          'Gap, France',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ],
    )
  ],
);



Widget followSection = Container(
  color: Colors.white,
  padding: const EdgeInsets.all(20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Posts',
              style: TextStyle(
                  color: Colors.blue[400],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '500',
              style: TextStyle(
                color: Colors.tealAccent[700],
                fontSize: 15,
              ),
            )
          ],
        ),
      ),
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Followers',
              style: TextStyle(
                  color: Colors.blue[400],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '35.2K',
              style: TextStyle(
                color: Colors.tealAccent[700],
                fontSize: 15,
              ),
            )
          ],
        ),
      ),
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Follow',
              style: TextStyle(
                  color: Colors.blue[400],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '4000',
              style: TextStyle(
                color: Colors.tealAccent[700],
                fontSize: 15,
              ),
            )
          ],
        ),
      ),
    ],
  ),
);


Widget textSection = Container(
  padding: const EdgeInsets.all(20),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    const Text(
    'À propos',
    style: TextStyle(
        color: Colors.blue, fontSize: 20, fontWeight: FontWeight.w500),
  ),
  const SizedBox(height: 5),
  Text(
    "Gerard, conducteur de camion de pere en fils depuis 1850, aime la route et les rencontres.",
  style: TextStyle(
  color: Colors.grey[600],
    fontSize: 15,
    height: 1.5,
  ),
)
],
),
);

Widget buttonSection = ElevatedButton(
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  ),
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      gradient: LinearGradient(
        colors: <Color>[
          Colors.blue.shade400,
          Colors.tealAccent.shade700,
        ],
      ),
    ),
    padding: const EdgeInsets.fromLTRB(100, 15, 100, 15),
    child: const Text('FOLLOW', style: TextStyle(fontSize: 24)),
  ),
  onPressed: () {},
);