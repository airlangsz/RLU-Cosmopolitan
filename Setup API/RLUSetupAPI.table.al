table 50111 RLUSetupAPi
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; PrimaryKey; Code[20])
        {
            DataClassification = ToBeClassified;

        }

        field(2; ApiName; Text[50])
        {
            DataClassification = ToBeClassified;

        }

        field(3; SecretKey; Text[50])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; PrimaryKey)
        {
            Clustered = true;
        }
    }

    var
    trigger OnInsert()
    begin
    end;

    trigger OnModify()
    begin
    end;

    trigger OnDelete()
    begin
    end;

    trigger OnRename()
    begin
    end;

}