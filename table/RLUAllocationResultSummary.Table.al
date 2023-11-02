table 50107 "RLU Allocation Result Summary"
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
        field(4; "GL Account No"; Code[20])
        {
            Caption = 'GL Account No';
            DataClassification = ToBeClassified;
            TableRelation = "RLU Allocation Mapping"; //perlu cek lg
        }
        field(5; "GL Description"; Text[100])
        {
            Caption = 'GL Description';
            DataClassification = ToBeClassified;
        }
        field(6; "Allo Result Balance"; Decimal)
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