query 50100 "RLU Package No"
{
    QueryType = Normal;


    elements
    {
        dataitem(Warehouse_Activity_Line; "Warehouse Activity Line")
        {
            column(Action_Type; "Action Type")
            {

            }
            column(No_; "No.")
            {

            }
            column(Package_No_; "Package No.")
            {

            }
            column(Quantity; Quantity)
            {
                Method = Sum;
            }

        }
    }

    var

    trigger OnBeforeOpen()
    begin

    end;
}