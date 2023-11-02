pageextension 50128 RLUBankAccountLedgerEntries extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("CF Code"; Rec."CF Code")
            {
                ApplicationArea = All;
                Caption = 'CF Code';
                ToolTip = 'CF Code';
            }
        }
    }
}