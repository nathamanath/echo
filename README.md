# echoecho

Responds to a request just how you would like it to.

## Usage

send an http request via any method, and tell it how to respond.
```sh
curl -XPOST -H "Content-Type: application/json" echoecho -d '{"status": 200, "body": "{\"message\": true}"}'
```

The following arguments are accepted:

* status  <integer>
* content <string>
* headers <object>

