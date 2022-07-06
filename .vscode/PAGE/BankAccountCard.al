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
        addafter(List)
        {
            action("Izvještaj porto blagajne")
            {
                Caption = 'Izvještaj porto blagajne';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Izvještaj porto blagajne";

                trigger OnAction()
                begin
                    GLEntry.SetFilter("Journal Batch Name", '%1', "No.");
                end;
            }

            action("Cash Diary")
            {
                Caption = 'Cash Diary';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Blagajnički dnevnik";
            }


            action("Zapisnik o primopredaji UniCredit")
            {
                Caption = 'Zapisnik o primopredaji UniCredit';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Zapisnik o primopredaji";
            }
        }

    }



    var
        GLEntry: Record "G/L Entry";
}