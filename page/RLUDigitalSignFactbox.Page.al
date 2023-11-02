page 50101 "RLU Digital Sign Factbox"
{
    Caption = 'Digital Sign';
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "RLU Digital Sign";
    layout
    {
        area(content)
        {
            field("Sign Image"; Rec."Sign Image")
            {
                ApplicationArea = all;
                ShowCaption = false;
                trigger OnValidate()
                begin
                    CurrPage.Update();
                    Rec.Reset();
                end;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';
                trigger OnAction()
                begin
                    ImportFromDevice(); //Memanggil fungsi local yang sudah dibuat
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Image = Delete;
                ToolTip = 'Delete the record.';
                trigger OnAction()
                begin
                    DeleteItemPicture(); //Memanggil fungsi local yang sudah dibuat
                end;
            }
        }
    }

    var
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';

    procedure DeleteItemPicture()
    var
        RLUDigitalSign: Record "RLU Digital Sign";
    begin
        Rec.TestField("Sign Image");

        if not Confirm(DeleteImageQst) then
            exit;
        if RLUDigitalSign.Get(Rec."User Security ID") then begin
            Clear(RLUDigitalSign."Sign Image");
            RLUDigitalSign.Modify();
        end;
    end;

    local procedure ImportFromDevice();
    var
        RLUDigitalSign: Record "RLU Digital Sign";
        PictureInStream: InStream;
        FromFileName: Text;
    begin
        if RLUDigitalSign.Get(Rec."User Security ID") then begin
            if UploadIntoStream('Please select the image to upload', '', 'All Files (*.*)|*.*', FromFileName, PictureInStream) then begin
                Rec."Sign Image".ImportStream(PictureInStream, FromFileName);
                Rec.Modify();
            end;
        end else
            if UploadIntoStream('Please select the image to upload', '', 'All Files (*.*)|*.*', FromFileName, PictureInStream) then begin
                Rec."User Security ID" := Rec."User Security ID";
                Rec."Sign Image".ImportStream(PictureInStream, FromFileName);
                Rec.Insert();
            end;
    end;
}