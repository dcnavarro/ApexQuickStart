public class AnimalLocator {

    public static String getAnimalNameById(Integer Id) {
        System.debug('Starting getAnimalNameById with Id: ' + Id);

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + Id);
        request.setMethod('GET');

        try {
            HttpResponse response = http.send(request);
            System.debug('Response status code: ' + response.getStatusCode());

            if (response.getStatusCode() == 200) {
                String responseBody = response.getBody();
                System.debug('Response body: ' + responseBody);

                if(responseBody == null || responseBody == '{}' || responseBody == 'null') {
                    return 'Animal not found';
                }

                Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
                String animalName = (String) result.get('name');
                System.debug('Animal name: ' + animalName);

                if(animalName == null) {
                    return 'Animal not found';
                }

                return animalName;
            } else {
                System.debug('Error response: ' + response.getBody());
                return 'Animal not found';
            }
        } catch (Exception e) {
            System.debug('Error fetching animal name: ' + e.getMessage());
            return 'Error fetching animal name';
        }
    }
}
