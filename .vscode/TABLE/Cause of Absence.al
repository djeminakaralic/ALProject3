tableextension 50146 CauseOfAbsence extends "Cause of Absence"
{
    fields
    {
        field(50000; "No Report"; Boolean)
        {
            Caption = 'No Report';
        }
        field(50001; Coefficient; Decimal)
        {
            Caption = 'Coefficient';
        }
        field(50002; "Calculated Sick Leave"; Boolean)
        {
            Caption = 'Calculated Sick Leave';
        }
        field(50003; "Work Experience Basis"; Boolean)
        {
            Caption = 'Work Experience Basis';
        }
        field(50004; "Added To Hour Pool"; Boolean)
        {
            Caption = 'Added To Hour Pool';
        }
        field(50005; "Sick Leave"; Boolean)
        {
            Caption = 'Sick Leave';
        }
        field(50006; "Sick Leave Paid By Company"; Boolean)
        {
            Caption = 'Sick Leave Paid By Company';
        }
        field(50007; Vacation; Boolean)
        {
            Caption = 'Vacation';
        }
        field(50016; "Bussiness trip"; Boolean)
        {
            Caption = 'Business trip';
        }
        field(50008; "Insurance Basis"; Code[2])
        {
            Caption = 'Insurance Basis';
        }
        field(50009; "Work Abroad"; Boolean)
        {
            Caption = 'Work Abroad';
        }
        field(50010; "Calculation Type"; Option)
        {
            Caption = 'Calculation Type';
            OptionCaption = 'Standard,Other,Sick,Paid Absence,Unpaid Absence';
            OptionMembers = Standard,Other,Sick,"Paid Absence","Unpaid Absence";
        }
        field(50011; "Meal Calculated"; Boolean)
        {
            Caption = 'Meal Calculated';
        }
        field(50012; "Meal - Half Day Calculated"; Boolean)
        {
            Caption = 'Meal - Half Day';
        }
        field(50013; "Short Code"; Code[10])
        {
            Caption = 'Short Code';
        }
        field(50014; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(50015; Holiday; Boolean)
        {
            Caption = 'Holiday';
        }// Add changes to table fields here
    }

    var
        myInt: Integer;
}