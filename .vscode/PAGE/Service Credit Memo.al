pageextension 50140 ServiceCreditMemo extends "Service Credit Memo"
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
    }
}
