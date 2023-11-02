table 50110 "RLU Cash Flow"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "CF Code"; Code[20])
        {
            Caption = 'Cash FLow Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "CF Type"; Option)
        {
            Caption = 'Cash Flow Type';
            OptionMembers = "","Inflow","Outflow";
            OptionCaption = ',Inflow,Outflow';
        }

    }

    keys
    {
        key(PK; "CF Code")
        {
            Clustered = true;
        }
    }

}