import 'dart:io';

import 'package:awesome_flutter_desktop/includes.dart';

const _kAutoGenMark = '<!--AUTO-GENERATE-->';

void main(List<String> args) async {
  await init();

  File file = File('./README.md');
  String content = file.readAsStringSync();

  List<Project> projectList = sharedLocalDb.projects!.list()!;
  List<Package> packageList = sharedLocalDb.packages!.list()!;

  projectList.sort((a, b) => a.name!.compareTo(b.name!));
  packageList.sort((a, b) => a.name!.compareTo(b.name!));

  String md = '''
## Packages

| Name | Repo | Description |
| :--- | :--- | :--- |
${packageList.map((e) => e.md).join('\n')}

## Projects

| Name | Repo | Description |
| :--- | :--- | :---------- |
${projectList.map((e) => e.md).join('\n')}

''';

  int markIndexS = content.indexOf(_kAutoGenMark) + _kAutoGenMark.length;
  int markIndexE = content.lastIndexOf(_kAutoGenMark);

  String newContent = '';
  newContent += content.substring(0, markIndexS);
  newContent += '\n$md\n';
  newContent += content.substring(markIndexE);

  file.writeAsStringSync(newContent);
}
