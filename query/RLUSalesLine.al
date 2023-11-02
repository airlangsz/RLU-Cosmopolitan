query 50103 "RLU SalesLine"
{
    QueryType = Normal;


    elements
    {
        dataitem(Sales_Line; "Sales Line")
        {
            column(Document_Type; "Document Type")
            {

            }
            column(Document_No_; "Document No.")
            {

            }
            column(Blanket_Order_No_; "Blanket Order No.")
            {

            }
            column(Line_Amount; "Line Amount")
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