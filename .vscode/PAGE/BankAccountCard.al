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
                /*PromotedCategory = Process;
                PromotedIsBig = true;*/
                ApplicationArea = all;

                //RunObject = Report "Izvještaj porto blagajne";

                trigger OnAction()
                begin
                    GLEntry.Reset();
                    GLEntry.SetFilter("Bal. Account No.", Rec."No.");
                    IzvjestajPortoBlagajne.SetTableView(GLEntry);
                    IzvjestajPortoBlagajne.Run();
                end;
            }

            action("Cash Diary")
            {
                Caption = 'Cash Diary';
                Image = Journal;
                Promoted = true;

                //RunObject = Report "Blagajnički dnevnik";

                trigger OnAction()
                begin
                    GLEntry.Reset();
                    GLEntry.SetFilter("Bal. Account No.", Rec."No.");
                    IzvjestajPortoBlagajne.SetTableView(GLEntry);
                    IzvjestajPortoBlagajne.Run();
                end;
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
        IzvjestajPortoBlagajne: Report "Izvještaj porto blagajne";
}