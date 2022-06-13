pageextension 50145 CustomerCard extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("VAT Registration No.")
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
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}