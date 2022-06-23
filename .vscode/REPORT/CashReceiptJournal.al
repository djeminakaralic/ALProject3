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
            }
            field("No. Line"; "No. Line")
            {
                ApplicationArea = all;
            }

        }
        addafter("No. Line")
        {
            field("Payment Type"; "Payment Type")
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

            }
            field("To return"; "To return")
            {

            }
            /*field("Payment Type"; "Payment Type")
            {

            }*/
        }




        /*addafter(Code)
        {

            group("CIPS Address")
            {
                Caption = 'CIPS Address';
                Editable = VisibleCIPS;
                Visible = VisibleCIPS;
                field("Address CIPS"; "Address CIPS")
                {
                    Enabled = true;
                    Visible = true;
                    ApplicationArea = all;
                }
                field("Municipality Code CIPS"; "Municipality Code CIPS")
                {
                    ApplicationArea = all;
                }
                
            }
           
            }

        }*/

    }

    actions
    {


        addafter(Card)
        {

            action("Payment Slip")
            {
                Caption = 'Payment Slip';
                Image = Journal;
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
        GJline: Record "Gen. Journal Line";
        Customer: Record Customer;


    /*trigger OnOpenPage()
    begin
        

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin


    end;*/

}