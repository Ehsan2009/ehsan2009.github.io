import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> users = [];

  Future<void> fetchUsers() async {
    try {
      QuerySnapshot usersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      List<DocumentSnapshot> usersDocs = usersSnapshot.docs;

      for (var doc in usersDocs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        String userEmail = data['email'];
        users.add(userEmail);
      }

      setState(() {});
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 70, bottom: 30 ,right: 20, left: 20),
          child: Column(
            children: [
              Image.asset(
                'assets/images/chat.png',
                width: 120,
                color: Colors.grey[600],
              ),
              const SizedBox(height: 40),
              ListTile(
                title: const Text('H O M E'),
                leading: Icon(
                  Icons.home,
                  color: Colors.grey[600],
                ),
              ),
              ListTile(
                title: const Text('S E T T I N G S'),
                leading: Icon(
                  Icons.settings,
                  color: Colors.grey[600],
                ),
              ),
              const Spacer(),
              ListTile(
                title: const Text('L O G O U T'),
                leading: Icon(
                  Icons.logout,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text('U S E R S'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 20,
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 16),
                      Text(
                        users[index],
                        style: GoogleFonts.roboto(),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
