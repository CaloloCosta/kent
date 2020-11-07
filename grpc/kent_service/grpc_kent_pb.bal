import ballerina/grpc;
import ballerina/io;

public type kentBlockingClient client object {
    private grpc:Client grpcClient;

    function __init(string url, grpc:ClientEndpointConfig? config = ()) {
        // initialize client endpoint.
        grpc:Client c = new(url, config = config);
        error? result = c.initStub("blocking", ROOT_DESCRIPTOR, getDescriptorMap());
        if (result is error) {
            panic result;
        } else {
            self.grpcClient = c;
        }
    }


    remote function book(BookingDetails req, grpc:Headers? headers = ()) returns ((BookingId, grpc:Headers)|error) {
        
        var payload = check self.grpcClient->blockingExecute("grpc_service.kent/book", req, headers = headers);
        grpc:Headers resHeaders = new;
        any result = ();
        (result, resHeaders) = payload;
        var value = BookingId.convert(result);
        if (value is BookingId) {
            return (value, resHeaders);
        } else {
            error err = error("{ballerina/grpc}INTERNAL", {"message": value.reason()});
            return err;
        }
    }

    remote function deposit(DepositDetails req, grpc:Headers? headers = ()) returns ((Confirmation, grpc:Headers)|error) {
        
        var payload = check self.grpcClient->blockingExecute("grpc_service.kent/deposit", req, headers = headers);
        grpc:Headers resHeaders = new;
        any result = ();
        (result, resHeaders) = payload;
        var value = Confirmation.convert(result);
        if (value is Confirmation) {
            return (value, resHeaders);
        } else {
            error err = error("{ballerina/grpc}INTERNAL", {"message": value.reason()});
            return err;
        }
    }

};

public type kentClient client object {
    private grpc:Client grpcClient;

    function __init(string url, grpc:ClientEndpointConfig? config = ()) {
        // initialize client endpoint.
        grpc:Client c = new(url, config = config);
        error? result = c.initStub("non-blocking", ROOT_DESCRIPTOR, getDescriptorMap());
        if (result is error) {
            panic result;
        } else {
            self.grpcClient = c;
        }
    }


    remote function book(BookingDetails req, service msgListener, grpc:Headers? headers = ()) returns (error?) {
        
        return self.grpcClient->nonBlockingExecute("grpc_service.kent/book", req, msgListener, headers = headers);
    }

    remote function deposit(DepositDetails req, service msgListener, grpc:Headers? headers = ()) returns (error?) {
        
        return self.grpcClient->nonBlockingExecute("grpc_service.kent/deposit", req, msgListener, headers = headers);
    }

};

type Date record {|
    int int_day;
    int int_month;
    int int_year;
    
|};


type Time record {|
    int int_hour;
    int min;
    
|};


type BookingDetails record {|
    Date date;
    Time time;
    int gests;
    int duration;
    
|};


type BookingId record {|
    string bookigId;
    BookingDetails bd;
    
|};


type DepositDetails record {|
    BookingId id;
    float money;
    
|};


type Confirmation record {|
    boolean confirmed;
    
|};



const string ROOT_DESCRIPTOR = "0A0F677270635F6B656E742E70726F746F120C677270635F736572766963651A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22420A044461746512100A03646179180120012805520364617912140A056D6F6E746818022001280552056D6F6E746812120A0479656172180320012805520479656172222C0A0454696D6512120A04686F75721801200128055204686F757212100A036D696E18022001280552036D696E2292010A0E426F6F6B696E6744657461696C7312260A046461746518012001280B32122E677270635F736572766963652E4461746552046461746512260A0474696D6518022001280B32122E677270635F736572766963652E54696D65520474696D6512140A05676573747318032001280552056765737473121A0A086475726174696F6E18042001280552086475726174696F6E22550A09426F6F6B696E674964121A0A08626F6F6B696749641801200128095208626F6F6B69674964122C0A02626418022001280B321C2E677270635F736572766963652E426F6F6B696E6744657461696C7352026264224F0A0E4465706F73697444657461696C7312270A02696418012001280B32172E677270635F736572766963652E426F6F6B696E6749645202696412140A056D6F6E657918022001280252056D6F6E6579222C0A0C436F6E6669726D6174696F6E121C0A09636F6E6669726D65641801200128085209636F6E6669726D6564328A010A046B656E74123D0A04626F6F6B121C2E677270635F736572766963652E426F6F6B696E6744657461696C731A172E677270635F736572766963652E426F6F6B696E67496412430A076465706F736974121C2E677270635F736572766963652E4465706F73697444657461696C731A1A2E677270635F736572766963652E436F6E6669726D6174696F6E620670726F746F33";
function getDescriptorMap() returns map<string> {
    return {
        "grpc_kent.proto":"0A0F677270635F6B656E742E70726F746F120C677270635F736572766963651A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22420A044461746512100A03646179180120012805520364617912140A056D6F6E746818022001280552056D6F6E746812120A0479656172180320012805520479656172222C0A0454696D6512120A04686F75721801200128055204686F757212100A036D696E18022001280552036D696E2292010A0E426F6F6B696E6744657461696C7312260A046461746518012001280B32122E677270635F736572766963652E4461746552046461746512260A0474696D6518022001280B32122E677270635F736572766963652E54696D65520474696D6512140A05676573747318032001280552056765737473121A0A086475726174696F6E18042001280552086475726174696F6E22550A09426F6F6B696E674964121A0A08626F6F6B696749641801200128095208626F6F6B69674964122C0A02626418022001280B321C2E677270635F736572766963652E426F6F6B696E6744657461696C7352026264224F0A0E4465706F73697444657461696C7312270A02696418012001280B32172E677270635F736572766963652E426F6F6B696E6749645202696412140A056D6F6E657918022001280252056D6F6E6579222C0A0C436F6E6669726D6174696F6E121C0A09636F6E6669726D65641801200128085209636F6E6669726D6564328A010A046B656E74123D0A04626F6F6B121C2E677270635F736572766963652E426F6F6B696E6744657461696C731A172E677270635F736572766963652E426F6F6B696E67496412430A076465706F736974121C2E677270635F736572766963652E4465706F73697444657461696C731A1A2E677270635F736572766963652E436F6E6669726D6174696F6E620670726F746F33",
        "google/protobuf/wrappers.proto":"0A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F120F676F6F676C652E70726F746F62756622230A0B446F75626C6556616C756512140A0576616C7565180120012801520576616C756522220A0A466C6F617456616C756512140A0576616C7565180120012802520576616C756522220A0A496E74363456616C756512140A0576616C7565180120012803520576616C756522230A0B55496E74363456616C756512140A0576616C7565180120012804520576616C756522220A0A496E74333256616C756512140A0576616C7565180120012805520576616C756522230A0B55496E74333256616C756512140A0576616C756518012001280D520576616C756522210A09426F6F6C56616C756512140A0576616C7565180120012808520576616C756522230A0B537472696E6756616C756512140A0576616C7565180120012809520576616C756522220A0A427974657356616C756512140A0576616C756518012001280C520576616C756542570A13636F6D2E676F6F676C652E70726F746F627566420D577261707065727350726F746F50015A057479706573F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33"
        
    };
}
