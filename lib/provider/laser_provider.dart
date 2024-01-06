import 'package:elaser/data/repository/laser_repo.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class LaserProvider extends ChangeNotifier {
  final LaserRepo laserRepo;

  LaserProvider(this.laserRepo);

  FilePickerResult? _filePickerResult;
  bool _validFile = false;
  final _validExtensions = ['ngc', 'gcode'];

  FilePickerResult? get filePickerResult => _filePickerResult;

  bool get isFileValid => _validFile;

  Future<void> pickFile() async {
    _validFile = false;
    notifyListeners();

    _filePickerResult = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
      // allowedExtensions: [
      //   'ngc',
      //   'gcode',
      // ],
      dialogTitle: 'Pick G-Code file',
    );

    _validFile = _checkFileValidation();
    notifyListeners();
  }

  bool _checkFileValidation() {
    if (_filePickerResult?.files.isNotEmpty != true) {
      return false;
    }

    debugPrint('file extension: ${_filePickerResult!.files.first.extension}');
    return _validExtensions.any((ex) => _filePickerResult!.files.first.extension?.toLowerCase().endsWith(ex) == true);
  }


}
