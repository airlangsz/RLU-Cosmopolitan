table 50109 "RLU Origin Area"
{
    Caption = 'Origin Area';
    DataClassification = CustomerContent;
    LookupPageId = "RLU Origin Areas";

    fields
    {
        field(1; "Origin Area Code"; Code[15])
        {
            Caption = 'Origin Area Code';
        }
        field(2; "Province Code"; Code[15])
        {
            Caption = 'Province Code';
        }
        field(3; "Province Name"; Text[100])
        {
            Caption = 'Province Name';
        }
        field(4; "City Code"; Code[15])
        {
            Caption = 'City Code';
        }
        field(5; "City Name"; Text[100])
        {
            Caption = 'City Name';
        }
        field(6; "Supplier Category Code"; Code[25])
        {
            Caption = 'Supplier Category Code';
            TableRelation = "RLU Default Code".Code where("Table ID" = const(7001), "Field ID" = const(50100));
        }

        field(7; "Post"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Post';
        }
    }
    keys
    {
        key(PK; "Origin Area Code")
        {
            Clustered = true;
        }
    }
}
