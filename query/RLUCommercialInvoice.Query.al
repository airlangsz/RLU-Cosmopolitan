query 50102 "RLU Commercial Invoice"
{

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
            column(Line_No_; "Line No.")
            {

            }
            column(No_; "No.")
            {

            }
            column(Type; Type)
            {

            }
            column(RLU_SMPT_Lot_No; "RLU SMPT Lot No")
            {

            }
            column(RLU_MKC_Lot_No; "RLU MKC Lot No")
            {

            }
            column(Blanket_Order_No_; "Blanket Order No.")
            {

            }

            // filter(FilterName; SourceFieldName)
            // {

            // }
        }
    }

    var
    // myInt: Integer;

    trigger OnBeforeOpen()
    begin

    end;
}