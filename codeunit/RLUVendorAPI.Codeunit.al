codeunit 50107 RLUVendorAPI
{
    trigger OnRun()
    begin
    end;

    procedure PostingVendor(var Vendor: Record Vendor);
    var
        APIRec: Record RLUSetupAPi;
        HttpClient: HttpClient;
        ResponseMessage: HttpResponseMessage;
        URL: Text[250];
        RequestContent: HttpContent;
        contentHeaders: HttpHeaders;
        IniJson: Text;
        Apiname: Text[50];

    begin
        if APIRec.FindFirst() then
            Apiname := APIRec.ApiName;

        URL := 'http://mitraandalan.club:55204/api_wb16/ApiExec_MaCust.php';

        VendToJson(Vendor).WriteTo(IniJson);

        RequestContent.WriteFrom(IniJson);
        RequestContent.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');
        contentHeaders.Add('TIME_EXECUTE', '1698808241');
        contentHeaders.Add('KEY_SECRET', '5CF67Vp89vSt6wnRWOJTN6nCWLzAiORw');

        HttpClient.DefaultRequestHeaders().Add('User-Agent', 'Dynamics 365 Business Central');

        if not HttpClient.Post(URL, RequestContent, ResponseMessage)
        then
            Error('Posting to the web service failed.');

        if not ResponseMessage.IsSuccessStatusCode then
            error('The web service returned an error message:\' +
                  'Status code: %1' +
                  'Description: %2',
                  ResponseMessage.HttpStatusCode,
                  ResponseMessage.ReasonPhrase);

        Vendor.Post := true;
        Vendor.Modify();
    end;

    local procedure VendToJson(var Vendor: Record Vendor): JsonObject
    var
        JAdjPost: JsonObject;
    begin
        JAdjPost.Add('SUPPLIERCODE', Vendor."No.");
        JAdjPost.Add('SUPPLIERNAME', Vendor.Name);
        JAdjPost.Add('SUPPLIERTYPE', Vendor."Vendor Posting Group");
        JAdjPost.Add('INACTIVE', Format(Vendor.Blocked));
    end;


    var

}