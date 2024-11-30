public class ParkLocator {

    public static List<String> country(String country) {
        ParkService.ParksImplPort parkService = new ParkService.ParksImplPort();
        String[] parkNames = parkService.byCountry(country);
        return parkNames != null ? new List<String>(parkNames) : new List<String>();
    }
}
