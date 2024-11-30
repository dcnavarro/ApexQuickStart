// const jsforce = require("jsforce");const conn = new jsforce.Connection({
//   // you can change loginUrl to connect to sandbox or prerelease env.
//   // loginUrl : "https://test.salesforce.com"
// });
// // Log in with basic SOAP login (see documentation for other auth options)
// conn.login(
//   process.env.USERNAME,
//   process.env.PASSWORD + process.env.SECURITY_TOKEN,
//   (err, res) => {
//     if (err) {
//       return console.error("Failed to log in to Salesforce: ", err);
//     }
//     console.log("Successfully logged in!");
//     // Run a SOQL query
//     conn.query("SELECT Id, Name FROM Account LIMIT 5", (err, result) => {
//       if (err) {
//         return console.error("Failed to run SOQL query: ", err);
//       }
//       // Display query results
//       const { records } = result;
//       console.log(`Fetched ${records.length} records:`);
//       records.forEach(record => {
//         console.log(`- ${record.Name} (${record.Id})`);
//       });
//     });
//   }
// );