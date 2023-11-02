table 50103 "RLU Allocation Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Allo Trans No"; Integer)
        {
            Caption = 'Allocation Trans No';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Date From"; Date)
        {
            Caption = 'Date From';
            DataClassification = ToBeClassified;
        }
        field(3; "Date To"; Date)
        {
            Caption = 'Date To';
            DataClassification = ToBeClassified;
        }
        field(4; "Allo Code"; Code[20])
        {
            Caption = 'Allo Code';
            DataClassification = ToBeClassified;
            TableRelation = "RLU Allocation Mapping"."Allo Code";
        }
        field(5; "Allo Description"; Text[250])
        {
            Caption = 'Allo Description';
            DataClassification = ToBeClassified;
        }
        field(6; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(7; "Status"; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = "",Open,"In Process",Posted;
            OptionCaption = ',Open,In Process, Posted';
        }
        field(8; "Total Basis Balance"; Decimal)
        {
            Caption = 'Total Basis Balance';
            CalcFormula = sum("RLU Allocation Basis"."Allo Basis Balance" where("Allo Trans No" = field("Allo Trans No")));
            FieldClass = FlowField;
        }
        field(9; "Total Hectare Area"; Decimal)
        {
            Caption = 'Total Hectare Area';
            CalcFormula = sum("RLU Allocation Hectare Area"."Hectare Area" where("Allo Trans No" = field("Allo Trans No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(PK; "Allo Trans No")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        RLUAllocationBasis: Record "RLU Allocation Basis";
        RLUAllocationHectareArea: Record "RLU Allocation Hectare Area";
        RLUAllocationResultDetail: Record "RLU Allocation Result Detail";
        RLUAllocationResultSummary: Record "RLU Allocation Result Summary";
    begin
        RLUAllocationBasis.SetRange("Allo Trans No", Rec."Allo Trans No");
        RLUAllocationBasis.DeleteAll();

        RLUAllocationHectareArea.SetRange("Allo Trans No", Rec."Allo Trans No");
        RLUAllocationHectareArea.DeleteAll();

        RLUAllocationResultDetail.SetRange("Allo Trans No", Rec."Allo Trans No");
        RLUAllocationResultDetail.DeleteAll();

        RLUAllocationResultSummary.SetRange("Allo Trans No", Rec."Allo Trans No");
        RLUAllocationResultSummary.DeleteAll();
    end;

}