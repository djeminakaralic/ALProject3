pageextension 50994 "PostedPurchaseInvoice" extends "Posted Purchase Invoice"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter(Print)
        {
            action("Posted Purchase Order confirmation")
            {
                Caption = 'Posted Purchase invoice Order confirmation action';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;


                trigger OnAction()
                begin
                    Report.RunModal(4443, true, true, Rec);
                end;
            }

        }
    }

    var
        myInt: Integer;
}