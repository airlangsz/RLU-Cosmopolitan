pageextension 50116 "RLU Warehouse Shippment" extends "Warehouse Shipment List"
{
    layout
    {
    }
    actions
    {
        addafter("Re&lease")
        {
            action("Report")
            {
                Caption = 'Laboratory Certificate Of Quality';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                Image = Report;
                ToolTip = 'Report';
                trigger OnAction()
                var
                    WarehouseShipment: Record "Warehouse Shipment Header";
                    labor: Report "RLU Laboratory Of Quality";
                begin
                    WarehouseShipment := Rec;
                    CurrPage.SetSelectionFilter(WarehouseShipment);
                    labor.SetParm(WarehouseShipment."No.");
                    labor.Run();
                end;
            }
        }
    }

}