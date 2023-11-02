pageextension 50112 "RLU Sales Order Card" extends "Sales Order"
{
    layout
    {
        addafter("Package Tracking No.")
        {
            field("RLU Place of Delivery"; Rec."RLU Place of Delivery")
            {
                ApplicationArea = All;
                ToolTip = 'Place of Delivery';
            }
            field("RLU Via"; Rec."RLU Via")
            {
                ApplicationArea = All;
                ToolTip = 'Via';
            }
            field("RLU Port of Discharge"; Rec."RLU Port of Discharge")
            {
                ApplicationArea = All;
                ToolTip = 'Port of Discharge';
            }
            field("RLU Vessel/Voyage"; Rec."RLU Vessel/Voyage")
            {
                ApplicationArea = All;
                ToolTip = 'Vessel/Voyage';
            }
            field("RLU BKG Ref"; Rec."RLU BKG Ref")
            {
                ApplicationArea = All;
                ToolTip = 'BKG Ref';
            }
            field("RLU Notify"; Rec."RLU Notify")
            {
                ApplicationArea = All;
                ToolTip = 'Notify to';
            }
            field("RLU Service Contract"; Rec."RLU Service Contract")
            {
                ApplicationArea = All;
                ToolTip = 'Service Contract';
            }
            field("RLU Stuffing Plan"; Rec."RLU Stuffing Plan")
            {
                ApplicationArea = All;
                ToolTip = 'Stuffing Plan';
            }
            field("RLU Feeder"; Rec."RLU Feeder")
            {
                ApplicationArea = All;
                ToolTip = 'Feeder';
            }
            field("RLU Country of Origin"; Rec."RLU Country of Origin")
            {
                ApplicationArea = All;
                ToolTip = 'Country of Origin';
            }
        }
    }
    actions
    {
        addlast(Reporting)
        {
            action("Shipping Instruction")
            {
                Promoted = true;
                PromotedCategory = Report;
                Image = PrintReport;
                ApplicationArea = all;
                Caption = 'Shipping Instruction';
                ToolTip = 'Shipping Instruction';
                trigger OnAction()
                begin
                    RLUShippingInstruction.SetParm(Rec."No.");
                    RLUShippingInstruction.run();
                end;
            }
            action("General Invoice")
            {
                Promoted = true;
                PromotedCategory = Report;
                Image = PrintReport;
                ApplicationArea = all;
                Caption = 'General Invoice';
                ToolTip = 'General Invoice';
                trigger OnAction()
                begin
                    RLUGeneralInvoice.SetParm(Rec."No.");
                    RLUGeneralInvoice.run();
                end;
            }
            action(CommercialInvoice)
            {
                Promoted = true;
                PromotedCategory = Report;
                Image = PrintReport;
                ApplicationArea = all;
                ToolTip = 'Commercial Invoice';
                Caption = 'Commercial Invoice';

                trigger OnAction()
                begin
                    RLUCommercialInvoice.setparm(Rec."No.");
                    RLUCommercialInvoice.Run();
                end;
            }
        }
    }
    var
        RLUShippingInstruction: Report "RLU Shipping Instruction";
        RLUGeneralInvoice: Report "RLU General Invoice";
        RLUCommercialInvoice: Report "RLU Commercial Invoice";
}