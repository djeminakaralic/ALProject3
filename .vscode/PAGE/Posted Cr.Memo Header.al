pageextension 50995 "Posted Sales Cr Memo" extends "Posted Sales Credit Memo"
{
    layout
    {
        // Add changes to page layout here
        addafter("Document Date")
        {
            field("VAT Date"; "VAT Date")
            {

            }
            field("Shipment Date"; "Shipment Date")
            {

            }
            field("Fiscal No. Printed"; "Fiscal No. Printed")
            {

            }
            field("Fiscal No."; "Fiscal No.")
            {

            }
            field("Fiscal DateTime"; "Fiscal DateTime")
            {

            }
            field("Fiscal User"; "Fiscal User")
            {

            }

        }
        addafter("Salesperson Code")
        {
            field("Bal. Account No."; "Bal. Account No.")
            {

            }
        }

    }

    actions
    {
        // Add changes to page actions here
        addafter(Print)
        {
            action("Fiscal print")

            {
                Caption = 'Order Confirmation Cr. Memo';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    //ReportRun.SetParam(Rec."No.", FALSE);
                    Report.Run(40128, true, true, Rec);
                end;
            }


            action("Fiscal print srr")

            {
                Caption = 'Fiscal print srr';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CU.SetParam(rec."No.", true);
                    CU.Run();


                end;
            }

        }

    }
    var
        myInt: Integer;
        ReportRun: Report "Posted Sales - Credit Memo";
        CU: Codeunit FiscalPrinter;
}