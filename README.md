# echoecho

Responds to a request just how you would like it to.

## Usage

Send an http request via any method, and tell it how to respond.

e.g.
```sh
curl -XPOST -H "Content-Type: application/json" echoecho -d '{ "status": 418, "body": "hi there" }'
```

Will respond with the status 418, and response body `hi there`.

Default response settings are:

* status: 200
* content type: text/html

The following arguments are accepted as JSON, or as URL params:

* status  <integer>
* content <string>
* headers <object> e.g. { "headers": { "Content-Type": "application/json" }} ||
  ?headers=[Content-Type]=application%2fjson

