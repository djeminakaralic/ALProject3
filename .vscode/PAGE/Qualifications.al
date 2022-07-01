pageextension 50128 Qualifications extends Qualifications
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = all;
            }
        }
        modify(Description)
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