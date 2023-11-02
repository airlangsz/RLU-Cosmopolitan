tableextension 50121 "RLU Gen Journal Batches" extends "Gen. Journal Batch"
{
    fields
    {
        field(50100; TypeAudit; Option)
        {
            Caption = 'Audit Type';
            OptionMembers = " ","Audited","Unaudited";
            TableRelation = "Gen. Journal Line";
            Editable = true;
        }

    }
}