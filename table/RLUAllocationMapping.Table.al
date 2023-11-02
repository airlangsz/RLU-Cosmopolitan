table 50102 "RLU Allocation Mapping"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Allo Code"; Code[20])
        {
            Caption = 'Allocation Code';
            DataClassification = ToBeClassified;
            // TableRelation = "G/L Account"."No.";
        }
        field(2; "Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Basis From"; Code[20])
        {
            Caption = 'Basis From';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(4; "Basis To"; Code[20])
        {
            Caption = 'Basis To';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(5; "Target Immature"; Code[20])
        {
            Caption = 'Target Immature';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(6; "Offset"; Code[20])
        {
            Caption = 'Offset';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(7; "Target Mature"; Code[20])
        {
            Caption = 'Target Mature';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(8; "COGS Mature"; Code[20])
        {
            Caption = 'COGS Mature';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(9; "COGS Mature Offset"; Code[20])
        {
            Caption = 'COGS Mature Offset';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(10; "Block Code Other"; Code[20])
        {
            Caption = 'Block Code Other';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Allo Code")
        {
            Clustered = true;
        }
    }

}