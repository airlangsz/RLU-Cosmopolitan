codeunit 50104 "RLU Cash Flow"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnPostBankAccOnBeforeBankAccLedgEntryInsert, '', false, false)]
    local procedure OnCodeOnAfterGenJnlPostBatchRun_Ext(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; BankAccount: Record "Bank Account"; var TempGLEntryBuf: Record "G/L Entry" temporary; var NextTransactionNo: Integer; GLRegister: Record "G/L Register")
    begin
        BankAccountLedgerEntry."CF Code" := GenJournalLine."CF Code";
    end;
}