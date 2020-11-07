import ballerina/grpc;
import ballerina/io;

public function main (string... args) {

    kentBlockingClient blockingEp = new("http://localhost:9000");

    io:println("----------making a booking-----");
	
	Time t = {int_hour: 12, min: 30};
	Date d = {int_day: 1,int_month: 2,int_year: 1996};	
    BookingDetails bd = {
        date: d,
        time: t,
        gests: 5,
        duration: 7200
    };

    var res = blockingEp->book(bd);
    if(res is error){

    }
    else{
        string result;
        grpc:Headers resHeaders;
        
        io:println(res);
    }


}


