pageextension 50121 BaseChalendarChange extends "Base Calendar Changes"
{
    //#BasicHR


    layout
    {
        // Add changes to page layout here
        addafter(Nonworking)
        {
            field("Paid Holiday"; "Paid Holiday")
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