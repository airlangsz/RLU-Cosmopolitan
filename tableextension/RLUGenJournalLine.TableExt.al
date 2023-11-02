tableextension 50103 "RLU Gen. Journal Line" extends "Gen. Journal Line"
{
    fields
    {
        field(50100; TypeAudit; Option)
        {
            Caption = 'Audit Type';
            OptionMembers = " ","Audited","Unaudited";
        }
        field(50110; BlockCode; Code[20])
        {
            Caption = 'Block Code';
        }
        field(50111; "CF Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "RLU Cash Flow"."CF Code";
        }
    }
    trigger OnInsert()
    var
    begin
        if Rec.TypeAudit = 0 then
            Rec.TypeAudit := Rec.TypeAudit::Unaudited;

        Rec.Validate(TypeAudit, TypeAudit::Unaudited);

    end;
}