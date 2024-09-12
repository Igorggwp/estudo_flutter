import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'listToTask.dart';

class CadastroTask extends StatefulWidget {
  const CadastroTask({super.key});

  @override
  _CadastroTaskState createState() => _CadastroTaskState();
}

class _CadastroTaskState extends State<CadastroTask> {

  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _dateInput = TextEditingController();
  final TextEditingController _timeInput = TextEditingController();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  final _firstDay = DateTime(1950);
  final _lastDay = DateTime(2100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          'Cadastro de Tarefas',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
      foregroundColor: Colors.white,
      centerTitle: true,
      toolbarHeight: 80,
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              const SizedBox(),
              fieldDescricaoTRF(),
              sizedBox(),
              fieldDataTRF(),
              const SizedBox(),
              fieldHoraTRF(),
              const SizedBox(),
              fieldCalendario()
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        onPressed: () {
          addListaTRF(
            _descricaoController.text, _dateInput.text, _timeInput.text
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ListToTask()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget fieldCalendario() {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 5.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(color: Colors.black87, width: 2.0),
      ),
      child: TableCalendar(
        firstDay: _firstDay,
        lastDay: _lastDay,
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }

  Widget sizedBox() {
    return const SizedBox(
      height: 30,
    );
  }

  Widget fieldDescricaoTRF() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: _descricaoController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
          ),
          labelText: "Informe a tarefa",
        ),
      ),
    );
  }

  Widget fieldDataTRF() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: _dateInput,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
          ),
          icon: Icon(Icons.calendar_today, color: Colors.deepPurpleAccent,),
          labelText: "Insira a Data",
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
            setState(() {
              _dateInput.text = formattedDate;
            });
          }
        },
      ),
    );
  }

  Widget fieldHoraTRF() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: _timeInput,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
          ),
          icon: Icon(Icons.timer, color: Colors.deepPurpleAccent,),
          labelText: "Qual a hora da sua Tarefa",
        ),
        readOnly: true,
        onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (pickedTime != null) {
            setState(() {
              _timeInput.text = pickedTime.format(context);
            });
          }
        },
      ),
    );
  }

  void addListaTRF(String descricao, String data, String hora) {
    Task t = Task(descricao, data, hora);
    listaTask.add(t);
  }
}