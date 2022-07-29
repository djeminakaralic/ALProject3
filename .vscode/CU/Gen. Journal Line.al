codeunit 50139 GenJNLLine
{


    EventSubscriberInstance = StaticAutomatic;
    [EventSubscriber(ObjectType::Table, 81, 'OnAfterCopyGenJnlLineFromSalesHeader', '', true, true)]
    procedure OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; GenJournalLine: Record "Gen. Journal Line")
    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)

    var
        myInt: Integer;
        VATEntry2: Record "VAT Entry";
    begin
    end;



    [EventSubscriber(ObjectType::Table, 17, 'OnAfterCopyGLEntryFromGenJnlLine', '', true, true)]
    procedure OnAfterCopyGLEntryFromGenJnlLine(GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)

    var
        myInt: Integer;
        VATEntry2: Record "VAT Entry";

    begin

        GLEntry."Payment Type Code" := GenJournalLine."Payment Type";
        GLEntry."Payment Method" := FORMAT(GenJournalLine."Payment Method");
        GLEntry."Cashier Code" := GenJournalLine."Cashier Employer"; //sifra blagajnika

    end;

    //12

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', true, true)]
    local procedure OnAfterInitGLEntry(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")

    begin
        //   VATEntry."VAT Date" := GenJournalLine."VAT Date";
        GLEntry."Payment Type Code" := GenJournalLine."Payment Type";
        GLEntry."Payment Method" := FORMAT(GenJournalLine."Payment Method");
        GLEntry."Cashier Code" := GenJournalLine."Cashier Employer"; //sifra blagajnika

    end;

    //OnAfterInitGLEntry(GLEntry, GenJnlLine);


    [EventSubscriber(ObjectType::Table, 254, 'OnAfterCopyFromGenJnlLine', '', true, true)]
    procedure Testiram(VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line")
    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)

    var
        myInt: Integer;
        VATEntry2: Record "VAT Entry";

    begin
    end;

}
