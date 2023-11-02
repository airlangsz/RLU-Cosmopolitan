tableextension 50118 RLUBankAccountLedgerEntry extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50100; "CF Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "RLU Cash Flow"."CF Code";
        }
    }
}