pageextension 50070 AbsenceRegistration extends "Absence Registration"

{


    layout
    {
        addafter(Quantity)
        {
            field("Vacation from Year"; "Vacation from Year")
            {
                Visible = false;
                ApplicationArea = all;


            }
        }
    }



    var
        myInt: Integer;
}