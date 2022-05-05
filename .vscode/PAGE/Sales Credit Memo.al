pageextension 50996 "Sales Credit Memo" extends "Sales Credit Memo"
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
        addafter("Salesperson Code")
        {
            field("Bal. Account No."; "Bal. Account No.")
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