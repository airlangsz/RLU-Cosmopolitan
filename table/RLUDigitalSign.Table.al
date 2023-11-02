table 50101 "RLU Digital Sign"
{
    Caption = 'RLU Digital Sign';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "User Security ID"; Guid)
        {
            Caption = 'User';
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(2; "Sign Image"; Media)
        {
            Caption = 'Image';
            ExtendedDatatype = Person;
        }
    }
    keys
    {
        key(Key1; "User Security ID")
        {
            Clustered = true;
        }
    }
}