# Echo http requests

Echo is a tool for testing how your applications handle http responses.
It allows you to define a http response in the request its self.

## Usage

Echo takes the following params, either as json, or url encoded.

* status {integer} - http response status
* body {string} - response body content
* headers {object} - response headers

Echo will respond to the following http verbs:

* GET
* POST
* DELETE
* PATCH
* PUT

e.g. using all params:

a json request:

```sh
curl -XPOST echo.nathansplace.co.uk/echo -v -H 'Content-Type: application/json' -d
'{"body": "{\"teapot\": true}", "status": 418, "headers": "{\"Content-Type\":
\"application/json\"}"}'
```

and the same thing url encoded params:

```sh
curl -XPOST
echo.nathansplace.co.uk/echo?body%3D%7B%22teapot%22%3A%20true%7D%26status%3D418%26headers%5BContent-Type%5D%3Dapplication%2Fjson -v
```
(?body={"teapot": true}&status=418&headers[Content-Type]=application/json)

And an ajax example using [ajax.js](https://github.com/nathamanath/ajax.js)

```javascript
Ajax.request({
  url: 'http://echo.nathansplace.co.uk/echo',
  type: 'JSON',
  method: 'POST';
  data: {
    body: '{"teapot": true}',
    status: 418,
    headers: {Content-Type: 'application/json'}
  },
  onSuccess: function(xhr) {
    console.log('horray');
  }
});
```

