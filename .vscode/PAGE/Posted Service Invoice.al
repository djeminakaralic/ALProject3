pageextension 50142 PostedServiceInvoice extends "Posted Service Invoice"
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
}
