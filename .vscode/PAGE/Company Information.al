pageextension 50020 MyExtensionComp extends "Company Information"
{
    layout
    {
        addafter("Country/Region Code")
        {
            field("Municipality Code"; "Municipality Code")
            {
                ApplicationArea = all;
            }
            field("Municipality Name"; "Municipality Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        // Add changes to page layout here
        addafter(County)
        {
            field("Entity Code"; "Entity Code")
            {
                ApplicationArea = all;
            }
        }
        addafter("Phone No.")
        {
            field("Registration No."; "Registration No.")
            {
                ApplicationArea = all;
            }
            field("Tax No."; "Tax No.")
            {
                ApplicationArea = all;
            }

        }
        addafter(GLN)
        {

            field(MBS; MBS)
            {
                ApplicationArea = all;
            }
        }
        addafter("Home Page")
        {
            field("Operater No"; "Operater No")
            {
                ApplicationArea = all;
            }
            field("Operater E-mail"; "Operater E-mail")
            {
                ApplicationArea = all;
            }
            field("Prefix for JS"; "Prefix for JS")
            {
                ApplicationArea = all;
            }
            field("Ekstenzija za e-mail"; "Ekstenzija za e-mail")
            {
                ApplicationArea = all;
            }
        }
        addafter("Bank Name")
        {
            field("Bank No. 1"; "Bank No. 1")
            {
                ApplicationArea = all;
            }
        }
        moveafter("Phone No."; "Fax No.")
        modify("Use GLN in Electronic Document")
        {
            Visible = false;
        }
        moveafter(Picture; "Industrial Classification")

        modify("Industrial Classification")
        {

            ApplicationArea = all;
        }
        modify("Auto. Send Transactions")
        {
            Visible = false;
        }
        modify("System Indicator")
        {
            Visible = false;
        }
        modify("User Experience")
        {
            Visible = false;
        }





    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}