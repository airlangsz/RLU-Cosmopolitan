table 50100 "RLU Matrix Dimension"
{
    DataClassification = ToBeClassified;
    LookupPageId = "RLU Matrix Dimension";

    fields
    {
        field(1; "Block Code"; Code[20])
        {
            Caption = 'Block Code';
            DataClassification = ToBeClassified;
        }
        field(22; "Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(23; Type; Option)
        {
            OptionCaption = ',Mature,Immature';
            OptionMembers = "",Mature,Immature;
            DataClassification = ToBeClassified;
        }
        field(2; "Hectare Area"; Integer)
        {
            Caption = 'Hectare Area';
            DataClassification = ToBeClassified;
        }
        field(3; "Stand per Hectare"; Integer)
        {
            Caption = 'Stand per Hectare';
            DataClassification = ToBeClassified;
        }
        field(4; "Dimension 1"; Code[20])
        {
            Caption = 'Dimension 1';
            DataClassification = ToBeClassified;
        }
        field(5; "Dimension 1 Name"; Text[50])
        {
            Caption = 'Dimension 1 Name';
            DataClassification = ToBeClassified;
        }
        field(6; "Dimension 2"; Code[20])
        {
            Caption = 'Dimension 2';
            DataClassification = ToBeClassified;
        }
        field(7; "Dimension 2 Name"; Text[50])
        {
            Caption = 'Dimension 2 Name';
            DataClassification = ToBeClassified;
        }
        field(8; "Dimension 3"; Code[20])
        {
            Caption = 'Dimension 3';
            DataClassification = ToBeClassified;
        }
        field(9; "Dimension 3 Name"; Text[50])
        {
            Caption = 'Dimension 3 Name';
            DataClassification = ToBeClassified;
        }
        field(10; "Dimension 4"; Code[20])
        {
            Caption = 'Dimension 4';
            DataClassification = ToBeClassified;
        }
        field(11; "Dimension 4 Name"; Text[50])
        {
            Caption = 'Dimension 4 Name';
            DataClassification = ToBeClassified;
        }
        field(12; "Dimension 5"; Code[20])
        {
            Caption = 'Dimension 5';
            DataClassification = ToBeClassified;
        }
        field(13; "Dimension 5 Name"; Text[50])
        {
            Caption = 'Dimension 5 Name';
            DataClassification = ToBeClassified;
        }
        field(14; "Dimension 6"; Code[20])
        {
            Caption = 'Dimension 6';
            DataClassification = ToBeClassified;
        }
        field(15; "Dimension 6 Name"; Text[50])
        {
            Caption = 'Dimension 6 Name';
            DataClassification = ToBeClassified;
        }
        field(16; "Dimension 7"; Code[20])
        {
            Caption = 'Dimension 7';
            DataClassification = ToBeClassified;
        }
        field(17; "Dimension 7 Name"; Text[50])
        {
            Caption = 'Dimension 7 Name';
            DataClassification = ToBeClassified;
        }
        field(18; "Dimension 8"; Code[20])
        {
            Caption = 'Dimension 8';
            DataClassification = ToBeClassified;
        }
        field(19; "Dimension 8 Name"; Text[50])
        {
            Caption = 'Dimension 8 Name';
            DataClassification = ToBeClassified;
        }
        field(20; "CreatedDimSet"; Boolean)
        {
            Caption = 'CreatedDimSet';
            Editable = false;
        }
        field(21; "DimSetId"; Integer)
        {
            TableRelation = "Dimension Set Entry"."Dimension Set ID";
            Editable = false;
        }
        field(25; "Include"; Boolean)
        {
            Caption = 'Include for Allocation';
        }
    }

    keys
    {
        key(Key1; "Block Code")
        {
            Clustered = true;
        }
    }
}