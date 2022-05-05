pageextension 50111 GeneralJournal extends "General Journal"
{
    layout
    {
        // Add changes to page layout here
        modify("Document Type")
        {
            Visible = false;
        }
        modify("Account Name")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }

        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Amount (LCY)")
        {
            Visible = false;
        }
        modify("Bal. Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Deferral Code")
        {
            Visible = false;
        }
        modify("Salespers./Purch. Code")
        {
            Visible = false;
        }
        modify("Business Unit Code")
        {
            Visible = false;
        }

        modify(AccName)
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }




        addafter("Posting Date")
        {
            field("Line No."; "Line No.")
            {

            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("B&ank")
        {

            action("Bank Statement")
            {
                Caption = 'Import/Export Bank Statement';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;


                RunObject = report "Read bank statement";

                //  RunObject = report "";
            } // Add changes to 
        }
    }

    var
        myInt: Integer;
}