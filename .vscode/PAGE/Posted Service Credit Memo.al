pageextension 50141 PostedServiceCreditMemo extends "Posted Service Credit Memo"
{
    layout
    {
        // Add changes to page layout here
        addafter("Document Date")
        {

            field("VAT Date"; "VAT Date")
            {
                ApplicationArea = All;
            }

        }
        addafter("No. Printed")
        {
            field("Fiscal No."; "Fiscal No.")
            {
                ApplicationArea = All;
            }
            field("Fiscal No. Printed"; "Fiscal No. Printed")
            {

            }

            field("Fiscal User"; "Fiscal User")
            {
                ApplicationArea = All;
            }

            field("Fiscal DateTime"; "Fiscal DateTime")
            {
                ApplicationArea = All;
            }

        }
    }
    actions
    {
        addafter(ActivityLog)
        {
            action(FiscalPrint)
            {
                Caption = 'FiscalPrint';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Reklamnixml.SetParam(Rec."No.", TRUE);
                    Reklamnixml.RUN;
                end;
            }
        }

    }
    var
        Reklamnixml: Codeunit FiscalPrinter;
}
