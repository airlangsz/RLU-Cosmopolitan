pageextension 50132 RLUBankAccount extends "Bank Account List"
{
    layout
    {

    }
    actions
    {
        addafter("Trial Balance")
        {
            action(DirectCashflow)
            {
                ToolTip = 'Direct Cashflow';
                Caption = 'Direct Cashflow';
                Image = Report;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                var
                    RLUDirectCashFlow: Report RLUDirectCashFlow;
                begin
                    RLUDirectCashFlow.Run();
                end;
            }
        }
    }
}