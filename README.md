# Echo http requests

Echo is a tool for testing how your applications handle http and websocket
responses. It allows you to define a http response in the request its self.

http://echo.nathansplace.co.uk/echo?body=hello

## Usage

### Websockets

* Make a websocket connection to `echo.nathansplace.co.uk/echo`
* Send a message
* Receive the same message (hopefully)

#### Javascript example

A minimal javascript example.

```javascript
  var socket = new WebSocket("ws://echo.nathansplace.co.uk/echo");

  socket.addEventListener("message", function(e) {
    var message = e.data;
    console.log("got `" + message + "`");
  });

  socket.send("ECHO...");
```

### HTTP

Echo takes the following params, either as json, or url encoded query string.

* status {integer} - http response status
* body {string} - response body content
* headers {object} - response headers

Echo will respond to the following http verbs:

* GET
* POST
* DELETE
* PATCH
* PUT
* OPTIONS (CORS only)

CORS headers are set for you.

#### Curl example

A post request with json body and json response:

```sh
curl -v -X POST http://echo.nathansplace.co.uk/echo \
  -H "Content-Type: application/json" \
  -d '{"body": "{\"teapot\": true}", "status": 418, "headers": {"Content-Type": "application/json"}}'
```
