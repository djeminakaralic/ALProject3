pageextension 50122 GeneralLedgerEntriesExtension extends "General Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("Source No."; "Source No.")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {

        addafter("Value Entries")
        {

            action("Print")
            {
                Caption = 'Print';
                Image = ValueLedger;

                RunObject = report "Print of journal entries";

                //  RunObject = report "";
            } // Add changes to page actions here
        }
        addafter("DocsWithoutIC")
        {


            action("Incoming Document")
            {

                Caption = 'Incoming Document';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;

                RunObject = report "Print of journal entries";

                trigger OnAction()
                var
                    IncomingDocument: Record "Incoming Document";
                begin
                    //ĐK   IncomingDocument.HyperlinkToDocument("Document No.", "Posting Date");
                end;
                //  RunObject = report "";
            } // Add changes to page actions here
        }

    }



    var
        myInt: Integer;
        IncomingDocument: Record "Incoming Document";

}