pageextension 50147 JournalLineDetailsFactBox extends "Journal Line Details FactBox"
{
    layout
    {
        modify(PostingGroup)
        {
            Visible = false;
        }
        modify(GenPostingSetup)
        {
            Visible = false;
        }
        modify(VATPostingSetup)
        {
            Visible = false;
        }
        modify(BalAccount)
        {
            Visible = false;
        }
        //modify()
        addafter(AccountName)
        {
            field("Posting Group"; "Posting Group")
            {

            }
        }
        // Add changes to page layout here
        /*addafter("VAT Registration No.")
        {
            field("Registration No."; "Registration No.")
            {

            }
        }
        addafter("E-Mail")
        {
            field("Message Code"; "Message Code")
            {

            }
            field("Poruka test"; "Poruka test")
            {

            }
        }
        addafter(Payments)
        {
            field("Social status category"; "Social status category")
            {

            }
            group("CR")
            {
                field(Orderer; Orderer)
                {

                }
                field("Contract Number"; "Contract Number")
                {

                }
                field("Order person"; "Order person")
                {

                }
                field("Responsible Person"; "Responsible Person")
                {

                }
                field("Responsible Person Infodom"; "Responsible Person Infodom")
                {

                }
                field(Designer; Designer)
                {

                }
                field("Project manager"; "Project manager")
                {

                }
            }
        }*/
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}