pageextension 50172 Country_Region extends "Countries/Regions"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field("Country Code"; "Country Code")
            {
                ApplicationArea = all;
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