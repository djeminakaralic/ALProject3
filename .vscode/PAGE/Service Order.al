pageextension 50139 ServiceOrder extends "Service Order"
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
