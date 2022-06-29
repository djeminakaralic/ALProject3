pageextension 50127 BankAccountCard extends "Bank Account Card"
{
    layout
    {
        // Add changes to page layout here
        /*addafter(Description)
        {
            field("Source No."; "Source No.")
            {
                ApplicationArea = All;
            }
        }*/
    }

    actions
    {

        /*addafter("Value Entries")
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
        }*/
        addafter(List)
        {

            action("Cash Diary")
            {
                Caption = 'Cash Diary';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Blagajnički dnevnik";
            }
        }

    }



    var
        myInt: Integer;
        IncomingDocument: Record "Incoming Document";

}