// @isTest
// private class MyTestClass {
//   @isTest static void myTest() {
//     // code_block
//   }
// }

// public class TaskUtil {
//   public static String getTaskPriority(String leadState) {
//     // Validate input
//     if(String.isBlank(leadState) || leadState.length() > 2) {
//       return null;
//     }
//     String taskPriority;
//     if(leadState == 'CA') {
//       taskPriority = 'High'; 
//     } else {
//       taskPriority = 'Normal';
//     }
//     return taskPriority;
//   }
// }

// @isTest
// private class TaskUtilTest {
//   @isTest
//   static void testTaskPriority() {
//     String pri = TaskUtil.getTaskPriority('NY');
//     System.assertEquals('Normal', pri);
//   }
// }