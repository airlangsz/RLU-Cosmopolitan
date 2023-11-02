table 50104 "RLU Allocation Hectare Area"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Allo Trans No"; Integer)
        {
            Caption = 'Allocation Trans No';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
        }
        field(3; "Block Code"; Code[20])
        {
            Caption = 'Block Code';
            DataClassification = ToBeClassified;
            TableRelation = "RLU Matrix Dimension"."Block Code";
        }
        field(4; "Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(5; "Type"; Option)
        {
            OptionCaption = ',Mature,Immature';
            OptionMembers = "",Mature,Immature;
            DataClassification = ToBeClassified;
        }
        field(6; "Hectare Area"; Decimal)
        {
            Caption = 'Hectare Area';
            DataClassification = ToBeClassified;
        }
        field(7; "Hectare Percentage"; Decimal)
        {
            Caption = 'Hectare Percentage';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Allo Trans No", "Line No", "Block Code")
        {
            Clustered = true;
        }
    }

}