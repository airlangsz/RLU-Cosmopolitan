codeunit 50106 RLUOriginAreaAPI
{
    trigger OnRun()
    begin
    end;

    procedure PostingArea(var RLUOriginArea: Record "RLU Origin Area");
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

        AReaToJson(RLUOriginArea).WriteTo(IniJson);

        RequestContent.WriteFrom(IniJson);
        RequestContent.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        // contentHeaders.Add('Content-Type', 'application/json');
        contentHeaders.Add('Content-Type', 'multipart/form-data');
        contentHeaders.Add('TIME_EXECUTE', '1698837962');
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

        // RLUOriginArea.Post := true;
        // RLUOriginArea.Modify();
    end;

    local procedure AReaToJson(var RLUOriginArea: Record "RLU Origin Area"): JsonObject
    var
        JAdjPost: JsonObject;
    begin
        JAdjPost.Add('AREAID', RLUOriginArea."Province Code");
        JAdjPost.Add('AREADESC', RLUOriginArea."Province Name");
    end;


    var

}