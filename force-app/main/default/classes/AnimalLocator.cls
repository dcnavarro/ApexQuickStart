public class AnimalLocator {
    public static String getAnimalNameById(Integer id) {
        // Construct the endpoint URL with the given ID
        String endpoint = 'https://th-apex-http-callout.herokuapp.com/animals/' + id;

        // Create an instance of Http and HttpRequest
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');

        // Send the request and get the response
        HttpResponse response = http.send(request);
        
        // Check if the response status code is 200 (OK)
        if (response.getStatusCode() == 200) {
            // Parse the response JSON
            Map<String, Object> resultMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Extract and return the name property
            if (resultMap.containsKey('name')) {
                return (String) resultMap.get('name');
            }
        }
        // Return null or handle error case if the status code is not 200
        return null;
    }
}
