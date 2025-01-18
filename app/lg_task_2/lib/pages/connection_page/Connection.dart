import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lg_task_2/pages/connection_page/textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lg_task_2/config/ssh.dart';
import 'package:dartssh2/dartssh2.dart';

class Connection extends StatefulWidget {
  final Function(bool) onConnectionChanged;

  const Connection({required this.onConnectionChanged, Key? key})
      : super(key: key);

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  final _formKey = GlobalKey<FormState>();
  

  bool isConnected = false;
  bool isLoading = false;
  

  final TextEditingController _ipController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _sshPortController = TextEditingController();

  final TextEditingController _rigsController = TextEditingController();

  @override
  void dispose() {
    _ipController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _sshPortController.dispose();
    _rigsController.dispose();
    super.dispose();
  }

  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _loadSettings() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _ipController.text = prefs.getString('ipAddress') ?? '';
      _usernameController.text = prefs.getString('username') ?? '';
      _passwordController.text = prefs.getString('password') ?? '';
      _sshPortController.text = prefs.getString('sshPort') ?? '';
      _rigsController.text = prefs.getString('numberOfRigs') ?? '';
    });
  }

  Future<void> _saveSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (_ipController.text.isNotEmpty) {
      await prefs.setString('ipAddress', _ipController.text);
    }
    if (_usernameController.text.isNotEmpty) {
      await prefs.setString('username', _usernameController.text);
    }
    if (_passwordController.text.isNotEmpty) {
      await prefs.setString('password', _passwordController.text);
    }
    if (_sshPortController.text.isNotEmpty) {
      await prefs.setString('sshPort', _sshPortController.text);
    }
    if (_rigsController.text.isNotEmpty) {
      await prefs.setString('numberOfRigs', _rigsController.text);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  trySubmit(int buttonId) {
    final isValid = _formKey.currentState!.validate();
    if(isValid) {
      _formKey.currentState!.save();
      if(buttonId == 1){
        connectToLG();
      } else{
        searchLleida();
      }
      
    } else{
      print('Error');
    }

  }

  void connectToLG() async{
    await _saveSettings();
    SSH ssh = SSH();
    setState(() {
          isLoading = true;
        });
    bool? result = await ssh.connectToLG();

    try {
      
      if (result == true) {
        final snackbar = SnackBar(
          backgroundColor: Colors.white70,
          content: Text(
            "Connected!",
            style: TextStyle(color: Colors.black),
          )
          
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        setState(() {
          isConnected = true;
          widget.onConnectionChanged(isConnected);
        });
        print('Connected to LG successfully');
      } else{
        final snackbar = SnackBar(
          backgroundColor: Colors.red[400],
          content: Text("Can't connect")
        );
        setState(() {
          isConnected = false;
          widget.onConnectionChanged(isConnected);
        });
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } finally {
        setState(() {
          isLoading = false;
        });
      }
  }

  void searchLleida() async{
    SSH ssh = SSH();
    await ssh.connectToLG();
    setState(() {
      isLoading = true;
    });
    SSHSession? execResult = await ssh.execute('search=Lleida');

    try {
      if(execResult != null){
        print('Command executed successfully');
      }
      final snackbar = SnackBar(
          backgroundColor: Colors.white70,
          content: Text(
            "Successful!",
            style: TextStyle(color: Colors.black),
          )
          
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } catch (e) {
      print('Failed to execute command: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(labelText: 'IP Address', hintText: '192.168.0.1', controller: _ipController, valueKey: 'ipController', inputType: TextInputType.number),
                SizedBox(height: 20),
                CustomTextFormField(labelText: 'Port', hintText: '22', controller: _sshPortController, valueKey: 'sshPort', inputType: TextInputType.number),
                SizedBox(height: 20),
                CustomTextFormField(labelText: 'Rigs', hintText: '3', controller: _rigsController, valueKey: 'rigs', inputType: TextInputType.number),
                SizedBox(height: 20),
                CustomTextFormField(labelText: 'Username', hintText: 'Username', controller: _usernameController, valueKey: 'username', inputType: TextInputType.text),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: _obscureText,
                  
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: const Color.fromARGB(255, 211, 211, 211)
                    ),
                    hintText: 'Enter Password',
                    hintStyle: TextStyle(
                      color: const Color.fromARGB(255, 211, 211, 211)
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      color: Colors.white70,
                      onPressed: _togglePasswordVisibility,
                    ),
                    
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    fillColor: Colors.blueGrey[700],
                    filled: true,
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textInputAction: TextInputAction.done,
                  controller: _passwordController,
                  key: ValueKey('password'),
                  validator:(value) {
                    if (value.toString().isEmpty){
                      return "Field can't be empty";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () => trySubmit(1),
                      child: Text('Connect to LG',),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () => trySubmit(2),
                      child: Text('Search for "Lleida"'),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                if(isLoading) ...[
                  SizedBox(width: 20,),
                  SpinKitThreeBounce(
                    color: Colors.white70,
                    size: 15,
                  )
                ]
              ],
            )
          ),
        ],
      ),
    );
  }
}