table 50105 "RLU Allocation Basis"
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
        field(3; "GL Account No"; Code[20])
        {
            Caption = 'GL Account No';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(4; "GL Description"; Text[100])
        {
            Caption = 'GL Description';
            DataClassification = ToBeClassified;
        }
        field(5; "Allo Basis Balance"; Decimal)
        {
            Caption = 'Allo Basis Balance';
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