// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item {

    property string dbName: "czMeteo"
    property string dbVersion: "1.0"
    property string dbDisplayName: "czMeteo"
    property int dbEstimatedSize: 100

    function set(key, value) {
//        console.log(key + " = " + value)

        var db = openDatabaseSync(dbName, dbVersion, dbDisplayName, dbEstimatedSize);
        db.transaction(
                    function(tx) {
                        tx.executeSql('CREATE TABLE IF NOT EXISTS Keys(key TEXT, value TEXT)');
                        var rs = tx.executeSql('SELECT * FROM Keys WHERE key==?', [ key ]);

                        if (rs.rows.length === 0){
                            tx.executeSql('INSERT INTO Keys VALUES(?, ?)', [ key, value ]);
                        } else {
                            tx.executeSql('UPDATE Keys SET value=? WHERE key==?', [value, key]);
                        }
                    })
    }

    function get(key, default_value) {
        var db = openDatabaseSync(dbName, dbVersion, dbDisplayName, dbEstimatedSize);
        var result = "";
        db.transaction(
                    function(tx) {

                        tx.executeSql('CREATE TABLE IF NOT EXISTS Keys(key TEXT, value TEXT)');
                        var rs = tx.executeSql('SELECT * FROM Keys WHERE key=?', [ key ]);
                        if (rs.rows.length === 1 && rs.rows.item(0).value.length > 0){
                            result = rs.rows.item(0).value
                        }
                        else {
                            result = default_value;
                        }
                    }
                    )
//        console.log(key + " : " + result)
        return result;
    }

}
