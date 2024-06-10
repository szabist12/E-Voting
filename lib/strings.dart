import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

List<String> party = ["PTI","NON LEAGUE","TLP","PPP"];
List<String> na = ["NA-134","NA-135","NA-136","NA-137","NA-138","NA-139","NA-140","NA-141","NA-142","NA-143","NA-144","NA-145","NA-146","NA-147","NA-148","NA-149","NA-150"];
List<String> pp = ["PP-134","PP-135","PP-136","PP-137","PP-138","PP-139","PP-140","PP-141","PP-142","PP-143","PP-144","PP-145","PP-146","PP-147","PP-148","PP-149","PP-150"];


Future<String> imgfromfile(XFile img) async {
  final bytes = await img.readAsBytes();
  return base64Encode(bytes);
  // return base64Encode(await img.readAsBytes());
}

dynamic stringtoimg(String img) {
  return Uint8List.fromList(base64Decode(img));
}