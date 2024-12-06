// public class CustomMetadataService {
//     public CustomMetadataService() {}
//     /**
//      * This method instantiates a custom metadata record of type Support_Tier__mdt
//      * and sets the DeveloperName to the input String.
//      * The record is not inserted into the database,
//      * and would not be found by a SOQL query.
//      */
//     public Support_Tier__mdt getCustomMetadataRecord(String myName) {
//         Support_Tier__mdt supportTier = new Support_Tier__mdt();
//         supportTier.DeveloperName = myName;
//         return supportTier;
//     }
//     /**
//      * This method retrieves a custom metadata record, changes a field, and returns it
//      * to the caller, but does not update the database.
//      */
//     public Support_Tier__mdt getChangedCustomMetadataRecord(String myNewName) {
//         Support_Tier__mdt supportTier = [SELECT Id, DeveloperName from Support_Tier__mdt LIMIT 1];
//         supportTier.DeveloperName = myNewName;
//         return supportTier;
//     }
// }