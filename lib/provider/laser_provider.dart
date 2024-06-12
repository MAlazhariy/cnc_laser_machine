import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaser/data/model/base/response_model.dart';
import 'package:elaser/data/repository/laser_repo.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class LaserProvider extends ChangeNotifier {
  final LaserRepo laserRepo;

  LaserProvider(this.laserRepo);

  FilePickerResult? _filePickerResult;
  bool _validFile = false;
  final _validExtensions = ['ngc', 'gcode'];
  bool _isLoading = false;

  FilePickerResult? get filePickerResult => _filePickerResult;

  bool get isFileValid => _validFile;

  bool get isLoading => _isLoading;

  // Socket? _socket;

  final StreamController<double> _progressController = StreamController<double>.broadcast();

  Stream<double> get progressStream => _progressController.stream;

  Future<void> pickFile() async {
    _validFile = false;
    notifyListeners();

    _filePickerResult = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
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

  // Future<void> cancelConnection() async {
  //   await _socket?.close();
  //   _isLoading = false;
  //   _connectedToMachine = false;
  //   notifyListeners();
  // }
  //
  // Future<ResponseModel> sendFileToCNC(String host, String port) async {
  //   if (_validFile) {
  //     _isLoading = true;
  //     _connectedToMachine = false;
  //     notifyListeners();
  //
  //     late ResponseModel responseModel;
  //     try {
  //       _socket = await Socket.connect(host, int.parse(port));
  //       debugPrint('Connected to $host on port $port');
  //       _connectedToMachine = true;
  //       notifyListeners();
  //
  //       // Read the G-code file content
  //       File file = File(_filePickerResult!.files.single.path!);
  //       String fileContent = await file.readAsString();
  //
  //       // Calculate total file size
  //       int totalBytes = file.lengthSync();
  //       int bytesSent = 0;
  //
  //       /*// Send G-code commands as a single string
  //       socket.write(fileContent);*/
  //
  //       // Send G-code commands as a stream of bytes
  //       // send file in correct format (stackOverFlow)
  //       await _socket!.addStream(file.openRead());
  //
  //       // Send G-code commands
  //       _socket!.listen(
  //         (List<int> data) {
  //           bytesSent += data.length;
  //
  //           // Calculate progress percentage and notify listeners
  //           double progress = bytesSent / totalBytes;
  //           _progressController.add(progress);
  //         },
  //         onDone: () {
  //           debugPrint('File sent successfully');
  //           // Close the socket when done
  //           _socket?.close();
  //           _connectedToMachine = false;
  //           responseModel = ResponseModel.withSuccess('File sent successfully');
  //         },
  //         onError: (error) {
  //           debugPrint('Error receiving response: $error');
  //           // Close the socket in case of an error
  //           _socket?.close();
  //           responseModel = ResponseModel.withError('Error receiving response: $error');
  //         },
  //       );
  //     } catch (e) {
  //       debugPrint('Error connecting to $host on port $port: $e');
  //       responseModel = ResponseModel.withError('Error connecting to `$host` on port `$port`.\n$e');
  //     } finally {
  //       _isLoading = false;
  //       _connectedToMachine = false;
  //       notifyListeners();
  //     }
  //     return responseModel;
  //   }
  //
  //   return ResponseModel.withError('File is not valid "${_filePickerResult?.files.first.extension?.toUpperCase()}"!');
  // }

  Future<ResponseModel> sendFileToFirebase() async {
    if (_validFile) {
      _isLoading = true;
      notifyListeners();

      late ResponseModel responseModel;
      try {
        // Read the G-code file content
        File file = File(_filePickerResult!.files.single.path!);

        // Calculate total file size
        int totalBytes = file.lengthSync();
        int bytesSent = 0;

        // upload the file to firebase
        String fileName = _filePickerResult!.files.single.name;
        debugPrint('file name: $fileName');
        debugPrint('file path: ${file.path}');
        UploadTask uploadTask = FirebaseStorage.instance.ref('files').child(fileName).putFile(file);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        debugPrint('File sent successfully');
        responseModel = ResponseModel.withSuccess(downloadUrl);

        // put the file downloadUrl to firebase cloud in with key "uploaded_file"
        await FirebaseFirestore.instance.collection('files').doc(fileName).set({
          "uploaded_file": downloadUrl,
        });
      } catch (e) {
        if(kDebugMode) rethrow;
        final errorMessage= 'Error when uploading file to Firebase: $e';
        debugPrint(errorMessage);
        responseModel = ResponseModel.withError(errorMessage);
      } finally {
        _isLoading = false;
        notifyListeners();
      }
      return responseModel;
    }

    return ResponseModel.withError('File is not valid "${_filePickerResult?.files.first.extension?.toUpperCase()}"!');
  }

  @override
  void dispose() {
    _progressController.close();
    super.dispose();
  }
}
