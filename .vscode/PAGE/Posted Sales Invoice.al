pageextension 50101 PostedSalesInvoice extends "Posted Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter("No. Printed")
        {
            field("Language Code"; "Language Code")
            {
                Caption = 'Language Code for print';
            }
        }
        addafter(Closed)
        {
            field("Fiscal No."; "Fiscal No.")
            {

            }
            field("Fiscal No. Printed"; "Fiscal No. Printed")
            {

            }
            field("Fiscal DateTime"; "Fiscal DateTime")
            {

            }
            field("Fiscal User"; "Fiscal User")
            {

            }
            field("Note 1"; "Note 1")
            {

            }
            field("Note 2"; "Note 2")
            {

            }
            field("Note 3"; "Note 3")
            {

            }
            field("Bank No."; "Bank No.")
            {

            }

        }
    }

    actions
    {

        addafter(Print)
        {
            action("Fiscal print")

            {
                Caption = 'Fiscal print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Fiskalniprinter2.SetParam(Rec."No.", FALSE);
                    Fiskalniprinter2.RUN;
                end;
            }
            action("Posted Order confirmation")
            {
                Caption = 'Posted Order confirmation action';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;


                trigger OnAction()
                begin
                    SalesInvoiceHeader.Reset();
                    SalesInvoiceHeader.SetRange("No.", "No.");
                    Report.RunModal(50139, true, true, SalesInvoiceHeader);
                end;
            }
        }


    }

    var
        myInt: Integer;
        Fiskalniprinter2: Codeunit FiscalPrinter;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        PostedOrderConf: Report "Posted Order Confirmation";
}