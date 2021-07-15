function openDatabase() {
    return LocalStorage.openDatabaseSync("ArcadeFlashWebDB", "1.0", "SQL", 100000000)
}

function initialize() {
    var db = openDatabase()
    db.transaction(
        function(tx) {
            tx.executeSql("CREATE TABLE IF NOT EXISTS config (navigateurLink TEXT NOT NULL, bezelActifData INTEGER NOT NULL, modeEcranData INTEGER NOT NULL, dateAndTimeData INTEGER NOT NULL)");
        }
    )
}

///////////////////////////////////////////////////////////////////////////////
// Enregistrer et récupérer le dernier répertoire utilisé dans le navigateur
///////////////////////////////////////////////////////////////////////////////
function setConfig(navigateurLink, bezelActifData, modeEcranData, dateAndTimeData) {
   var db = openDatabase();
   var res = "";
   deleteConfig();
   try {
        db.transaction(function(tx) {
         var rs = tx.executeSql('INSERT OR REPLACE INTO config VALUES (?, ?, ?, ?);', [navigateurLink, bezelActifData, modeEcranData, dateAndTimeData]);
         if (rs.rowsAffected > 0) {
            res = "Sauvegardé";
         }
        })
      }
    catch (err) {
        res = 0;
   };
  return res
}

function getConfig() {
   var db = openDatabase();
    var res = new Array([],[],[],[]);
    try {
        db.transaction(function(tx) {
         var rs = tx.executeSql('SELECT navigateurLink, bezelActifData, modeEcranData, dateAndTimeData FROM config');
         if (rs.rows.length > 0) {
             for (var i = 0; i < rs.rows.length; i++) {
                 res[0][i] = rs.rows.item(i).navigateurLink;
                 res[1][i] = rs.rows.item(i).bezelActifData;
                 res[2][i] = rs.rows.item(i).modeEcranData;
                 res[3][i] = rs.rows.item(i).dateAndTimeData;
             }
         }

        })
      }
    catch (err) {
        res = 0;
   };
  return res
}

function deleteConfig() {
   var db = openDatabase();
   db.transaction(function(tx) {
        var rs = tx.executeSql('DELETE FROM config');
        }
  );
}
