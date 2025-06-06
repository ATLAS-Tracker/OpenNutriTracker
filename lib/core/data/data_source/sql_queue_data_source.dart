import 'package:hive/hive.dart';
import 'package:opennutritracker/core/data/dbo/sql_command_dbo.dart';

class SqlQueueDataSource {
  final Box<SqlCommandDBO> _sqlQueueBox;

  SqlQueueDataSource(this._sqlQueueBox);

  Future<void> enqueue(SqlCommandDBO command) async {
    await _sqlQueueBox.add(command);
  }

  Future<SqlCommandDBO?> peek() async {
    return _sqlQueueBox.isNotEmpty ? _sqlQueueBox.getAt(0) : null;
  }

  Future<void> removeFirst() async {
    if (_sqlQueueBox.isNotEmpty) {
      await _sqlQueueBox.deleteAt(0);
    }
  }

  Future<void> putAt(int index, SqlCommandDBO command) async {
    await _sqlQueueBox.putAt(index, command);
  }

  int get length => _sqlQueueBox.length;
}
