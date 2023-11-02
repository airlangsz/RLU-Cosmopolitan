table 50106 "RLU Allocation Result Detail"
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
        field(3; "Allo Code"; Code[20])
        {
            Caption = 'Allo Code';
            DataClassification = ToBeClassified;
            TableRelation = "RLU Allocation Mapping"."Allo Code";
        }
        field(4; "Block Code"; Code[20])
        {
            Caption = 'Block Code';
            DataClassification = ToBeClassified;
            TableRelation = "RLU Allocation Hectare Area"."Block Code";
        }
        field(5; "GL Account No"; Code[20])
        {
            Caption = 'GL Account No';
            DataClassification = ToBeClassified;
            TableRelation = "RLU Allocation Mapping"; //perlu cek lg
        }
        field(6; "GL Description"; Text[100])
        {
            Caption = 'GL Description';
            DataClassification = ToBeClassified;
        }
        field(7; "Allo Result Balance"; Decimal)
        {
            Caption = 'Allo Result Balance';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Allo Trans No", "Line No")
        {
            Clustered = true;
        }
    }

}