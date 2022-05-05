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
    }

    actions
    {

        addafter("General Journal")
        {

            action("Recurring General Journal")
            {
                Caption = 'Recurring General Journal';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Recurring General Journal";
            } // Add changes to page actions here
        }
    }


    var
        myInt: Integer;
}