pageextension 50118 CauseOfAbsence extends "Causes of Absence"
{
    layout
    {

        addbefore(Code)
        {
            field("Short Code"; "Short Code")
            {

            }
        }
        // Add changes to page layout here
        addafter("Unit of Measure Code")
        {
            field("No Report"; "No Report")
            {
                Visible = false;

            }
            field(Coefficient; Coefficient)
            {

            }
            field("Calculated Sick Leave"; "Calculated Sick Leave")
            {

            }
            field("Sick Leave"; "Sick Leave")
            {


            }
            field("Sick Leave Paid By Company"; "Sick Leave Paid By Company")
            {

            }
            field("Work Experience Basis"; "Work Experience Basis")
            {
                Visible = false;

            }
            field("Added To Hour Pool"; "Added To Hour Pool")
            {

            }

            field(Vacation; Vacation)
            {

            }
            field(Holiday; Holiday)
            { }

            field("Bussiness trip"; "Bussiness trip")
            {
                Visible = false;

            }
            field("Insurance Basis"; "Insurance Basis")
            {
                Visible = false;

            }
            field("Work Abroad"; "Work Abroad")
            {

                Visible = false;
            }
            field("Calculation Type"; "Calculation Type")
            {

            }
            field("Payment Type"; "Payment Type")
            { }
            field(Order; Order) { ApplicationArea = all; }
            field("Meal Calculated"; "Meal Calculated")
            {

            }
            field("Meal - Half Day Calculated"; "Meal - Half Day Calculated")
            {

            }

            field("Description 2"; "Description 2")
            {
                Visible = false;

            }

            field("Posting Group"; "Posting Group")
            {
                ApplicationArea = all;

            }
            field("G/L Account No."; "G/L Account No.")
            {
                ApplicationArea = all;


            }
            field("G/L Balance Account No."; "G/L Balance Account No.")
            {
                ApplicationArea = all;
            }
        }
        modify("Total Absence (Base)")
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