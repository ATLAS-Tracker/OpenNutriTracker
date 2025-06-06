import 'package:opennutritracker/core/data/data_source/sql_queue_data_source.dart';
import 'package:opennutritracker/core/data/dbo/sql_command_dbo.dart';

class SqlQueueRepository {
  final SqlQueueDataSource _dataSource;

  SqlQueueRepository(this._dataSource);

  Future<void> enqueue(SqlCommandDBO command) => _dataSource.enqueue(command);

  Future<SqlCommandDBO?> peek() => _dataSource.peek();

  Future<void> removeFirst() => _dataSource.removeFirst();

  Future<void> updateFirst(SqlCommandDBO command) async {
    if (_dataSource.length > 0) {
      await _dataSource.putAt(0, command);
    }
  }

  int get length => _dataSource.length;
}
