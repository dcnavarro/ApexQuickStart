@isTest
public class TestVerifyDate {

    @isTest
    public static void testDateWithin30Days() {
        // Test cases for dates within 30 days
        Date date1 = Date.today();
        Date date2 = date1.addDays(25);
        Date result = VerifyDate.CheckDates(date1, date2);
        System.assert(date2 == result); // Use System.assert for comparison in Apex

        // Test case for date2 exactly 30 days after date1
        date2 = date1.addDays(30);
        result = VerifyDate.CheckDates(date1, date2);
        System.assert(date2 == result);
    }

    @isTest
    public static void testDateOutside30Days() {
        // Test case for date2 more than 30 days after date1
        Date date1 = Date.today();
        Date date2 = date1.addDays(31);
        Date expectedEndOfMonth = VerifyDate.SetEndOfMonthDate(date1);
        Date result = VerifyDate.CheckDates(date1, date2);
        System.assert(expectedEndOfMonth == result);

        // Test case for date2 in the past
        date2 = date1.addDays(-10);
        result = VerifyDate.CheckDates(date1, date2);
        System.assert(expectedEndOfMonth == result);
    }

    @isTest
    public static void testSetEndOfMonthDate() {
        // Test cases for different months and years
        Date date1 = Date.newInstance(2023, 2, 15); // February
        Date expectedEndOfMonth = Date.newInstance(2023, 2, 28);
        Date result = VerifyDate.SetEndOfMonthDate(date1);
        System.assert(expectedEndOfMonth == result);

        date1 = Date.newInstance(2024, 2, 15); // February in a leap year
        expectedEndOfMonth = Date.newInstance(2024, 2, 29);
        result = VerifyDate.SetEndOfMonthDate(date1);
        System.assert(expectedEndOfMonth == result);

        date1 = Date.newInstance(2023, 11, 10); // November
        expectedEndOfMonth = Date.newInstance(2023, 11, 30);
        result = VerifyDate.SetEndOfMonthDate(date1);
        System.assert(expectedEndOfMonth == result);
    }
}