pageextension 50170 CashReceiptJournal extends "Cash Receipt Journal"
{
    //ED
    layout
    {
        // Add changes to page layout here

        addafter("Posting Date")
        {
            field("Payment DT"; "Payment DT")
            {
                ApplicationArea = all;





                // FORMAT("Payment DT", 0, '<Day,2>.<Month,2>.<Year4>.');

            }

            field("Payment Type"; "Payment Type")
            {
                ApplicationArea = all;
            }
            field("Payment Method"; "Payment Method")
            {
                ApplicationArea = all;
            }
        }
        addafter(Description)
        {
            field("Social status"; "Social status")
            {
                ApplicationArea = all;
            }
        }

        addafter("Amount (LCY)")
        {
            field("Given amount"; "Given amount")
            {
                ApplicationArea = all;
            }
            field("To return"; "To return")
            {
                ApplicationArea = all;
            }
        }
        modify("Applied (Yes/No)")
        {
            Visible = false;
        }
        modify("Posting Date")
        {
            trigger OnAfterValidate()
            begin
                //"Posting Date" := FORMAT(rec."Posting Date", 0, '<Day,2>.<Month,2>.<Year4>.');

            end;
        }
        //moveafter("Social status"; "Applies-to Doc. Type");

    }

    actions
    {
        addafter(Card)
        {

            action("Payment Slip")
            {
                Caption = 'Payment Slip';
                Image = PostedPayableVoucher;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(GJline);
                    Report.RunModal(50077, true, false, GJline);
                end;

                //RunObject = Report "Uplatnica";
            }

            /*action("Payroll")
            {
                Caption = 'Payroll';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Isplatnica";
            }*/

            action("Izvještaj porto blagajne")
            {
                Caption = 'Izvještaj porto blagajne';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Izvještaj porto blagajne";
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Validate(Rec."Applies-to Doc. Type", "Applies-to Doc. Type"::Invoice);
        "Payment DT" := System.CurrentDateTime;
    end;

    var
        GJline: Record "Gen. Journal Line";
        CLEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        Text000: Label 'Today is %1';
}