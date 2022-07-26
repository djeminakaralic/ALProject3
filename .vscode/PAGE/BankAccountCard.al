pageextension 50127 BankAccountCard extends "Bank Account Card"
{

    //ED

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

        modify("No.")
        {
            Visible = true;
            Editable = true;
        }
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

            action("POS terminali - dnevni izvještaj")
            {
                Caption = 'POS terminali - dnevni izvještaj';
                Image = Journal;
                Promoted = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    GLEntry.Reset();
                    GLEntry.SetFilter("Bal. Account No.", Rec."No.");
                    POSDnevniIzvjestaj.SetTableView(GLEntry);
                    POSDnevniIzvjestaj.Run();
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
                    BlagajnickiDnevnik.SetTableView(GLEntry);
                    BlagajnickiDnevnik.Run();
                end;
            }


        }

    }

    var
        GLEntry: Record "G/L Entry";
        IzvjestajPortoBlagajne: Report "Izvještaj porto blagajne";
        BlagajnickiDnevnik: Report "Blagajnički dnevnik";
        POSDnevniIzvjestaj: Report "POS dnevni izvjestaj";
}