pageextension 50107 UserSetup extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Allow Posting To")
        {
            field("Wage Allowed"; "Wage Allowed")
            {

                Caption = 'Wage Allowed';
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