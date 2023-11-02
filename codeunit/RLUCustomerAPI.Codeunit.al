codeunit 50105 RLUCustomerAPI
{
    trigger OnRun()
    begin
    end;

    procedure PostingCust(var cust: Record Customer);
    var
        APIRec: Record RLUSetupAPi;
        HttpClient: HttpClient;
        ResponseMessage: HttpResponseMessage;
        URL: Text[250];
        RequestContent: HttpContent;
        contentHeaders: HttpHeaders;
        IniJson: Text;
        Apiname: Text[50];
        tb: TextBuilder;

    begin
        if APIRec.FindFirst() then
            Apiname := APIRec.ApiName;

        URL := 'http://mitraandalan.club:55204/api_wb16/ApiExec_MaCust.php';

        // tb.AppendLine('--123456789');
        // tb.AppendLine(StrSubstNo('Content-Disposition: form-data; name="file"; filename="%1"', filename));
        // tb.AppendLine('Content-Type: application/json');
        // tb.AppendLine(); // Empty line required to separate the header information from payload
        tb.AppendLine('"AREAID": "enggo2", "AREADESC": "enggo2"');
        // tb.AppendLine('--123456789--');

        CustToJson(cust).WriteTo(IniJson);

        RequestContent.WriteFrom(tb.ToText());
        RequestContent.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'multipart/form-data');
        contentHeaders.Add('TIME_EXECUTE', '1698837602');
        contentHeaders.Add('KEY_SECRET', '5CF67Vp89vSt6wnRWOJTN6nCWLzAiORw');

        HttpClient.DefaultRequestHeaders().Add('User-Agent', 'Dynamics 365 Business Central');

        if not HttpClient.Post(URL, RequestContent, ResponseMessage)
        then
            Error('Posting to the web service failed.')
        else
            Message('post success');

        if not ResponseMessage.IsSuccessStatusCode then
            error('The web service returned an error message:\' +
                  'Status code: %1' +
                  'Description: %2',
                  ResponseMessage.HttpStatusCode,
                  ResponseMessage.ReasonPhrase)
        else
            Message('ga  error');

        cust.Post := true;
        cust.Modify();
    end;

    local procedure CustToJson(var Cust: Record Customer): JsonObject
    var
        JAdjPost: JsonObject;
    begin
        JAdjPost.Add('CUSTID', Cust."No.");
        JAdjPost.Add('CUSTDESC', Cust.name);
        JAdjPost.Add('INACTIVE', Format(Cust.Blocked));
    end;


    var

}