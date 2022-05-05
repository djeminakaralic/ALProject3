pageextension 50090 SalesInvoice extends "Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter("Document Date")
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