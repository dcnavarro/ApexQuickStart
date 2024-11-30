@isTest
global class ParkServiceMock implements WebServiceMock {
    global void doInvoke(
            Object stub,
            Object request,
            Map<String, Object> response,
            String endpoint,
            String soapAction,
            String requestName,
            String responseNS,
            String responseName,
            String responseType) {
        
        // Specify the response you want to send
        ParkService.byCountryResponse response_x = new ParkService.byCountryResponse();
        
        String country = ((ParkService.byCountry) request).arg0;
        
        if (country == 'Germany') {
            response_x.return_x = new String[]{'Berlin Park', 'Munich Park'};
        } else if (country == 'India') {
            response_x.return_x = new String[]{'National Park', 'Tiger Reserve'};
        } else if (country == 'Japan') {
            response_x.return_x = new String[]{'Tokyo Park', 'Osaka Park'};
        } else if (country == 'United States') {
            response_x.return_x = new String[]{'Yosemite', 'Grand Canyon'};
        } else {
            response_x.return_x = new String[]{};
        }
        
        response.put('response_x', response_x);
    }
}
