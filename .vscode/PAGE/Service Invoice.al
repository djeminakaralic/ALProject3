pageextension 50136 ServiceInvoice extends "Service Invoice"
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
