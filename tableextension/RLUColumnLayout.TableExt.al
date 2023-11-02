tableextension 50105 "RLU Column Layout" extends "Column Layout"
{
    fields
    {
        field(50100; "Journal Batch Name"; Code[10])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Template Type" = filter(General));
        }
        field(50101; TypeAudit; Option)
        {
            OptionMembers = ,"Audited","Unaudited";
        }
    }

}