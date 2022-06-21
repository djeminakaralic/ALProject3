pageextension 50170 CashReceiptJournal extends "Cash Receipt Journal"
{
    layout
    {
        // Add changes to page layout here
        /*modify(Code)
        {
            Visible = false;
        }
        Modify("Country/Region Code")
        {
            Editable = false;
        }
        modify(Name)
        {
            Visible = false;
        }
        modify("Address 2")
        {
            Visible = false;
        }
        modify("Phone No.")
        {
            Visible = false;
        }
        modify(Communication)
        {
            Visible = false;
        }*/



        addafter("Posting Date")
        {
            field("Payment Date And Time"; "Payment Date And Time")
            {
                ApplicationArea = all;
            }
            field("Redni broj"; "Redni broj")
            {

            }


            field("Social status"; "Social status")
            {

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
                field("Date From (CIPS)"; "Date From (CIPS)")
                {
                    ApplicationArea = all;
                }
                field("Date To (CIPS)"; "Date To (CIPS)")
                {
                    ApplicationArea = all;
                }
                field("Municipality Name CIPS"; "Municipality Name CIPS")
                {
                    Enabled = true;
                    ApplicationArea = all;
                }
                field("Place Of Living"; "Place Of Living")
                {
                    ApplicationArea = all;
                }

                field("City CIPS"; "City CIPS")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Post Code CIPS"; "Post Code CIPS")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("County Code CIPS"; "County Code CIPS")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("County CIPS"; "County CIPS")
                {
                    ApplicationArea = all;
                }
                field("Entity Code CIPS"; "Entity Code CIPS")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Country/Region Code CIPS"; "Country/Region Code CIPS")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
            }
            group("Current Address")
            {
                Caption = 'Current Address';
                Editable = true;
                field(Active; Active)
                {
                    ApplicationArea = all;
                }

                field("Municipality Code"; "Municipality Code")
                {
                    ApplicationArea = all;
                }
                field("Date From"; "Date From")
                {
                    ApplicationArea = all;
                }
                field("Date To"; "Date To")
                {
                    ApplicationArea = all;
                }
                field("Municipality Name"; "Municipality Name")
                {
                    ApplicationArea = all;
                }


                field("County Code"; "County Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Entity Code"; "Entity Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

            }


        }*/


        /*moveafter(Active; Address)
        moveafter("Municipality Name"; City)
        modify(City)
        {
            Editable = false;
            ApplicationArea = all;
        }
        moveafter(City; "Post Code")
        modify("Post Code")
        {
            Editable = false;
            ApplicationArea = all;
        }
        moveafter("County Code"; County)*/


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

            action("Payroll")
            {
                Caption = 'Payroll';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Isplatnica";
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