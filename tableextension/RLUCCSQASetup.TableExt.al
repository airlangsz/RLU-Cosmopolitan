tableextension 50114 "RLU CCS QA Setup" extends "CCS QA Setup"
{
    fields
    {
        field(50100; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
            TableRelation = "Item Journal Template";
        }
        field(50101; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
    }
}
