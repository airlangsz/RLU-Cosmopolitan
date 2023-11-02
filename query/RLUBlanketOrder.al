query 50101 "RLU Blanket Order"
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
            column(No_; "No.")
            {

            }
            column(Blanket_Order_No_; "Blanket Order No.")
            {

            }
            column(Type; Type)
            {

            }

            column(RLU_MKC_Lot_No; "RLU MKC Lot No")
            {

            }


            column(Pallet_Quantity; "Pallet Quantity")
            {

            }


            column(RLU_SMPT_Lot_No; "RLU SMPT Lot No")
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