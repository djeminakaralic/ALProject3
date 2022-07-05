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
        //GLEntry."Payment Type Code" := GenJournalLine."Payment Type"; 

        GLEntry."Test Event" := 'Elmira test knjizenje'; //izbrisati

        //ED

        // //   GLEntry.vat:= GenJournalLine."VAT Date";

    end;


    [EventSubscriber(ObjectType::Table, 254, 'OnAfterCopyFromGenJnlLine', '', true, true)]
    procedure Testiram(VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line")
    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)



    var
        myInt: Integer;
        VATEntry2: Record "VAT Entry";

    begin


    end;





}
