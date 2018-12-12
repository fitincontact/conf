; .dir-locals.el
((go-mode . ((my-compile-command . " goimports -w . & go fmt & go build & go test"))))
