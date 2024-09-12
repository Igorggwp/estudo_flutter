import 'package:estudo_flutter/password/password_page.dart.dart';
import 'package:estudo_flutter/todo/cadastroTask.dart';
import 'package:estudo_flutter/todo/listToTask.dart';
import 'currency/curreny_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
      ),
      drawer: _buildDrawer(context),
      body: const Center(
        child: Text(
          'Lista de Aplicativos!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.deepPurpleAccent,
          ),
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildDrawerHeader(),
          _buildDrawerItem(
            icon: Icons.home_outlined,
            text: 'Página Inicial',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            icon: Icons.add_task_sharp,
            text: 'Cadastro de Tarefas',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CadastroTask()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.list,
            text: 'Lista de Tarefas',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ListToTask()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.lock_outline,
            text: 'Gerador de Senha',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PasswordPage()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.currency_exchange,
            text: 'Conversor de Moedas',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CurrencyPage()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.info_outline,
            text: 'Sobre',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return UserAccountsDrawerHeader(
      accountName: const Text(
        "Igor Costa",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      accountEmail: const Text("igorggwpp@gmail.com"),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: ClipOval(
          child: Image.network(
            'https://via.placeholder.com/150',
            fit: BoxFit.cover,
            width: 90,
            height: 90,
          ),
        ),
      ),
      decoration: const BoxDecoration(
        color: Colors.deepPurpleAccent,
      ),
    );
  }

  Widget _buildDrawerItem(
      {required IconData icon, required String text, GestureTapCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurpleAccent),
      title: Text(text, style: const TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }
}