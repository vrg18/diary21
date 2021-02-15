import 'package:diary/data/repository/current_day.dart';
import 'package:diary/data/repository/current_user.dart';
import 'package:diary/data/repository/deed_repository.dart';
import 'package:diary/data/storage/deed_storage.dart';
import 'package:diary/domain/deed.dart';
import 'package:diary/ui/res/sizes.dart';
import 'package:diary/ui/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Details extends StatelessWidget {
  final Deed? deed;
  final DateTime? newDeedStartDate;
  final _dateController = TextEditingController();
  final _timeStartController = TextEditingController();
  final _timeFinishController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final DateFormat _formatterDate = DateFormat('dd.MM.yyyy');
  final DateFormat _formatterTime = DateFormat.Hm();
  bool _readOnly = false;

  Details({this.deed, this.newDeedStartDate}) {
    if (newDeedStartDate != null) {
      _dateController.text = _formatterDate.format(newDeedStartDate!);
      _timeStartController.text = _formatterTime.format(newDeedStartDate!);
    } else {
      _readOnly = true;
      _dateController.text = _formatterDate.format(deed!.dateStart);
      _timeStartController.text = _formatterTime.format(deed!.dateStart);
      _timeFinishController.text = deed!.dateFinish != null ? _formatterTime.format(deed!.dateFinish!) : '';
      _nameController.text = deed!.name;
      _descriptionController.text = deed!.description!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: appBarHeight,
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            Provider.of<CurrentUser>(context, listen: false).user.email,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: basicBorderSize),
        child: Column(
          children: [
            Spacer(),
            Expanded(
              flex: 2,
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox.expand(
                    child: Image.asset(
                      largePicture,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Expanded(
              //child:
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: heightOfTextFields),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: TextField(
                          readOnly: _readOnly,
                          controller: _dateController,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            labelText: timeStartHint,
                            icon: Icon(Icons.timer),
                          ),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          readOnly: _readOnly,
                          controller: _timeStartController,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            labelText: timeStartHint,
                          ),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          readOnly: _readOnly,
                          controller: _timeFinishController,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            labelText: timeFinishHint,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: heightOfTextFields),
                  child: TextField(
                    readOnly: _readOnly,
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: deedNameHint,
                      icon: Icon(Icons.assignment_late_outlined),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextField(
                readOnly: _readOnly,
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                minLines: 4,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: deedDescriptionHint,
                  icon: Icon(Icons.assignment_outlined),
                ),
              ),
            ),
            Spacer(),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: heightOfButtons),
                  child: ElevatedButton(
                    child: Text(_readOnly ? closePress : createPress),
                    onPressed: () {
                      if (_readOnly)
                        Navigator.pop(context);
                      else
                        _createDeed(context, context.read<CurrentDay>().deedStorage);
                    },
                  ),
                ),
              ),
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Future<void> _createDeed(BuildContext context, DeedStorage deedStorage) async {
    if (_dateController.text.trim().isEmpty ||
        _timeStartController.text.trim().isEmpty ||
        _nameController.text.trim().isEmpty) {
      _showMessage(context, errorNotEnoughData);
      return;
    }
    DeedRepository deedRepository = DeedRepository(
      date: _dateController.text.trim(),
      timeStart: _timeStartController.text.trim(),
      timeFinish: _timeFinishController.text.trim(),
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
    );
    String errorMessage = await deedRepository.createNewDeed(deedStorage);
    if (errorMessage.isNotEmpty) {
      _showMessage(context, errorMessage);
      return;
    }
    context.read<CurrentDay>().readDeedsOfDayByHour(newDeedStartDate!);
    Navigator.pop(context);
  }

  Future _showMessage(BuildContext context, String content) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text(content),
          actions: [
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
