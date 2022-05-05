codeunit 50111 TestSubsCu
{

    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', true, true)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")

    begin
        GenJournalLine."Note 1" := SalesHeader."Note 1";
        GenJournalLine."VAT Date" := SalesHeader."VAT Date";
    end;

    [EventSubscriber(ObjectType::Table, database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', true, true)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")

    begin
        CustLedgerEntry."Bin Checked" := GenJournalLine."Bin Checked";
        CustLedgerEntry."VAT Date" := GenJournalLine."VAT Date";

    end;

    [EventSubscriber(ObjectType::Table, database::"VAT Entry", 'OnAfterCopyFromGenJnlLine', '', true, true)]
    local procedure OnAfterCopyFromGenJnlLine(var VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line")

    begin
        VATEntry."VAT Date" := GenJournalLine."VAT Date";

    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromPurchHeader', '', true, true)]
    local procedure OnAfterCopyGenJnlLineFromPurchHeader(PurchaseHeader: Record "Purchase Header"; var GenJournalLine: Record "Gen. Journal Line")

    begin
        // GenJournalLine."Bin Checked" := SalesHeader."Bin Checked";
        GenJournalLine."VAT Date" := PurchaseHeader."VAT Date";
    end;
}
