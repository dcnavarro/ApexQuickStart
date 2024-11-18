@isTest
global class AnimalLocatorMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200);

        // Determine the response based on the request URL
        String url = req.getEndpoint();
        if (url.endsWith('/1')) {
            res.setBody('{"id": 1, "name": "majestic badger"}');
        } else if (url.endsWith('/2')) {
            res.setBody('{"id": 2, "name": "fluffy kitten"}');
        } else {
            res.setBody('{}'); // Return an empty JSON object for unknown IDs
        }

        return res;
    }
}
