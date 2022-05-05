pageextension 50001 PurchaseCreditMemo extends "Purchase Credit Memo"
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