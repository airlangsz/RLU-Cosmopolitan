table 50108 "RLU Default Code"
{
    Caption = 'Default Code';
    DataClassification = ToBeClassified;
    LookupPageId = "RLU Default Code List";
    DrillDownPageId = "RLU Default Code List";

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            DataClassification = ToBeClassified;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table),
                                             "Object ID" = field("Table ID"));
        }
        field(2; "Table Caption"; Text[250])
        {
            Caption = 'Table Caption';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(AllObjWithCaption."Object Name" where("Object ID" = field("Table ID")));
        }
        field(3; "Field ID"; Integer)
        {
            Caption = 'Field ID';
            DataClassification = ToBeClassified;
            TableRelation = Field."No." where(TableNo = field("Table ID"));
        }
        field(4; "Field Caption"; Text[250])
        {
            Caption = 'Field Caption';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field("Table ID"),
                                                              "No." = field("Field ID")));
        }
        field(5; "Code"; Code[25])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Table ID", "Field ID", "Code")
        {
            Clustered = true;
        }
    }
}
