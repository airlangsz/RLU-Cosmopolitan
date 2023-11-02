pageextension 50110 "RLU User Digital Sign" extends "User Card"
{
    layout
    {
        addfirst(factboxes)
        {
            part(Sign; "RLU Digital Sign Factbox")
            {
                SubPageLink = "User Security ID" = field("User Security ID");
                ApplicationArea = All;
                UpdatePropagation = SubPart;
            }
        }
    }
}