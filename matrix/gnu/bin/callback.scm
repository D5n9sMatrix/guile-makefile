; 3.4.8 Example 3: The Callback Closure Problem

; A frequently used programming model for library code is to allow an application to register a callback function for the library to call when some particular event occurs. It is often useful for the application to make several such registrations using the same callback function, for example if several similar library events can be handled using the same application code, but the need then arises to distinguish the callback function calls that are associated with one callback registration from those that are associated with different callback registrations.

; In languages without the ability to create functions dynamically, this problem is usually solved by passing a user_data parameter on the registration call, and including the value of this parameter as one of the parameters on the callback function. Here is an example of declarations using this solution in C:

; typedef void (event_handler_t) (int event_type,
;                                 void *user_data);

; void register_callback (int event_type,
;                         event_handler_t *handler,
;                         void *user_data);

; In Scheme, closure can be used to achieve the same functionality without requiring the library code to store a user-data for each callback registration.

;; In the library:

(define register-callback 'handler-proc)

;; In the application:

(define make-handler ' user-data)


; As far as the library is concerned, handler-proc is a procedure with no arguments, and all the library has to do is call it when the appropriate event occurs. From the application’s point of view, though, the handler procedure has used closure to capture an environment that includes all the context that the handler code needs — event-type and user-data — to handle the event correctly.
