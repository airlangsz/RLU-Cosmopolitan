codeunit 50102 "RLU Account Schedule"
{
    Permissions = tabledata "G/L Entry" = RIM;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::AccSchedManagement, 'OnAfterSetGLAccGLEntryFilters', '', false, false)]
    local procedure HandleFilterGLEntry(var GLAccount: Record "G/L Account"; var GLEntry: Record "G/L Entry"; var AccSchedLine: Record "Acc. Schedule Line"; var ColumnLayout: Record "Column Layout"; UseBusUnitFilter: Boolean; UseDimFilter: Boolean)
    begin
        if ColumnLayout."Journal Batch Name" <> '' then
            GLEntry.SetRange("Journal Batch Name", ColumnLayout."Journal Batch Name");
        if ColumnLayout.TypeAudit <> 0 then
            GLEntry.SetRange(TypeAudit, ColumnLayout.TypeAudit);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::AccSchedManagement, 'OnAfterSetGLAccGLBudgetEntryFilters', '', false, false)]
    local procedure HandleFilterGLBudgetEntry(var GLAcc: Record "G/L Account"; var GLBudgetEntry: Record "G/L Budget Entry"; var AccSchedLine: Record "Acc. Schedule Line"; var ColumnLayout: Record "Column Layout"; UseBusUnitFilter: Boolean; UseDimFilter: Boolean)
    begin
        if ColumnLayout."Budget Name" <> '' then
            GLBudgetEntry.SetRange("Budget Name", ColumnLayout."Budget Name");
    end;

    procedure UpdateAuditType(DocNo: Code[20]; AccNo: Code[20]; var GLEntry: Record "G/L Entry")
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.SetRange("Document No.", DocNo);
        GenJournalLine.SetRange("Account No.", AccNo);
        if not GenJournalLine.IsEmpty then begin
            GLEntry.Validate(TypeAudit, GenJournalLine.TypeAudit);
            GLEntry.Modify();
        end
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", 'OnAfterPostGenJnlLine', '', false, false)]
    local procedure OnAfterPostGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; CommitIsSuppressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; IsPosted: Boolean; var PostingGenJournalLine: Record "Gen. Journal Line")
    var
        GLEntry: Record "G/L Entry";
        GLEntry1: Record "G/L Entry";
    begin
        GLEntry.SetRange("Document No.", GenJournalLine."Document No.");
        if GLEntry.FindSet() then begin
            repeat
            until GLEntry.Next() = 0;
            GLEntry.TypeAudit := GenJournalLine.TypeAudit;
            GLEntry.Modify();

            GLEntry1.SetRange("Document No.", GLEntry."Document No.");
            GLEntry1.SetRange("Transaction No.", GLEntry."Transaction No.");
            if GLEntry1.FindSet() then
                repeat
                    GLEntry1.TypeAudit := GenJournalLine.TypeAudit;
                    GLEntry1.Modify();
                until GLEntry1.Next() = 0;
        end;


    end;
}