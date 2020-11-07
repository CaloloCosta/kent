import ballerina/grpc;
import ballerina/time;



listener grpc:Listener ep = new (9000);

service kent on ep {

    resource function book(grpc:Caller caller, BookingDetails value) {
        // Implementation goes here.
        string id = "10101";
        // You should return a BookingId
        error? result = caller->send(id);
        result = caller->complete();
    }
    resource function deposit(grpc:Caller caller, DepositDetails value) {
        // Implementation goes here.

        // You should return a Confirmation
    }
}

