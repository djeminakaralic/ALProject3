pageextension 50052 Absence extends "Employee Absences"

{


    layout
    {
        addafter(Quantity)
        {
            field("Vacation from Year"; "Vacation from Year")
            {
                Visible = true;
                ApplicationArea = all;

            }
        }
    }



    var
        myInt: Integer;
}