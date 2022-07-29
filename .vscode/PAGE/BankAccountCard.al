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

        addafter("Payment Export Format")
        {
            field("Transit G/L account"; "Transit G/L account")
            {
                ApplicationArea = All;
            }
        }

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
                    IzvjestajPortoBlagajne.SetParam(1);
                    IzvjestajPortoBlagajne.Run();
                end;
            }

            action("POS terminali - dnevni izvještaj")
            {
                Caption = 'POS terminali - dnevni izvještaj';
                Image = CreditCard;
                Promoted = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    GLEntry.Reset();
                    GLEntry.SetFilter("Bal. Account No.", Rec."No.");
                    IzvjestajPortoBlagajne.SetTableView(GLEntry);
                    IzvjestajPortoBlagajne.SetParam(2);
                    IzvjestajPortoBlagajne.Run();
                end;
            }

            action("Specifikacija karticnog placanja")
            {
                Caption = 'Specifikacija karticnog placanja';
                Image = CreditCard;
                Promoted = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    BankAccount.Reset();
                    BankAccount.SetFilter("No.", '%1', 'CZK*');
                    SpecifikacijaKarticnog.SetTableView(BankAccount);
                    SpecifikacijaKarticnog.Run();
                end;
            }

            action("Rekapitulacija uplata/isplata")
            {
                Caption = 'Rekapitulacija uplata/isplata';
                Image = PostedPayableVoucher;
                Promoted = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    /*BankAccount.Reset();
                    BankAccount.SetFilter("No.", '%1', 'CZK*');*/
                    //RekapitulacijaUplataIsplata.SetTableView(BankAccount);
                    RekapitulacijaUplataIsplata.Run();
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
        BankAccount: Record "Bank Account";
        GLEntry: Record "G/L Entry";
        IzvjestajPortoBlagajne: Report "Izvještaj";
        BlagajnickiDnevnik: Report "Blagajnički dnevnik";
        SpecifikacijaKarticnog: Report "Spec karticnog plaćanja";
        RekapitulacijaUplataIsplata: Report "Rekapitulacija uplata/isplata";
}