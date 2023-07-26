#lang racket

(define echo-server (tcp-listen 55555 128 true))
(define (echo)
  (let*-values ([(in out) (tcp-accept echo-server)]
               [(bytes) (port->bytes in)]
               [(bytes-str) (bytes->string/utf-8 bytes #\A)])
    (displayln (string-append "Received: " bytes-str))
    (write-bytes bytes out)
    (close-output-port out)
    (displayln (string-append "Sent: " bytes-str)))
  (echo))

(echo)