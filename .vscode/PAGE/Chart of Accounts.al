pageextension 50120 MyExtensionChart extends "Chart of Accounts"
{
    layout
    {
        // Add changes to page layout here
        addafter(Balance)
        {
            field("Budgeted Amount"; "Budgeted Amount")
            {
                ApplicationArea = All;
            }
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        modify("Cost Type No.")
        {
            Visible = false;
        }
    }

    actions
    {


    }


    var
        myInt: Integer;
}