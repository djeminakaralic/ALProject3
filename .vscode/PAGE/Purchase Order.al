pageextension 50146 PurchaseOrder extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
        addafter("Posting Date")
        {
            field("VAT Date"; "VAT Date")
            {

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}