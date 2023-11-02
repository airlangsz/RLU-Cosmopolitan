tableextension 50117 "RLU Customer" extends Customer
{
    fields
    {
        field(50100; "CF Code Inflow"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'CF Code Inflow';
            TableRelation = "RLU Cash Flow"."CF Code" WHERE("CF Type" = filter(Inflow));
        }

        field(50101; "CF Code Outflow"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'CF Code Outflow';
            TableRelation = "RLU Cash Flow"."CF Code" WHERE("CF Type" = filter(Outflow));
        }

        field(50102; "Post"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Post';
        }
    }
}