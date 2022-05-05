codeunit 50138 SalesPost
{




    EventSubscriberInstance = StaticAutomatic;
    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeInsertICGenJnlLine', '', true, true)]
    procedure OnBeforeInsertICGenJnlLine(ICGenJournalLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header")
    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)



    var
        myInt: Integer;
        VATEntry2: Record "VAT Entry";
        GenJnlLine: Record "Gen. Journal Line";

    begin

        ICGenJournalLine."VAT Date" := SalesHeader."VAT Date";

    end;


    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostCustomerEntry', '', true, true)]
    procedure OnBeforePostCustomerEntry(GenJnlLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header")
    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)



    var
        myInt: Integer;
        VATEntry2: Record "VAT Entry";

    begin

        GenJnlLine."VAT Date" := SalesHeader."VAT Date";

    end;
}